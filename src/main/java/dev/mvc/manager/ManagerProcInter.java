package dev.mvc.manager;

import javax.servlet.http.HttpSession;

public interface ManagerProcInter {
  /**
   * 로그인
   * @param ManagerVO
   * @return
   */
  public int login(ManagerVO managerVO);
  
  /**
   * 관리자 정보
   * @param String
   * @return
   */
  public ManagerVO read_by_id(String id);
  
  /**
   * 관리자 로그인 체크
   * @param session
   * @return
   */
  public boolean isManager(HttpSession session);
  
  /**
   * 회원 정보 조회
   * @param managero
   * @return
   */
  public ManagerVO read(int managero);
  
}


