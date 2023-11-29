package dev.mvc.tripcontents;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

//import dev.mvc.contents.ContentsVO;
//import dev.mvc.contents.ContentsVO;
import dev.mvc.tripcontents.TrContentsVO;

/**
 * Spring Boot가 자동 구현
 * @author soldesk
 *
 */
public interface TrContentsDAOInter {
  /**
   * 등록, 추상 메소드
   * @param contentsVO
   * @return
   */
  public int create(TrContentsVO contentsVO);

  /**
   * 모든 카테고리의 등록된 글목록
   * @return
   */
  public ArrayList<TrContentsVO> list_all();
  
  /**
   * 카테고리별 등록된 글 목록
   * @param tripno
   * @return
   */
  public ArrayList<TrContentsVO> list_by_tripno(int tripno);

  /**
   * 조회
   * @param contentsno
   * @return
   */
  public TrContentsVO read(int scontentsno);
  
  /**
   * map 등록, 수정, 삭제
   * @param map
   * @return 수정된 레코드 갯수
   */
   public int map(HashMap<String, Object> map);
   
   /**
    * youtube 등록, 수정 삭제
    * @param youtube
    * @return 수정된 레코드 갯수
    */
   public int youtube(HashMap<String, Object> map);

   /**
    * 카테고리별 검색 목록
    * @param map
    * @return
    */
   public ArrayList<TrContentsVO> list_by_tripno_search(HashMap<String, Object> hashMap);
   
   /**
    * 카테고리별 검색된 레코드 갯수
    * @param map
    * @return
    */
   public int search_count(HashMap<String, Object> hashMap);
   
   /**
    *  특정 카테고리의 검색 + 페이징된 글목록
   *  spring framework이 JDBC 관련 코드를 모두 생성해줌
   * @return
   */
  public ArrayList<TrContentsVO> list_by_tripno_search_paging(TrContentsVO contentsVO);

  /**
   * 패스워드 검사
   * @param hashMap
   * @return
   */
  public int password_check(HashMap<String, Object> hashMap);
  
  /**
   * 글 정보 수정
   * @param contentsVO
   * @return 처리된 레코드 갯수
   */
  public int update_text(TrContentsVO contentsVO);
  
  /**
   * 파일 정보 수정
   * @param contentsVO
   * @return 처리된 레코드 갯수
   */
  public int update_file(TrContentsVO contentsVO);
  
  /**
   * 삭제
   * @param contentsno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int scontentsno);
  
  /**
   * FK tripno 값이 같은 레코드 갯수 산출
   * @param tripno
   * @return
   */
  public int count_by_tripno(int tripno);
  
  /**
   * 특정 카테고리에 속한 모든 레코드 삭제
   * @param tripno
   * @return 삭제된 레코드 갯수
   */
  public int delete_by_tripno(int tripno);
}


