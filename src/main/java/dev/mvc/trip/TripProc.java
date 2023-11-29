package dev.mvc.trip;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

// Controller가 사용하는 이름
@Component("dev.mvc.trip.TripProc")
public class TripProc implements TripProcInter {
  @Autowired // TripDAOInter interface 구현한 객체를 만들어 자동으로 할당해라.
  private TripDAOInter tripDAO;
  
  @Override
  public int create(TripVO tripVO) {
    int cnt = this.tripDAO.create(tripVO);

    return cnt;
  }

  @Override
  public ArrayList<TripVO> list_all() {
    ArrayList<TripVO> list = this.tripDAO.list_all();
    
    return list;
  }

  @Override
  public TripVO read(int tripno) {
    TripVO  tripVO  = this.tripDAO.read(tripno);
    
    return tripVO;
  }

  @Override
  public int update(TripVO tripVO) {
    int cnt = this.tripDAO.update(tripVO);
    
    return cnt;
  }

  @Override
  public int delete(int tripno) {
    int cnt = this.tripDAO.delete(tripno);
    
    return cnt;
  }

  @Override
  public int update_seqno_forward(int tripno) {
    int cnt = this.tripDAO.update_seqno_forward(tripno);
    return cnt;
  }

  @Override
  public int update_seqno_backward(int tripno) {
    int cnt = this.tripDAO.update_seqno_backward(tripno);
    return cnt;
  }

  @Override
  public int update_visible_y(int tripno) {
    int cnt = this.tripDAO.update_visible_y(tripno);
    return cnt;
  }

  @Override
  public int update_visible_n(int tripno) {
    int cnt = this.tripDAO.update_visible_n(tripno);
    return cnt;
  }

  @Override
  public ArrayList<TripVO> list_all_y() {
    ArrayList<TripVO> list = this.tripDAO.list_all_y();
    return list;
  }

}





