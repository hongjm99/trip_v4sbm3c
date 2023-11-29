package dev.mvc.trip_v1sbm3c;

import java.util.ArrayList;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import dev.mvc.trip.TripDAOInter;
import dev.mvc.trip.TripProcInter;
import dev.mvc.trip.TripVO;

@SpringBootTest
class TripV2sbm3cApplicationTests {
  @Autowired // TripDAOInter interface 구현한 객체를 만들어 자동으로 할당해라.
  private TripDAOInter tripDAO;

  @Autowired // TripProcInter interface 구현한 객체를 만들어 자동으로 할당해라.
  @Qualifier("dev.mvc.trip.TripProc")
  private TripProcInter tripProc;
  
	@Test
	void contextLoads() {
	  
	}
	
//	@Test
//	public void testCreate() {
//	  TripVO tripVO = new TripVO();
//	  // tripVO.setName("경상남도");
//	  // tripVO.setName("충청북도");
//	  // tripVO.setName("전라북도");
//	  // tripVO.setName("전라남도");
//	  tripVO.setName("경기도");
//	  
////	  int cnt = this.tripDAO.create(tripVO);
////	  System.out.println("-> cnt: " + cnt);
//	  
//	  int cnt = this.tripProc.create(tripVO);
//	  System.out.println("-> cnt: " + cnt);
//	  
//	}
	
//	@Test
//	public void testList_all() {
//	  ArrayList<TripVO> list = this.tripProc.list_all();
//	  for (TripVO tripVO : list) {
//	    System.out.println(tripVO.toString());
//	  }
//	}
	
//	@Test
//	public void testRead() {
//	  TripVO tripVO = this.tripProc.read(2);
//	  System.out.println(tripVO.toString());
//    
//	}

	 @Test
	  public void testUpdate() {
      TripVO tripVO = new TripVO();
      tripVO.setTripno(2);
      tripVO.setName("가평");
	    tripVO.setCnt(5);
	    
	    int cnt = this.tripProc.update(tripVO);
	    System.out.println("-> " + cnt);
	    
	  }
	 
}




