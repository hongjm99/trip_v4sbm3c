package dev.mvc.trip;

import java.util.ArrayList;

public interface TripDAOInter {
  /**
   * 등록, 추상 메소드 -> Spring Boot이 구현함.
   * @param tripVO 객체
   * @return 등록된 레코드 갯수
   */
  public int create(TripVO tripVO);
  
  /**
   * 전체 목록
   * @return
   */
  public ArrayList<TripVO> list_all();
  
  /**
   * 조회
   * @param tripno
   * @return
   */
  public TripVO read(int tripno);
  
  /**
   * 수정   
   * @param tripVO
   * @return 수정된 레코드 갯수
   */
  public int update(TripVO tripVO);

  /**
   * 삭제
   * @param tripno 삭제할 레코드 PK 번호
   * @return 삭제된 레코드 갯수
   */
  public int delete(int tripno);
  
  /**
   * 우선 순위 높임, 10 등 -> 1 등   
   * @param tripno
   * @return 수정된 레코드 갯수
   */
  public int update_seqno_forward(int tripno);

  /**
   * 우선 순위 낮춤, 1 등 -> 10 등   
   * @param tripno
   * @return 수정된 레코드 갯수
   */
  public int update_seqno_backward(int tripno);
  
  /**
   * 카테고리 공개 설정
   * @param tripno
   * @return
   */
  public int update_visible_y(int tripno);
  
  /**
   * 카테고리 비공개 설정
   * @param tripno
   * @return
   */
  public int update_visible_n(int tripno);
  
  /**
   * 비회원/회원 SELECT LIST
   * @return
   */
  public ArrayList<TripVO> list_all_y();
  
}



