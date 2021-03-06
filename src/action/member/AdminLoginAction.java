package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;

/*
 * 관리자 거래인 경우 사용되는 추상 클래스
  	1. 로그아웃상태 : "로그인이 필요합니다." 메세지 출력 후 loginForm.me 페이지 이동
	2. 로그인 상태
		일반사용자 : "관리자만 접근이 가능합니다" 메세지 출력 후 main.me 로 페이지 이동
	3. 관리자 상태 => 정당한 사용자
		doExecute 메서드 호출
 */
public abstract class AdminLoginAction implements Action {
	protected String login;
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		login = (String)request.getSession().getAttribute("login");
		if(login == null){
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "loginForm.me");
			return new ActionForward(false, "../alert.jsp");
		}
		if(!login.equals("admin")){
			request.setAttribute("msg", "관리자만 가능한 거래입니다");
			request.setAttribute("url", "home.me");
			return new ActionForward(false, "../alert.jsp");
		}
		return doExecute(request, response);
	}
	protected abstract ActionForward doExecute(HttpServletRequest request, HttpServletResponse response);
	
}
