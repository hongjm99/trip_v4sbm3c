package dev.mvc.manager;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.tool.Tool;

@Controller
public class ManagerCont {
  @Autowired
  @Qualifier("dev.mvc.manager.ManagerProc") // "dev.mvc.manager.ManagerProc"라고 명명된 클래스
  private ManagerProcInter managerProc; // ManagerProcInter를 구현한 ManagerProc 클래스의 객체를 자동으로 생성하여 할당
  
  public ManagerCont() {
    System.out.println("-> ManagerCont created.");
  }
  
  /**
   * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근
   * POST → url → GET → 데이터 전송
   * @return
   */
  @RequestMapping(value="/manager/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  
//  /**
//   * 로그인 폼
//   * http://localhost:9091/manager/login.do
//   * @return
//   */
//  @RequestMapping(value="/manager/login.do", method=RequestMethod.GET)
//  public ModelAndView login() {
//    ModelAndView mav = new ModelAndView();
//    
//    mav.setViewName("/manager/login_form"); // /WEB-INF/views/manager/login_form.jsp
//    
//    return mav;
//  }

//  /**
//   * 로그인 처리
//   * http://localhost:9091/manager/login.do
//   * @return
//   */
//  @RequestMapping(value="/manager/login.do", method=RequestMethod.POST)
//  public ModelAndView login(HttpSession session, ManagerVO managerVO) {
//    ModelAndView mav = new ModelAndView();
//    
//    int cnt = this.managerProc.login(managerVO);
//    
//    if (cnt == 1) { // 로그인 성공, 관리자는 id를 입력하여 로그인하였음으로 id를 가지고 관리자 정보를 조회
//      ManagerVO managerVO_read = this.managerProc.read_by_id(managerVO.getId()); // 관리자 정보 읽기
//      // session:  website 전체에서 공유되는 변수로 서버의 메모리상에 로그아웃 시점까지 유지됨.
//      session.setAttribute("managerno", managerVO_read.getManagerno()); // 서버의 메모리에 기록
//      session.setAttribute("manager_id", managerVO_read.getId());
//      session.setAttribute("manager_mname", managerVO_read.getMname());
//      session.setAttribute("manager_grade", managerVO_read.getGrade());
//
//      mav.setViewName("redirect:/index.do"); // 시작 페이지
//    } else {  // 로그인 실패
//      // /WEB-INF/views/manager/login_fail_msg.jsp
//      // POST 방식에서는 jsp에서 <c:import 태그가 실행이 안됨.
//      // mav.setViewName("/manager/login_fail_msg");   
//
//      mav.addObject("url", "/manager/login_fail_msg"); // /WEB-INF/views/manager/login_fail_msg.jsp
//      mav.setViewName("redirect:/manager/msg.do");   // POST -> url -> GET
//    }
//        
//    return mav;
//  }
  
  /**
   * 로그아웃 처리
   * @param session
   * @return
   */
  @RequestMapping(value="/manager/logout.do", method=RequestMethod.GET)
  public ModelAndView logout(HttpSession session){
    ModelAndView mav = new ModelAndView();
    session.invalidate(); // 모든 session 변수 삭제
    
    mav.setViewName("redirect:/index.do"); 
    
    return mav;
  }
  
  /**
   * Cookie 로그인 폼
   * http://localhost:9091/manager/login.do
   * @return
   */
  @RequestMapping(value="/manager/login.do", method=RequestMethod.GET)
  public ModelAndView login() {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/manager/login_form_ck"); // /WEB-INF/views/manager/login_form_ck.jsp
    
    return mav;
  }
  
  /**
  * Cookie 기반 로그인 처리
  * @param request Cookie를 읽기위해 필요
  * @param response Cookie를 쓰기위해 필요
  * @param session 로그인 정보를 메모리에 기록
  * @param id  회원 아이디
  * @param passwd 회원 패스워드
  * @param id_save 회원 아이디 Cookie에 저장 여부
  * @param passwd_save 패스워드 Cookie에 저장 여부
  * @param id_save 폼에 입력된 id 저장 여부
  * @param passwd_save 폼에 입력된 passwd 저장 여부
  * @return
  */
  // http://localhost:9091/manager/login.do 
  @RequestMapping(value = "/manager/login.do", 
                            method = RequestMethod.POST)
  public ModelAndView login_proc(
                            HttpServletRequest request,
                            HttpServletResponse response,
                            HttpSession session,
                            ManagerVO managerVO, String id_save, String passwd_save) {
    ModelAndView mav = new ModelAndView();
   
    int cnt = managerProc.login(managerVO);
    if (cnt == 1) { // 로그인 성공시 회원 정보 조회
      ManagerVO managerVO_read = managerProc.read_by_id(managerVO.getId()); // DBMS에서 id를 이용한 회원 조회
      session.setAttribute("managerno", managerVO_read.getManagerno()); // 서버의 메모리에 기록
      session.setAttribute("manager_id", managerVO_read.getId());
      session.setAttribute("manager_mname", managerVO_read.getMname());
      session.setAttribute("manager_grade", managerVO_read.getGrade());
   
      String id = managerVO.getId();                  // 폼에 입력된 id
      String passwd = managerVO.getPasswd();  // 폼에 입력된 passwd 
      
      // -------------------------------------------------------------------
      // id 관련 쿠기 저장
      // -------------------------------------------------------------------
      if (Tool.checkNull(id_save).equals("Y")) { // id를 저장할 경우, Checkbox를 체크한 경우, 체크하지 않으면 null
        Cookie ck_manager_id = new Cookie("ck_manager_id", id);
        ck_manager_id.setPath("/");  // root 폴더에 쿠키를 기록함으로 모든 경로에서 쿠기 접근 가능
        ck_manager_id.setMaxAge(60 * 60 * 24 * 30); // 30 day, 초단위
        response.addCookie(ck_manager_id); // client의 chrome 관련 폴더에 Cookie 저장
      } else { // N, id를 저장하지 않는 경우, Checkbox를 체크 해제한 경우
        Cookie ck_manager_id = new Cookie("ck_manager_id", ""); // 값을 삭제한 Cookie 객체 생성
        ck_manager_id.setPath("/");
        ck_manager_id.setMaxAge(0); // 수명을 0초로 지정
        response.addCookie(ck_manager_id);  // client의 chrome 관련 폴더에 기존 Cookie를 덮어씀
      }
      
      // id를 저장할지 선택하는 CheckBox 체크 여부
      Cookie ck_manager_id_save = new Cookie("ck_manager_id_save", id_save);
      ck_manager_id_save.setPath("/");
      ck_manager_id_save.setMaxAge(60 * 60 * 24 * 30); // 30 day
      response.addCookie(ck_manager_id_save);
      // -------------------------------------------------------------------
  
      // -------------------------------------------------------------------
      // Password 관련 쿠기 저장
      // -------------------------------------------------------------------
      if (Tool.checkNull(passwd_save).equals("Y")) { // 패스워드 저장할 경우
        Cookie ck_manager_passwd = new Cookie("ck_manager_passwd", passwd);
        ck_manager_passwd.setPath("/");
        ck_manager_passwd.setMaxAge(60 * 60 * 24 * 30); // 30 day
        response.addCookie(ck_manager_passwd);
      } else { // N, 패스워드를 저장하지 않을 경우
        Cookie ck_manager_passwd = new Cookie("ck_manager_passwd", "");
        ck_manager_passwd.setPath("/");
        ck_manager_passwd.setMaxAge(0);
        response.addCookie(ck_manager_passwd);
      }
      
      // passwd를 저장할지 선택하는  CheckBox 체크 여부
      Cookie ck_manager_passwd_save = new Cookie("ck_manager_passwd_save", passwd_save);
      ck_manager_passwd_save.setPath("/");
      ck_manager_passwd_save.setMaxAge(60 * 60 * 24 * 30); // 30 day
      response.addCookie(ck_manager_passwd_save);
      // -------------------------------------------------------------------
   
      mav.setViewName("redirect:/index.do");  
    } else {
      mav.addObject("url", "/manager/login_fail_msg");
      mav.setViewName("redirect:/manager/msg.do"); // Post -> Get
    }
       
    return mav;
  }
    
  
}

