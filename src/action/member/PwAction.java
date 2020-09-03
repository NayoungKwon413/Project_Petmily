package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.MemberDao;

public class PwAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String tel = request.getParameter("tel");
		String pw = new MemberDao().findpw(id, email, tel);
		if(pw != null) {
			request.setAttribute("pw", pw);
			return new ActionForward();
		}
			String msg = "일치하는 회원 정보가 없습니다. 회원가입을 시도하십시오.";
			String url = "joinForm.jsp";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert5.jsp");
	}

}
