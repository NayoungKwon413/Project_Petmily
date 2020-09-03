package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;
/*
 * 1~2번 -> UserLoginAction 상속을 통해 처리
  	1. 로그아웃 상태 : '로그인하세요' 출력 후 loginForm.jsp 페이지 이동
	2. 일반사용자인 경우
		- id 파라미터정보와 login 정보가 다른 경우 
			'본인만 탈퇴 가능합니다' 메세지 출력 후 main.jsp 페이지 이동
 * DeleteAction 으로 처리	
	3. 일반사용자인 경우
		- id, pass 정보를 이용하여 비밀번호 검증
		비밀번호 불일치 : '비밀번호가 틀립니다' 메세지 출력 후 deleteForm.jsp 페이지로 이동
	     관리자인 경우
	     - id가 관리자인 경우 탈퇴 불가 메세지 출력후 list.jsp 페이지로 이동
	4. 탈퇴 성공 : member db에서 delete 처리 완료
		일반사용자 : 로그아웃 실행 => 탈퇴완료 메세지 출력 => loginForm.jsp 페이지로 이동
		관리자      : 탈퇴완료 메세지 출력 => list.jsp 로 페이지 이동
	5. 탈퇴 실패 : member db에서 delete 처리 시 오류 발생
		일반사용자 : 탈퇴실패 메세지 출력 => info.jsp 로 페이지 이동
		관리자      : 탈퇴살패 메세지 출력 => list.jsp 로 페이지 이동
 */
public class DeleteAction extends UserLoginAction {
	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		String pass = request.getParameter("pass");
		String msg = null;
		String url = null;				
			if(!login.equals("admin")){ //일반사용자이면서
				if(!login.equals(id)){  //로그인 정보와 id 파라미터값이 다른 경우
					msg = "본인만 탈퇴 가능합니다";
					url = "main.me";
				}else{                  //로그인 정보와 id 파라미터값이 같은 경우
					MemberDao dao = new MemberDao();
					Member mem = dao.selectOne(login);            //일반사용자일 경우 탈퇴는 로그인 당사자만 가능
					if(!pass.equals(mem.getPass())){              //pass 파라미터값과 db 패스워드 정보가 다른 경우
						msg = "비밀번호가 틀립니다";
						url = "deleteForm.me?id="+id;
					}else{                                        //pass 파라미터값과 db 패스 정보가 같은 경우 => 탈퇴실행
						if(dao.deletePass(login) > 0) {           // (일반)탈퇴 성공
							msg = "탈퇴가 완료되었습니다";
							url = "loginForm.me";
							request.getSession().invalidate();    // 로그아웃
						}else{                                    // (일반)탈퇴 실패
							msg = "탈퇴 시 오류가 발생했습니다";
							url = "info.me?id="+id;
						}
					}
				}
			}else{                                                //관리자인 경우
				if(id.equals("admin")){                           //id 파라미터 값이 admin 인 경우 
					msg = "관리자는 탈퇴할 수 없습니다";
					url = "list.me";
				}else{                                            //id 파라미터 값이 admin 이 아닌 경우
					MemberDao dao = new MemberDao();
					if(dao.deletePass(id) > 0) {                  // (관리자)탈퇴 성공
						msg = "탈퇴가 완료되었습니다";
						url = "list.me";
					}else{                                        // (관리자)탈퇴 실패
						msg = "탈퇴 시 오류가 발생했습니다";
						url = "list.me";
					}
				}
			}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

}
