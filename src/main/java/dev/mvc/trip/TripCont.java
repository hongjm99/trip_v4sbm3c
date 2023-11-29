package dev.mvc.trip;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.tripcontents.TrContents;
import dev.mvc.tripcontents.TrContentsProcInter;
import dev.mvc.tripcontents.TrContentsVO;
//import dev.mvc.contents.Contents;
//import dev.mvc.contents.ContentsVO;
import dev.mvc.manager.ManagerProcInter;
import dev.mvc.tool.Tool;

@Controller
public class TripCont {
  @Autowired // TripProcInter interface 구현한 객체를 만들어 자동으로 할당해라.
  @Qualifier("dev.mvc.trip.TripProc")
  private TripProcInter tripProc;

  @Autowired
  @Qualifier("dev.mvc.manager.ManagerProc") // "dev.mvc.manager.ManagerProc"라고 명명된 클래스
  private ManagerProcInter managerProc; // ManagerProcInter를 구현한 ManagerProc 클래스의 객체를 자동으로 생성하여 할당
    
  @Autowired
  @Qualifier("dev.mvc.tripcontents.TrContentsProc") // @Component("dev.mvc.contents.ContentsProc")
  private TrContentsProcInter contentsProc;
  
  public TripCont() {
    System.out.println("-> TripCont created.");  
  }

//  // FORM 출력, http://localhost:9091/trip/create.do
//  @RequestMapping(value="/trip/create.do", method = RequestMethod.GET)
//  @ResponseBody // 단순 문자열로 출력, jsp 파일명 조합이 발생하지 않음.
//  public String create() {
//    return "<h3>GET 방식 FORM 출력</h3>";
//  }

  // FORM 출력, http://localhost:9091/trip/create.do
  @RequestMapping(value="/trip/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/trip/create"); // /WEB-INF/views/trip/create.jsp
    
