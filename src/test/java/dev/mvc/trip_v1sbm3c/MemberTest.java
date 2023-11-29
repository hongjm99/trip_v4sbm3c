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
import dev.mvc.tripmember.TrMemberProc;

@SpringBootTest
public class MemberTest {
  @Autowired
  @Qualifier("dev.mvc.manager.ManagerProc") // "dev.mvc.manager.ManagerProc"라고 명명된 클래스
  private ManagerProcInter managerProc; // ManagerProcInter를 구현한 ManagerProc 클래스의 객체를 자동으로 생성하여 할당

  @Autowired
  @Qualifier("dev.mvc.trip.TripProc")  // @Component("dev.mvc.trip.TripProc")
  private TripProcInter tripProc;
  
  @Autowired
  @Qualifier("dev.mvc.tripcontents.TrContentsProc") // @Component("dev.mvc.contents.ContentsProc")
  private TrContentsProcInter contentsProc;

  @Autowired
  @Qualifier("dev.mvc.tripmember.TrMemberProc") // @Component("dev.mvc.member.MemberProc")
  private TrMemberProc memberProc;
  
  @Test
  public void testCheckID() {
    System.out.println("-> cnt: " + this.memberProc.checkID("user1@gmail.com"));
    System.out.println("-> cnt: " + this.memberProc.checkID("user5@gmail.com"));  
  }
}