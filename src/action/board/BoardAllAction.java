package action.board;

import java.io.File;
import java.io.IOException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import action.ActionForward;
import model.Board;
import model.BoardDao;
import model.Calendar;
import model.CalendarDao;
import model.Carememo;
import model.CarememoDao;
import model.Dailycare;
import model.DailycareDao;
import model.Member;
import model.MemberDao;
import model.Reply;
import model.ReplyDao;

public class BoardAllAction {
	private BoardDao dao = new BoardDao();
	private DailycareDao ddao = new DailycareDao();
	private CarememoDao cdao = new CarememoDao();
	private CalendarDao caldao = new CalendarDao();
	private ReplyDao rdao = new ReplyDao();

	public ActionForward writeForm(HttpServletRequest request, HttpServletResponse response){
		if(logincheck(request)) {
			return new ActionForward();
		}else {
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	/*
	1. 파라미터 값을 model.Board 객체 저장
		useBean 사용 불가 : request 정보의 파라미터와 빈클래스의 프로퍼티 비교
						request 객체를 사용할 수 없음.
	2. 게시물 번호 num 현재 등록된 num 의 최대값을 조회 -> 최대값 +1 : 등록된 게시물의 번호.
		db에서 maxnum을 구해서 +1 값으로 num을 설정하기
	3. board 내용을 db에 등록하기.
		등록성공: 메세지 출력. list.do 로 이동
		등록실패: 메세지 출력. writeForm.do 로 이동
	 */
	public ActionForward write(HttpServletRequest request, HttpServletResponse response){
		String msg = "게시글 등록 실패";
		String url = "writeForm.do";
		String path = request.getServletContext().getRealPath("/") + "model2/board/file/";
		try {
			File f = new File(path);
			if(!f.exists())  f.mkdirs();
			MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024, "euc-kr");
			Board board = new Board();
			board.setId(multi.getParameter("id"));
			board.setTitle(multi.getParameter("title"));
			board.setContent(multi.getParameter("content"));
			board.setFile1(multi.getFilesystemName("file1"));
			
			int maxnum = dao.maxnum();  //현재 최대값
			board.setBoardno(++maxnum);
			if(dao.insert(board)) {
				msg = "게시글 등록 성공";
				url = "list.do";
			}
		}catch(IOException e) {
			e.printStackTrace();
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");

}

	/*
		1. 한페이지당 10건의 게시물을 출력하기.
	   	   pageNum 파라미터값을 저장 => 없는 경우는 1로 설정하기
		2. 최근 등록된 게시물이 가장 위에 배치함.
		3. db에서 해당 페이지에 출력될 내용을 조회하여 list 객체로 저장
		   list 객체 및 필요한 데이터를 request 의 객체 속성으로 등록하여 list.jsp 로 페이지 이동
	 */
	public ActionForward list(HttpServletRequest request, HttpServletResponse response) {		
		int pageNum = 1;  //페이지번호 초기화
		try {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}catch(NumberFormatException e) {}
		
		// 게시글 검색 관련 추가
		String column = request.getParameter("column");
		String search = request.getParameter("search");
		if(column == null || column.trim().equals("")) {    // column 값 선택 안함
			column = null;
			search = null;
		}
		if(search == null || search.trim().equals("")) {   // search 입력값 없는 경우
			column = null;
			search = null;
		}
		
		int limit = 10;  //한 페이지당 최대 10건 출력
		// boardcount : 등록된 전체 게시물의 건수 또는 검색된 게시물의 건수
		int boardcount = dao.boardCount(column, search); 
		// list : 화면에 출력될 내용을 저장. 전체 게시물 저장 또는 검색시 해당하는 게시물만 저장
		List<Board> list = dao.list(pageNum, limit, column, search);
		int maxpage = (int)((double)boardcount/limit+0.95);  //전체 마지막 페이지
		int startpage = ((int)(pageNum/10.0+0.9)-1)*10+1;
		int endpage = startpage + 9;
		int boardnum = boardcount - (pageNum-1) * limit;
	 	if(endpage > maxpage) endpage = maxpage;
	 	
	 	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	 	String today = sf.format(new Date());
	 	
	 	request.setAttribute("boardcount", boardcount);
	 	request.setAttribute("pageNum", pageNum);
	 	request.setAttribute("limit", limit);
	 	request.setAttribute("list", list);
	 	request.setAttribute("maxpage", maxpage);
	 	request.setAttribute("startpage", startpage);
	 	request.setAttribute("endpage", endpage);
	 	request.setAttribute("boardnum", boardnum);
	 	request.setAttribute("today", today);
	 	
		return new ActionForward();
	}

	/*
	1. num 파라미터 저장
	2. num 값의 게시물을 db에서 조회하기
	3. num 값의 게시물의 조회수 증가시키기
	4. 조회된 게시물 화면에 출력
	 */
	public ActionForward info(HttpServletRequest request, HttpServletResponse response) {
		int boardno = Integer.parseInt(request.getParameter("boardno"));
//		int replyno = Integer.parseInt(request.getParameter("replyno"));
		Board b = dao.selectOne(boardno);
//		Reply r = rdao.selectOne(replyno);
		if(request.getRequestURI().contains("board/info.do")) {
			dao.readcntAdd(boardno);
		}
		int replycount = rdao.replycount(boardno); 
		request.setAttribute("b", b);	
		request.setAttribute("replycount", replycount);
		request.setAttribute("replist", rdao.replist(boardno));
		return new ActionForward();
	}

	/*
	1. 파라미터 값을 Board 객체에 저장하기 => useBean 태그 사용
	     원글정보 : num, grp, grplevel, grpstep
	     답글정보 : name, pass, subject, content => 등록정보
	2. 같은 grp 값을 사용하는 게시물들의 grpstep 값을 1 증가하기
	   void VoardDao.grpStepAdd(grp, grpstep)
	3. Board 객체를 db에 insert 하기
	   num : maxnum +1
	   grp : 원글과 동일
	   grplevel : 원글+1
	   grpstep : 원글 +1
	4. 등록 성공시 : "답변등록 완료"메세지 출력후, list.jsp 로 페이지 이동
	     등록 실패시 : "답변등록시 오류발생"메세지 출력후, replyForm.jsp 로 페이지 이동
	 */
	public ActionForward reply(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String msg = "";
		String url = "";
		Reply r = new Reply();
		r.setBoardno(Integer.parseInt(request.getParameter("boardno")));
		r.setId(request.getParameter("id"));
		r.setRepcontent(request.getParameter("repcontent"));
		int maxnum = rdao.maxnum();
		r.setReplyno(++maxnum);
		msg = "댓글 등록 실패";
		url = "info.do?boardno="+r.getBoardno();
		if(rdao.insert(r)) {
			msg = "댓글 등록 성공";
			url = "info.do?boardno="+r.getBoardno();
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

	/*
	1. 파라미터 정보들을 Board 객체 저장
	2. 비밀번호 검증
		비밀번호 일치하는 경우 수정
			-파라미터의 내용으로 해당 게시물의 내용을 수정하기
			-첨부파일의 변경이 없는 경우 file2 파라미터 내용을 다시 저장하기
		비밀번호가 불일치할 경우
			-비밀번호 오류 메세지를 출력하고, updateForm.jsp 로 페이지 이동
	3. 수정 성공 : 수정 성공 메세지 출력 후 info.jsp 페이지 이동
	     수정 실패 : 수정 실패 메세지 출력 후 updateForm.jsp 페이지 이동
	 */
	public ActionForward update(HttpServletRequest request, HttpServletResponse response) {
		String login = (String)request.getSession().getAttribute("login");
//		String id = request.getParameter("id");
//		int boardno = Integer.parseInt(request.getParameter("boardno"));
		String msg = "";
		String url = "";
		String path = request.getServletContext().getRealPath("/") + "model2/board/file/";
//		if(login == null) {
//			msg = "로그인 후 거래하세요";
//			url = "../member/loginForm.me";
//			return new ActionForward(false, "../alert.jsp");
//		}else if(login != id) {
//			msg = "본인의 게시글만 수정 가능합니다.";
//			url = "info.do?boardno="+boardno;
//			return new ActionForward(false, "../alert.jsp");
//		}
		
		try {
			MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024, "euc-kr");
			Board b = new Board();
			b.setBoardno(Integer.parseInt(multi.getParameter("boardno")));
			b.setId(multi.getParameter("id"));
			b.setTitle(multi.getParameter("title"));
			b.setContent(multi.getParameter("content"));
			b.setFile1(multi.getFilesystemName("file1"));
			if(b.getFile1() == null || b.getFile1().equals("")){  //첨부파일 수정을 하지 않았을 경우
				b.setFile1(multi.getParameter("file2"));
			}
			
			Board db = dao.selectOne(b.getBoardno());
			
//			if(b.getPass().equals(db.getPass())) {
				if(dao.update(b)) {
					msg = "게시글 수정 완료";
					url = "info.do?boardno="+b.getBoardno();
				}else {
					msg = "게시글 수정 실패";
					url = "updateForm.do?boardno="+b.getBoardno();
				}
//			}else {
//				msg = "비밀번호 오류";
//				url = "updateForm.do?boardno="+b.getBoardno();
//			}
		}catch(IOException e) {
			e.printStackTrace();
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

	
	public ActionForward delete(HttpServletRequest request, HttpServletResponse response) {
		String login = (String)request.getSession().getAttribute("login");
		String id = request.getParameter("id");
		int boardno = Integer.parseInt(request.getParameter("boardno"));
		String msg = "";
		String url = "";
//		if(login == null) {
//			msg = "로그인 후 거래하세요";
//			url = "../member/loginForm.me";
//			return new ActionForward(false, "../alert.jsp");
//		}else if(login != id) {
//			msg = "본인의 게시글만 삭제 가능합니다.";
//			url = "info.do?boardno="+boardno;
//			return new ActionForward(false, "../alert.jsp");
//		}
//		if (login == id) {
			Board db = dao.selectOne(boardno);
			if(db == null){
				msg = "없는 게시글입니다.";
				url = "list.do";
			}else{
					if(dao.delete(boardno)){
						msg = "게시글 삭제 완료";
						url = "list.do";
					}else{
						msg = "게시글 삭제 실패";
						url = "info.do?boardno="+boardno;
					}
				}
			
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
//		}
	
	}
	
	public ActionForward repdelete(HttpServletRequest request, HttpServletResponse response) {
		int boardno = Integer.parseInt(request.getParameter("boardno"));
		int replyno = Integer.parseInt(request.getParameter("replyno"));
		String msg = "댓글 삭제 실패";
		String url = "info.do?boardno=" + boardno;
		if(rdao.delete(replyno, boardno)) {
			msg = "댓글 삭제 완료";
			url = "info.do?boardno=" + boardno;
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
		}
	
	public ActionForward imgupload(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String path = request.getServletContext().getRealPath("/") + "model2/board/imgfile/";
		File f = new File(path);
		if(!f.exists())  f.mkdirs();
		MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024, "euc-kr");
		String fileName = multi.getFilesystemName("upload");
		request.setAttribute("fileName", fileName);
		request.setAttribute("CKEditorFuncNum", request.getParameter("CKEditorFuncNum"));
		return new ActionForward(false, "ckeditor.jsp");
	}
	
	
	private boolean logincheck(HttpServletRequest request) {
		String login = (String)request.getSession().getAttribute("login");
		if(login == null) {
			request.setAttribute("msg", "로그인 후 거래하세요");
			request.setAttribute("url", "../member/loginForm.me");
			return false;
		}
		return true;
	}
	
	public ActionForward dcdetail(HttpServletRequest request, HttpServletResponse response) {
		if(logincheck(request)) {
			String id = (String)request.getSession().getAttribute("login");
			Member mem = new MemberDao().selectOne(id);
			request.setAttribute("mem", mem);
			request.setAttribute("memolist", cdao.memolist(id));
			
			String search = request.getParameter("search");
			if(search == null || search.trim().equals("")) {   // search 입력값 없는 경우
				Date today = new Date();
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
				search = format.format(today);
				
//				String msg = "날짜를 설정해주세요";
//				String url = "dcdetail.do";
//	   		    request.setAttribute("msg", msg);
//				request.setAttribute("url", "../member/info.me?id="+id);
//				return new ActionForward(false, "../alert.jsp");
			}
			int dccount = ddao.dccount(search, id);
			List<Dailycare> dclist = new DailycareDao().selectdc(search, id);
			request.setAttribute("dclist", dclist);
			request.setAttribute("dccount", dccount);
			
			return new ActionForward();
			
		}else {
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	public ActionForward dcinsert(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String msg = "등록 실패";
		String url = "dcinsertForm.do";
		Dailycare dc = new Dailycare();
		dc.setCaredate(request.getParameter("caredate"));
		dc.setId(request.getParameter("id"));
		dc.setWeight(Double.parseDouble(request.getParameter("weight")));
		dc.setBcs(Integer.parseInt(request.getParameter("bcs")));
		if(ddao.insert(dc)) {
			msg = "데이터 등록 성공";
			request.setAttribute("msg", msg);
			return new ActionForward(false, "../alert2.jsp");
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	public ActionForward dcmemo(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String msg = "등록 실패";
		String url = "dcmemoForm.do";
		Carememo cm = new Carememo();
		cm.setId(request.getParameter("id"));
		cm.setMemo(request.getParameter("memo"));
		
		int maxnum = cdao.maxnum(cm);
//		if(cdao.selectid(cm)) {
//			cm.setMemono(1);
//		}else {
			cm.setMemono(++maxnum);
//		}
		
		if(cdao.insert(cm)) {
			msg = "메모 등록 성공";
			request.setAttribute("msg", msg);
			return new ActionForward(false, "../alert2.jsp");
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
		
	}
	
	public ActionForward calendar(HttpServletRequest request, HttpServletResponse response) {
		if(logincheck(request)) {
			return new ActionForward();
		}else {
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	public ActionForward dcupdate(HttpServletRequest request, HttpServletResponse response) {
		String msg = "수정 실패";
		String url = "dcupdateForm.do";
		Dailycare dc = new Dailycare();
		dc.setCaredate(request.getParameter("caredate"));
		dc.setId(request.getParameter("id"));
		dc.setWeight(Double.parseDouble(request.getParameter("weight")));
		dc.setBcs(Integer.parseInt(request.getParameter("bcs")));
		if(ddao.update(dc)) {
			msg = "데이터 수정 완료";
			request.setAttribute("msg", msg);
			return new ActionForward(false, "../alert2.jsp");
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	
	}
	
	public ActionForward addplan(HttpServletRequest request, HttpServletResponse response) {
		String msg = "일정 등록 실패";
		String url = "addplanForm.do";
		Calendar cal = new Calendar();
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		cal.setId(request.getParameter("id"));
		int maxcalno = caldao.maxcalno(cal);
		cal.setCalno(++maxcalno);
		try {
			cal.setStartdate(dateformat.parse(request.getParameter("startdate")));
			cal.setEnddate(dateformat.parse(request.getParameter("enddate")));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		cal.setStarttime(request.getParameter("starttime"));
		cal.setEndtime(request.getParameter("endtime"));
		cal.setPlan(request.getParameter("plan"));
		if(caldao.insert(cal)) {
			msg = "일정 등록 성공";
			request.setAttribute("msg", msg);
			return new ActionForward(false, "../alert3.jsp");
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	public ActionForward repupdateForm(HttpServletRequest request, HttpServletResponse response) {
		int boardno = Integer.parseInt(request.getParameter("boardno"));
		int replyno = Integer.parseInt(request.getParameter("replyno"));
		Reply r = rdao.selectOne(replyno);
		request.setAttribute("r", r);	
		return new ActionForward();
	}
	
	public ActionForward repupdate(HttpServletRequest request, HttpServletResponse response) {
		Reply r = new Reply();
		r.setBoardno(Integer.parseInt(request.getParameter("boardno")));
		r.setReplyno(Integer.parseInt(request.getParameter("replyno")));
		r.setId(request.getParameter("id"));
		r.setRepcontent(request.getParameter("repcontent"));
		String msg = "댓글 수정 실패";
		String url = "repupdateForm.do";
		if(rdao.update(r)) {
			msg = "댓글 수정 완료";
			request.setAttribute("msg", msg);
			return new ActionForward(false, "../alert4.jsp");
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	public ActionForward planview(HttpServletRequest request, HttpServletResponse response) {
		int calno = Integer.parseInt(request.getParameter("calno"));
		String id = request.getParameter("id");
		Calendar cal = caldao.selectOne(calno, id);
		request.setAttribute("cal", cal);
		return new ActionForward();
	}
	
	public ActionForward plandelete(HttpServletRequest request, HttpServletResponse response) {
		int calno = Integer.parseInt(request.getParameter("calno"));
		String id = request.getParameter("id");
		String msg = "일정 삭제 실패";
		String url = "planview.do?calno="+calno+"&id="+id;
		if(caldao.delete(calno, id)) {
			msg = "일정 삭제 성공";
			request.setAttribute("msg", msg);
			return new ActionForward(false, "../alert3.jsp");
		}
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
	}
	
	public ActionForward planupdate(HttpServletRequest request, HttpServletResponse response) {
		Calendar cal = new Calendar();
		cal.setCalno(Integer.parseInt(request.getParameter("calno")));
		cal.setId(request.getParameter("id"));
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			cal.setStartdate(dateformat.parse(request.getParameter("startdate")));
			cal.setEnddate(dateformat.parse(request.getParameter("enddate")));
		} catch (ParseException e) {	
			e.printStackTrace();
		}
		cal.setStarttime(request.getParameter("starttime"));
		cal.setEndtime(request.getParameter("endtime"));
		cal.setPlan(request.getParameter("plan"));
		String msg = "일정 수정 실패";
		String url = "planupdateForm.do?calno="+cal.getCalno()+"&id="+cal.getId();
		if(caldao.update(cal)) {
			msg = "일정 수정 성공";
			request.setAttribute("msg", msg);
			return new ActionForward(false, "../alert3.jsp");
		}
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
	}
	
//	public ActionForward dcgraph(HttpServletRequest request, HttpServletResponse response) {
//		//list : [{caredate:'2020-01', weight:2.3, bcs:'verythin'}], [{...}]
//		String id = (String)request.getSession().getAttribute("login");
////		String id = request.getParameter("id");
//		List<Map<String, Integer>> list = ddao.dcgraph(id);
//		StringBuilder json = new StringBuilder("[");
//		int i=0;
//		for(Map<String, Integer> m : list) {
//			for(Map.Entry<String, Integer> me : m.entrySet()) {
//				if(me.getKey().equals("caredate"))
//					json.append("{\"caredate\":\"" + me.getValue() + "\",");
//				if(me.getKey().equals("weight"))
//					json.append("\"weight\":" + me.getValue() + ",");
//				if(me.getKey().equals("bcs"))
//					json.append("\"bcs\":\"" + me.getValue() + "\"}");
//			}
//			i++;
//			if(i<list.size()) json.append(",");
//		}
//		json.append("]");
//		request.setAttribute("json", json.toString().trim());
//		return new ActionForward(false, "dcgraph.jsp");
//	}

//	public ActionForward dcgraph(HttpServletRequest request, HttpServletResponse response) {
//		// list : [{date:2020-05-01, cnt:9}], [{date:2020-05-02, cnt:3}] ...
//		String id = request.getParameter("id");
//		List<Map<String, Integer>> list = ddao.dcgraph(id);
//		request.setAttribute("list", list);   // Map으로 연결된 list를 graph2.jsp 로 보냄 
//		return new ActionForward();
//	}
	
}
