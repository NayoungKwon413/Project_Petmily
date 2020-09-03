package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.Member;
import model.MemberDao;
/*
  	1. 파라미터 정보를 Member에 저장
	2. Member 객체의 정보를 db 저장
	3. 회원가입 성공시 loginForm.me 로 페이지 이동
	4. 회원가입 실패시 joinForm.me 로 페이지 이동
 */
public class JoinAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Member mem = new Member();
		mem.setId(request.getParameter("id"));
		mem.setPass(request.getParameter("pass"));
		mem.setName(request.getParameter("name"));
		mem.setEmail(request.getParameter("email"));
		mem.setTel(request.getParameter("tel"));
		mem.setDname(request.getParameter("dname"));
		mem.setDage(Integer.parseInt(request.getParameter("dage")));
		mem.setDsex(Integer.parseInt(request.getParameter("dsex")));
		mem.setDphoto(request.getParameter("dphoto"));
		
		String msg = "회원가입 실패";
		String url = "joinForm.me";
		MemberDao dao = new MemberDao();  //model 클래스
		int result = dao.insert(mem);   //insert 메서드는 MemberDao의 멤버. 접근제어자는 public 리턴값은 int. 매개변수는  Member
		if(result > 0){
			msg = mem.getName() + "님 회원 가입 완료";
			url = "loginForm.me";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

}
