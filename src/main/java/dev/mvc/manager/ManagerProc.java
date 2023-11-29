package dev.mvc.manager;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.manager.ManagerProc")
public class ManagerProc implements ManagerProcInter {
  @Autowired
  private ManagerDAOInter managerDAO;
  
  @Override
  public int login(ManagerVO managerVO) {
    int cnt = this.managerDAO.login(managerVO);
    return cnt;
  }

  @Override
  public ManagerVO read_by_id(String id) {
    ManagerVO managerVO = this.managerDAO.read_by_id(id);
    return managerVO;
  }

  @Override
  public boolean isManager(HttpSession session) {
    boolean manager = false;
    
    if (session != null) {
      String manager_id = (String)session.getAttribute("manager_id");
      
      if (manager_id != null) {
        manager = true;
      }
    }
    
    return manager;
    
  }

  @Override
  public ManagerVO read(int managero) {
    ManagerVO managerVO = this.managerDAO.read(managero);
    return managerVO;
  }
  
  
}


