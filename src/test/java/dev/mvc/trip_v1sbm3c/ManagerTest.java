package dev.mvc.trip_v1sbm3c;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import dev.mvc.manager.ManagerProcInter;
import dev.mvc.manager.ManagerVO;

@SpringBootTest
public class ManagerTest {
  @Autowired
  @Qualifier("dev.mvc.manager.ManagerProc") // "dev.mvc.manager.ManagerProc"라고 명명된 클래스
  private ManagerProcInter managerProc; // ManagerProcInter를 구현한 ManagerProc 클래스의 객체를 자동으로 생성하여 할당
  
  @Test
  public void testRead() {
    ManagerVO managerVO = this.managerProc.read(1);
    System.out.println(managerVO.toString());
  }
}
