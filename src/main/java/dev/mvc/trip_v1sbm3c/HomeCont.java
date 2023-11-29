package dev.mvc.trip_v1sbm3c;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.trip.TripProcInter;
import dev.mvc.trip.TripVO;

@Controller
public class HomeCont {
  @Autowired // TripProcInter interface 구현한 객체를 만들어 자동으로 할당해라.
  @Qualifier("dev.mvc.trip.TripProc")
  private TripProcInter tripProc;
  
  public HomeCont() {
    System.out.println("-> HomeCont created.");
  }
  
  // http://localhost:9091
  @RequestMapping(value= {"", "/", "/index.do", "/index.resort"}, method=RequestMethod.GET)
  public ModelAndView home() {
    System.out.println("-> home() ver 4.0");
    
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/index"); // /WEB-INF/views/index.jsp
    // spring.mvc.view.prefix=/WEB-INF/views/
    // spring.mvc.view.suffix=.jsp
        
    return mav;
  }
  
  // http://localhost:9091/menu/top.do
  @RequestMapping(value= {"/menu/top.do"}, method=RequestMethod.GET)
  public ModelAndView top() {
    ModelAndView mav = new ModelAndView();

    ArrayList<TripVO> list_top = this.tripProc.list_all_y();
    mav.addObject("list_top", list_top);
    
    mav.setViewName("/menu/top"); // /WEB-INF/views/menu/top.jsp
    
    return mav;
  }
}




