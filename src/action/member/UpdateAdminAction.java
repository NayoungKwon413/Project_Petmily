package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;

public class UpdateAdminAction extends UserLoginAction {
	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		Member mem = new Member();
		mem.setId(request.getParameter("id"));
		mem.setPass(request.getParameter("pass"));
		mem.setName(request.getParameter("name"));
		mem.setEmail(request.getParameter("email"));
		mem.setTel(request.getParameter("tel"));
		Member db = new MemberDao().selectOne(id);
		String msg = "비밀번호 오류"; 
		String url = "updateForm.me?id="+id;
		if(mem.getPass().equals(db.getPass())){
			int resultadmin = new MemberDao().updatead(mem); 
			if(resultadmin > 0) {
				msg = "수정 성공";
				url = "info.me?id="+mem.getId();
				request.setAttribute("msg", msg);
				request.setAttribute("url", url);
				return new ActionForward(false, "../alert.jsp");
			}else {
				msg = "수정 실패";
				url = "updateForm.me?id="+mem.getId();
				request.setAttribute("msg", msg);
				request.setAttribute("url", url);
				return new ActionForward(false, "../alert.jsp");
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

}
