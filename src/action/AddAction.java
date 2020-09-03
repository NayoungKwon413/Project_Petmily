package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int num1 = Integer.parseInt(request.getParameter("num1"));
		int num2 = Integer.parseInt(request.getParameter("num2"));
		request.setAttribute("result", num1+num2);
		return new ActionForward(false, "addForm.jsp");  // add.me -> 응답을 보여주는 view를 "addForm.jsp"로 설정. 
	}

}
