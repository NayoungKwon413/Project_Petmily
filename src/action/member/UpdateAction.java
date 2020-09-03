package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;
/*
  	1. ��� �Ķ���� ������ Member ��ü�� ����
	2. �Էµ� ��й�ȣ�� db�� ����� ��й�ȣ�� ��
		- ���� ���� ���, "��й�ȣ ����" �޼��� ��� �� updateForm.me �������� �̵�
	3. ��й�ȣ�� ��ġ�ϴ� ���, �Ķ���Ͱ��� ������ Member ��ü�� �̿��Ͽ� db ������ ����
		int MemberDao.update(Member) �޼��� �̿�
		return �� <0 => ���� ���� �޼��� ��� �� updateForm.me �� ������ �̵�
		return �� >0 => ���� ���� �޼��� ��� �� info.me �� ������ �̵� 
 */
public class UpdateAction extends UserLoginAction {
	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		String login = (String)request.getSession().getAttribute("login");
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
		
		Member db = new MemberDao().selectOne(id);
		String msg = "��й�ȣ ����"; 
		String url = "updateForm.me?id="+id;
			
		// �н����� �񱳽� ������ ��
		if(mem.getPass().equals(db.getPass())){
			int result = new MemberDao().update(mem);   // ����ڰ� �ڽ��� ������ ������ �� + �����ڰ� ������� ������ ������ �� ���
				if(login.equals("admin") && !mem.getId().equals("admin")) { // �����ڰ� �ٸ� �̿��� ������ ������ ��
					if(result > 0) {
						msg = "���� ����";
						url = "list.me";
						request.setAttribute("msg", msg);
						request.setAttribute("url", url);
						return new ActionForward(false, "../alert.jsp");
					}else {
						msg = "���� ����";
						url = "updateForm.me?id="+mem.getId();
						request.setAttribute("msg", msg);
						request.setAttribute("url", url);
						return new ActionForward(false, "../alert.jsp");
					}
				}else if(!login.equals("admin") && mem.getId().equals(login)) {  // ����ڰ� �ڽ��� ������ ������ ��
					mem.setDname(request.getParameter("dname"));
					mem.setDage(Integer.parseInt(request.getParameter("dage")));
					mem.setDsex(Integer.parseInt(request.getParameter("dsex")));
					mem.setDphoto(request.getParameter("dphoto"));
					if(result >0) {
						msg = "���� ����";
						url = "info.me?id="+mem.getId();
						request.setAttribute("msg", msg);
						request.setAttribute("url", url);
						return new ActionForward(false, "../alert.jsp");
					}else {
						msg = "���� ����";
						url = "updateForm.me?id="+mem.getId();
						request.setAttribute("msg", msg);
						request.setAttribute("url", url);
						return new ActionForward(false, "../alert.jsp");
					}
				}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
}

