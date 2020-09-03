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
	1. �Ķ���� ���� model.Board ��ü ����
		useBean ��� �Ұ� : request ������ �Ķ���Ϳ� ��Ŭ������ ������Ƽ ��
						request ��ü�� ����� �� ����.
	2. �Խù� ��ȣ num ���� ��ϵ� num �� �ִ밪�� ��ȸ -> �ִ밪 +1 : ��ϵ� �Խù��� ��ȣ.
		db���� maxnum�� ���ؼ� +1 ������ num�� �����ϱ�
	3. board ������ db�� ����ϱ�.
		��ϼ���: �޼��� ���. list.do �� �̵�
		��Ͻ���: �޼��� ���. writeForm.do �� �̵�
	 */
	public ActionForward write(HttpServletRequest request, HttpServletResponse response){
		String msg = "�Խñ� ��� ����";
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
			
			int maxnum = dao.maxnum();  //���� �ִ밪
			board.setBoardno(++maxnum);
			if(dao.insert(board)) {
				msg = "�Խñ� ��� ����";
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
		1. ���������� 10���� �Խù��� ����ϱ�.
	   	   pageNum �Ķ���Ͱ��� ���� => ���� ���� 1�� �����ϱ�
		2. �ֱ� ��ϵ� �Խù��� ���� ���� ��ġ��.
		3. db���� �ش� �������� ��µ� ������ ��ȸ�Ͽ� list ��ü�� ����
		   list ��ü �� �ʿ��� �����͸� request �� ��ü �Ӽ����� ����Ͽ� list.jsp �� ������ �̵�
	 */
	public ActionForward list(HttpServletRequest request, HttpServletResponse response) {		
		int pageNum = 1;  //��������ȣ �ʱ�ȭ
		try {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}catch(NumberFormatException e) {}
		
		// �Խñ� �˻� ���� �߰�
		String column = request.getParameter("column");
		String search = request.getParameter("search");
		if(column == null || column.trim().equals("")) {    // column �� ���� ����
			column = null;
			search = null;
		}
		if(search == null || search.trim().equals("")) {   // search �Է°� ���� ���
			column = null;
			search = null;
		}
		
		int limit = 10;  //�� �������� �ִ� 10�� ���
		// boardcount : ��ϵ� ��ü �Խù��� �Ǽ� �Ǵ� �˻��� �Խù��� �Ǽ�
		int boardcount = dao.boardCount(column, search); 
		// list : ȭ�鿡 ��µ� ������ ����. ��ü �Խù� ���� �Ǵ� �˻��� �ش��ϴ� �Խù��� ����
		List<Board> list = dao.list(pageNum, limit, column, search);
		int maxpage = (int)((double)boardcount/limit+0.95);  //��ü ������ ������
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
	1. num �Ķ���� ����
	2. num ���� �Խù��� db���� ��ȸ�ϱ�
	3. num ���� �Խù��� ��ȸ�� ������Ű��
	4. ��ȸ�� �Խù� ȭ�鿡 ���
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
	1. �Ķ���� ���� Board ��ü�� �����ϱ� => useBean �±� ���
	     �������� : num, grp, grplevel, grpstep
	     ������� : name, pass, subject, content => �������
	2. ���� grp ���� ����ϴ� �Խù����� grpstep ���� 1 �����ϱ�
	   void VoardDao.grpStepAdd(grp, grpstep)
	3. Board ��ü�� db�� insert �ϱ�
	   num : maxnum +1
	   grp : ���۰� ����
	   grplevel : ����+1
	   grpstep : ���� +1
	4. ��� ������ : "�亯��� �Ϸ�"�޼��� �����, list.jsp �� ������ �̵�
	     ��� ���н� : "�亯��Ͻ� �����߻�"�޼��� �����, replyForm.jsp �� ������ �̵�
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
		msg = "��� ��� ����";
		url = "info.do?boardno="+r.getBoardno();
		if(rdao.insert(r)) {
			msg = "��� ��� ����";
			url = "info.do?boardno="+r.getBoardno();
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

	/*
	1. �Ķ���� �������� Board ��ü ����
	2. ��й�ȣ ����
		��й�ȣ ��ġ�ϴ� ��� ����
			-�Ķ������ �������� �ش� �Խù��� ������ �����ϱ�
			-÷�������� ������ ���� ��� file2 �Ķ���� ������ �ٽ� �����ϱ�
		��й�ȣ�� ����ġ�� ���
			-��й�ȣ ���� �޼����� ����ϰ�, updateForm.jsp �� ������ �̵�
	3. ���� ���� : ���� ���� �޼��� ��� �� info.jsp ������ �̵�
	     ���� ���� : ���� ���� �޼��� ��� �� updateForm.jsp ������ �̵�
	 */
	public ActionForward update(HttpServletRequest request, HttpServletResponse response) {
		String login = (String)request.getSession().getAttribute("login");
//		String id = request.getParameter("id");
//		int boardno = Integer.parseInt(request.getParameter("boardno"));
		String msg = "";
		String url = "";
		String path = request.getServletContext().getRealPath("/") + "model2/board/file/";
//		if(login == null) {
//			msg = "�α��� �� �ŷ��ϼ���";
//			url = "../member/loginForm.me";
//			return new ActionForward(false, "../alert.jsp");
//		}else if(login != id) {
//			msg = "������ �Խñ۸� ���� �����մϴ�.";
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
			if(b.getFile1() == null || b.getFile1().equals("")){  //÷������ ������ ���� �ʾ��� ���
				b.setFile1(multi.getParameter("file2"));
			}
			
			Board db = dao.selectOne(b.getBoardno());
			
//			if(b.getPass().equals(db.getPass())) {
				if(dao.update(b)) {
					msg = "�Խñ� ���� �Ϸ�";
					url = "info.do?boardno="+b.getBoardno();
				}else {
					msg = "�Խñ� ���� ����";
					url = "updateForm.do?boardno="+b.getBoardno();
				}
//			}else {
//				msg = "��й�ȣ ����";
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
//			msg = "�α��� �� �ŷ��ϼ���";
//			url = "../member/loginForm.me";
//			return new ActionForward(false, "../alert.jsp");
//		}else if(login != id) {
//			msg = "������ �Խñ۸� ���� �����մϴ�.";
//			url = "info.do?boardno="+boardno;
//			return new ActionForward(false, "../alert.jsp");
//		}
//		if (login == id) {
			Board db = dao.selectOne(boardno);
			if(db == null){
				msg = "���� �Խñ��Դϴ�.";
				url = "list.do";
			}else{
					if(dao.delete(boardno)){
						msg = "�Խñ� ���� �Ϸ�";
						url = "list.do";
					}else{
						msg = "�Խñ� ���� ����";
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
		String msg = "��� ���� ����";
		String url = "info.do?boardno=" + boardno;
		if(rdao.delete(replyno, boardno)) {
			msg = "��� ���� �Ϸ�";
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
			request.setAttribute("msg", "�α��� �� �ŷ��ϼ���");
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
			if(search == null || search.trim().equals("")) {   // search �Է°� ���� ���
				Date today = new Date();
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
				search = format.format(today);
				
//				String msg = "��¥�� �������ּ���";
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
		String msg = "��� ����";
		String url = "dcinsertForm.do";
		Dailycare dc = new Dailycare();
		dc.setCaredate(request.getParameter("caredate"));
		dc.setId(request.getParameter("id"));
		dc.setWeight(Double.parseDouble(request.getParameter("weight")));
		dc.setBcs(Integer.parseInt(request.getParameter("bcs")));
		if(ddao.insert(dc)) {
			msg = "������ ��� ����";
			request.setAttribute("msg", msg);
			return new ActionForward(false, "../alert2.jsp");
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	public ActionForward dcmemo(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String msg = "��� ����";
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
			msg = "�޸� ��� ����";
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
		String msg = "���� ����";
		String url = "dcupdateForm.do";
		Dailycare dc = new Dailycare();
		dc.setCaredate(request.getParameter("caredate"));
		dc.setId(request.getParameter("id"));
		dc.setWeight(Double.parseDouble(request.getParameter("weight")));
		dc.setBcs(Integer.parseInt(request.getParameter("bcs")));
		if(ddao.update(dc)) {
			msg = "������ ���� �Ϸ�";
			request.setAttribute("msg", msg);
			return new ActionForward(false, "../alert2.jsp");
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	
	}
	
	public ActionForward addplan(HttpServletRequest request, HttpServletResponse response) {
		String msg = "���� ��� ����";
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
			msg = "���� ��� ����";
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
		String msg = "��� ���� ����";
		String url = "repupdateForm.do";
		if(rdao.update(r)) {
			msg = "��� ���� �Ϸ�";
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
		String msg = "���� ���� ����";
		String url = "planview.do?calno="+calno+"&id="+id;
		if(caldao.delete(calno, id)) {
			msg = "���� ���� ����";
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
		String msg = "���� ���� ����";
		String url = "planupdateForm.do?calno="+cal.getCalno()+"&id="+cal.getId();
		if(caldao.update(cal)) {
			msg = "���� ���� ����";
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
//		request.setAttribute("list", list);   // Map���� ����� list�� graph2.jsp �� ���� 
//		return new ActionForward();
//	}
	
}