    return mav;
  }
  
  // FORM 데이터 처리, http://localhost:9091/trip/create.do
  @RequestMapping(value="/trip/create.do", method = RequestMethod.POST)
  public ModelAndView create(TripVO tripVO) { // 자동으로 tripVO 객체가 생성되고 폼의 값이 할당됨
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.tripProc.create(tripVO);
    System.out.println("-> cnt: " + cnt);
    
    if (cnt == 1) {
      // mav.addObject("code", "create_success"); // 키, 값
      // mav.addObject("name", tripVO.getName()); // 카테고리 이름 jsp로 전송
      mav.setViewName("redirect:/trip/list_all.do"); // 주소 자동 이동
    } else {
      mav.addObject("code", "create_fail");
      mav.setViewName("/trip/msg"); // /WEB-INF/views/trip/msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
    
    return mav;
  }
  
  /**
   * 전체 목록
   * http://localhost:9091/trip/list_all.do
   * @return
   */
  @RequestMapping(value="/trip/list_all.do", method = RequestMethod.GET)
  public ModelAndView list_all(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if (this.managerProc.isManager(session) == true) {
      mav.setViewName("/trip/list_all"); // /WEB-INF/views/trip/list_all.jsp
      
      ArrayList<TripVO> list = this.tripProc.list_all();
      mav.addObject("list", list);
      
    } else {
      mav.setViewName("/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
      
    }
    
    return mav;
  }
  
  /**
   * 조회
   * http://localhost:9091/trip/read.do?tripno=1
   * @return
   */
  @RequestMapping(value="/trip/read.do", method = RequestMethod.GET)
  public ModelAndView read(int tripno) { // int tripno = (int)request.getParameter("tripno");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/trip/read"); // /WEB-INF/views/trip/read.jsp
    
    TripVO tripVO = this.tripProc.read(tripno);
    mav.addObject("tripVO", tripVO);
    
    return mav;
  }

  /**
   * 수정폼
   * http://localhost:9091/trip/update.do?tripno=1
   * @return
   */
  @RequestMapping(value="/trip/update.do", method = RequestMethod.GET)
  public ModelAndView update(HttpSession session, int tripno) { // int tripno = (int)request.getParameter("tripno");
    ModelAndView mav = new ModelAndView();
    
    if (this.managerProc.isManager(session) == true) {
      // mav.setViewName("/trip/update"); // /WEB-INF/views/trip/update.jsp
      mav.setViewName("/trip/list_all_update"); // /WEB-INF/views/trip/list_all_update.jsp
      
      TripVO tripVO = this.tripProc.read(tripno);
      mav.addObject("tripVO", tripVO);
      
      ArrayList<TripVO> list = this.tripProc.list_all();
      mav.addObject("list", list);
      
    } else {
      mav.setViewName("/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
      
    }
        
    return mav;
  }
  
  /**
   * 수정 처리, http://localhost:9091/trip/update.do
   * @param tripVO 수정할 내용
   * @return
   */
  @RequestMapping(value="/trip/update.do", method = RequestMethod.POST)
  public ModelAndView update(TripVO tripVO) { // 자동으로 tripVO 객체가 생성되고 폼의 값이 할당됨
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.tripProc.update(tripVO); // 수정 처리
    System.out.println("-> cnt: " + cnt);
    
    if (cnt == 1) {
      // mav.addObject("code", "update_success"); // 키, 값
      // mav.addObject("name", tripVO.getName()); // 카테고리 이름 jsp로 전송
      mav.setViewName("redirect:/trip/list_all.do"); 
      
    } else {
      mav.addObject("code", "update_fail");
      mav.setViewName("/trip/msg"); // /WEB-INF/views/trip/msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
    
    return mav;
  }
  
  /**
   * 삭제폼
   * http://localhost:9091/trip/delete.do?tripno=1
   * @return
   */
  @RequestMapping(value="/trip/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(HttpSession session, int tripno) { // int tripno = (int)request.getParameter("tripno");
    ModelAndView mav = new ModelAndView();
    
    if (this.managerProc.isManager(session) == true) {
      // mav.setViewName("/trip/delete"); // /WEB-INF/views/trip/delete.jsp
      mav.setViewName("/trip/list_all_delete"); // /WEB-INF/views/trip/list_all_delete.jsp
      
      TripVO tripVO = this.tripProc.read(tripno);
      mav.addObject("tripVO", tripVO);
      
      ArrayList<TripVO> list = this.tripProc.list_all();
      mav.addObject("list", list);
      
      // 특정 카테고리에 속한 레코드 갯수를 리턴
      int count_by_tripno = this.contentsProc.count_by_tripno(tripno);
      mav.addObject("count_by_tripno", count_by_tripno);
      
    } else {
      mav.setViewName("/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
   
    }
    
    return mav;
  }
  
//삭제 처리, 수정 처리를 복사하여 개발
// 자식 테이블 레코드 삭제 -> 부모 테이블 레코드 삭제
/**
 * 카테고리 삭제
 * @param session
 * @param tripno 삭제할 카테고리 번호
 * @return
 */
@RequestMapping(value="/trip/delete.do", method=RequestMethod.POST)
public ModelAndView delete_proc(HttpSession session, int tripno) { // <form> 태그의 값이 자동으로 저장됨
//  System.out.println("-> tripno: " + tripVO.getCateno());
//  System.out.println("-> name: " + tripVO.getName());
  
  ModelAndView mav = new ModelAndView();
  
  if (this.managerProc.isManager(session) == true) {
    ArrayList<TrContentsVO> list = this.contentsProc.list_by_tripno(tripno); // 자식 레코드 목록 읽기
    
    for(TrContentsVO contentsVO : list) { // 자식 레코드 관련 파일 삭제
      // -------------------------------------------------------------------
      // 파일 삭제 시작
      // -------------------------------------------------------------------
      String file1saved = contentsVO.getFile1saved();
      String thumb1 = contentsVO.getThumb1();
      
      String uploadDir = TrContents.getUploadDir();
      Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
      Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
      // -------------------------------------------------------------------
      // 파일 삭제 종료
      // -------------------------------------------------------------------
    }
    
    this.contentsProc.delete_by_tripno(tripno); // 자식 레코드 삭제     
          
    int cnt = this.tripProc.delete(tripno); // 카테고리 삭제
    
    if (cnt == 1) {
      mav.setViewName("redirect:/trip/list_all.do");       // 자동 주소 이동, Spring 재호출
      
    } else {
      mav.addObject("code", "delete_fail");
      mav.setViewName("/trip/msg"); // /WEB-INF/views/trip/msg.jsp
    }
    
    mav.addObject("cnt", cnt);
    
  } else {
    mav.setViewName("/manager/login_need"); // /WEB-INF/views/manager/login_need.jsp
  }
  
  return mav;
}
  
  /**
   * 우선 순위 높임, 10 등 -> 1 등, http://localhost:9091/trip/update_seqno_forward.do?tripno=1
   * @param tripVO 수정할 내용
   * @return
   */
  @RequestMapping(value="/trip/update_seqno_forward.do", method = RequestMethod.GET)
  public ModelAndView update_seqno_forward(int tripno) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.tripProc.update_seqno_forward(tripno);
    System.out.println("-> cnt: " + cnt);
    
    if (cnt == 1) {
      mav.setViewName("redirect:/trip/list_all.do"); 
      
    } else {
      mav.addObject("code", "update_fail");
      mav.setViewName("/trip/msg"); // /WEB-INF/views/trip/msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
    
    return mav;
  }
  
  /**
   * 우선 순위 낮춤, 1 등 -> 10 등, http://localhost:9091/trip/update_seqno_backward.do?tripno=1
   * @param tripno 수정할 레코드 PK 번호
   * @return
   */
  @RequestMapping(value="/trip/update_seqno_backward.do", method = RequestMethod.GET)
  public ModelAndView update_seqno_backward(int tripno) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.tripProc.update_seqno_backward(tripno);
    System.out.println("-> cnt: " + cnt);
    
    if (cnt == 1) {
      mav.setViewName("redirect:/trip/list_all.do"); 
      
    } else {
      mav.addObject("code", "update_fail");
      mav.setViewName("/trip/msg"); // /WEB-INF/views/trip/msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
    
    return mav;
  }
  
  /**
   * 카테고리 공개 설정, http://localhost:9091/trip/update_visible_y.do?tripno=1
   * @param tripno 수정할 레코드 PK 번호
   * @return
   */
  @RequestMapping(value="/trip/update_visible_y.do", method = RequestMethod.GET)
  public ModelAndView update_visible_y(int tripno) { 
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.tripProc.update_visible_y(tripno);
    System.out.println("-> cnt: " + cnt);
    
    if (cnt == 1) {
      mav.setViewName("redirect:/trip/list_all.do"); 
      
    } else {
      mav.addObject("code", "update_fail");
      mav.setViewName("/trip/msg"); // /WEB-INF/views/trip/msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
    
    return mav;
  }
  
  /**
   * 카테고리 비공개 설정, http://localhost:9091/trip/update_visible_n.do?tripno=1
   * @param tripno 수정할 레코드 PK 번호
   * @return
   */
  @RequestMapping(value="/trip/update_visible_n.do", method = RequestMethod.GET)
  public ModelAndView update_visible_n(int tripno) { 
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.tripProc.update_visible_n(tripno);
    System.out.println("-> cnt: " + cnt);
    
    if (cnt == 1) {
      mav.setViewName("redirect:/trip/list_all.do"); 
      
    } else {
      mav.addObject("code", "update_fail");
      mav.setViewName("/trip/msg"); // /WEB-INF/views/trip/msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);
    
    return mav;
  }
  
}






