package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
//로그인 상태가 필수인 경우 -> 앞으로 UserLoginAction 클래스를 상속받아 사용하면 됨.
public abstract class UserLoginAction implements Action {
	// protected : 다른 패키지에 있더라도 상속간계라면 사용할 수 있음
	protected String login;
	protected String id;
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		login = (String)request.getSession().getAttribute("login");
		id = request.getParameter("id");
		if(login == null) {  //로그인한 상태 아닐 경우
			request.setAttribute("msg", "로그인 후 거래하세요");
			request.setAttribute("url", "loginForm.me");
			return new ActionForward(false, "../alert.jsp");
		}
		if(id != null && !id.equals(login) && !login.equals("admin")) {  //로그인 정보와 입력 id가 같지 않고, 로그인한 id가 "admin"도 아닐 경우
			request.setAttribute("msg", "본인 거래만 가능합니다");
			request.setAttribute("url", "main.me");
			return new ActionForward(false, "../alert.jsp");
		}
		if(id == null || id.trim().equals("")) id = login;
		
		return doExecute(request, response);
	}
	protected abstract ActionForward doExecute(HttpServletRequest request, HttpServletResponse response);
}
