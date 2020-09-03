package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
/*
 	1. session 로그인 정보 제거
	2. loginForm.jsp 로 페이지 이동
 */
public class LogoutAction extends UserLoginAction {
	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().invalidate();
		return new ActionForward(true, "loginForm.me");
	}

}
