package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.Member;
import model.MemberDao;
/*
  	1. �Ķ���� ������ Member�� ����
	2. Member ��ü�� ������ db ����
	3. ȸ������ ������ loginForm.me �� ������ �̵�
	4. ȸ������ ���н� joinForm.me �� ������ �̵�
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
		
		String msg = "ȸ������ ����";
		String url = "joinForm.me";
		MemberDao dao = new MemberDao();  //model Ŭ����
		int result = dao.insert(mem);   //insert �޼���� MemberDao�� ���. ���������ڴ� public ���ϰ��� int. �Ű�������  Member
		if(result > 0){
			msg = mem.getName() + "�� ȸ�� ���� �Ϸ�";
			url = "loginForm.me";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

}