package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.MemberDao;

/*
  	1. 파라미터값 저장
	2. 파라미터 중 하나 없는 경우 메세지 출력
	3. 파라미터값과 db 데이터와 비교
	4. 파라미터값과 일치하는 db 데이터의 id 값
 */
public class IdAction implements Action{

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		String email = request.getParameter("email");
		String tel = request.getParameter("tel");
		String id = new MemberDao().findid(email,tel);
		if(id == null){
			String msg = "일치하는 회원정보가 없습니다. 회원가입을 시도하십시오.";
			request.setAttribute("msg", msg);
			return new ActionForward(false, "../alert5.jsp");
//			String msg = "일치하는 회원정보가 없습니다. 회원가입을 시도하십시오.";
//			String url = "joinForm.me";
//			request.setAttribute("msg", msg);
//			request.setAttribute("url", url);
//			return new ActionForward(false, "../alert.jsp");
		}else {
			request.setAttribute("id", id);
			return new ActionForward();
		}
	}
	
}
