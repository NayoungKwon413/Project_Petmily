package action;

public class ActionForward {
	private boolean redirect;
	private String view;
	
	public ActionForward() {}
	
	public ActionForward(boolean redirect, String view) {
		this.redirect = redirect;  //false
		this.view = view;          
	}
	//setter, getter
	public boolean isRedirect() {   //getProperty 메서드가 맞으나 , 리턴타입이 boolean이기 때문에 isRedirect()로 표기
		return redirect;
	}

	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}

	public String getView() {
		return view;
	}

	public void setView(String view) {
		this.view = view;
	}
	
}
