package dev.mvc.tripmember;
 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
 
@Component("dev.mvc.tripmember.TrMemberProc")
public class TrMemberProc implements TrMemberProcInter {
  @Autowired
  private TrMemberDAOInter memberDAO;
  
  public TrMemberProc(){
    // System.out.println("-> MemberProc created.");
  }

  @Override
  public int checkID(String id) {
    int cnt = this.memberDAO.checkID(id);
    return cnt;
  }

  @Override
  public int create(TrMemberVO memberVO) {
    int cnt = this.memberDAO.create(memberVO);
    return cnt;
  }

  @Override
  public ArrayList<TrMemberVO> list() {
    ArrayList<TrMemberVO> list = this.memberDAO.list();
    return list;
  }
  
  @Override
  public TrMemberVO read(int tripmemberno) {
    TrMemberVO memberVO = this.memberDAO.read(tripmemberno);
    return memberVO;
  }

  @Override
  public TrMemberVO readById(String id) {
    TrMemberVO memberVO = this.memberDAO.readById(id);
    return memberVO;
  }

@Override
  public boolean isMember(HttpSession session){
    boolean sw = false; // 로그인하지 않은 것으로 초기화
    int grade = 99;
    
    // System.out.println("-> grade: " + session.getAttribute("grade"));
    if (session != null) {
      String id = (String)session.getAttribute("id");
      if (session.getAttribute("grade") != null) {
        grade = (int)session.getAttribute("grade");
      }
      
      if (id != null && grade <= 20){ // 관리자 + 회원
        sw = true;  // 로그인 한 경우
      }
    }
    
    return sw;
  }

  @Override
  public boolean isMemberAdmin(HttpSession session){
    boolean sw = false; // 로그인하지 않은 것으로 초기화
    int grade = 99;
    
    // System.out.println("-> grade: " + session.getAttribute("grade"));
    if (session != null) {
      String id = (String)session.getAttribute("id");
      if (session.getAttribute("grade") != null) {
        grade = (int)session.getAttribute("grade");
      }
      
      if (id != null && grade <= 10){ // 관리자 
        sw = true;  // 로그인 한 경우
      }
    }
    
    return sw;
  }
  
  @Override
  public int update(TrMemberVO memberVO) {
    int cnt = this.memberDAO.update(memberVO);
    return cnt;
  }
  
  @Override
  public int delete(int tripmemberno) {
    int cnt = this.memberDAO.delete(tripmemberno);
    return cnt;
  }
  
  @Override
  public int passwd_check(HashMap<String, Object> map) {
    int cnt = this.memberDAO.passwd_check(map);
    return cnt;
  }

  @Override
  public int passwd_update(HashMap<String, Object> map) {
    int cnt = this.memberDAO.passwd_update(map);
    return cnt;
  }
  @Override
  public int login(HashMap<String, Object> map) {
    int cnt = this.memberDAO.login(map);
    return cnt;
  }
  
}