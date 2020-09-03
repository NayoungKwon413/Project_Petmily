package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;

/*
 * ������ �ŷ��� ��� ���Ǵ� �߻� Ŭ����
  	1. �α׾ƿ����� : "�α����� �ʿ��մϴ�." �޼��� ��� �� loginForm.me ������ �̵�
	2. �α��� ����
		�Ϲݻ���� : "�����ڸ� ������ �����մϴ�" �޼��� ��� �� main.me �� ������ �̵�
	3. ������ ���� => ������ �����
		doExecute �޼��� ȣ��
 */
public abstract class AdminLoginAction implements Action {
	protected String login;
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		login = (String)request.getSession().getAttribute("login");
		if(login == null){
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "loginForm.me");
			return new ActionForward(false, "../alert.jsp");
		}
		if(!login.equals("admin")){
			request.setAttribute("msg", "�����ڸ� ������ �ŷ��Դϴ�");
			request.setAttribute("url", "home.me");
			return new ActionForward(false, "../alert.jsp");
		}
		return doExecute(request, response);
	}
	protected abstract ActionForward doExecute(HttpServletRequest request, HttpServletResponse response);
	
}