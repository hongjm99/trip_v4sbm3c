package dev.mvc.trip_v1sbm3c;

import java.util.HashMap;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import dev.mvc.manager.ManagerProcInter;
import dev.mvc.manager.ManagerVO;
import dev.mvc.trip.TripProcInter;
import dev.mvc.tripcontents.TrContentsProcInter;

@SpringBootTest
public class TripContentsTest {
  @Autowired
  @Qualifier("dev.mvc.manager.ManagerProc") // @Component("dev.mvc.admin.AdminProc")
  private ManagerProcInter managerProc;
  
  @Autowired
  @Qualifier("dev.mvc.trip.TripProc")  // @Component("dev.mvc.trip.CateProc")
  private TripProcInter tripProc;
  
  @Autowired
  @Qualifier("dev.mvc.tripcontents.TrContentsProc") // @Component("dev.mvc.contents.ContentsProc")
  private TrContentsProcInter contentsProc;
  
//  @Test
//  public void testRead() {
//    HashMap<String, Object> hashMap = new HashMap<String, Object>();
//    hashMap.put("scontentsno", 18);
//    hashMap.put("passwd", "1234");
//    
//    System.out.println("-> cnt: " + this.contentsProc.password_check(hashMap));
//    
//  }
  
  @Test
  public void testCount_by_tripno() {
    System.out.println("-> cnt: " + this.contentsProc.count_by_tripno(1));          
  }
}