<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<div class='container_main'>
  <div class='top_img'>
    <div class="top_menu_label"><span class="blue_text">1박</span><span class="red_text">2일</span>&nbsp;&nbsp;태안 여행 추천 version 4.0</div>
    <nav class="top_menu">
      <a href="/" class="menu_link">힐링 리조트</a><span class="top_menu_sep"> </span>
      
      <c:forEach var="tripVO" items="${list_top }">
        <a href="/contents/list_by_tripno.do?tripno=${tripVO.tripno }&now_page=1" class="menu_link">${tripVO.name }</a><span class="top_menu_sep"> </span> 
      </c:forEach>
      
      <a href="/member/create.do" class="menu_link">회원 가입</a><span class="top_menu_sep"> </span>
      <a href="/member/list.do" class="menu_link">회원 목록</a><span class="top_menu_sep"> </span>
      
      <c:choose>
        <c:when test="${sessionScope.id == null}">
          <a href="/member/login.do" class="menu_link">로그인</a><span class="top_menu_sep"> </span>
        </c:when>
        <c:otherwise>
          <a href='/member/logout.do' class="menu_link">${sessionScope.id } 로그아웃</a><span class="top_menu_sep"> </span>
          <a href='/member/passwd_update.do' class="menu_link">비밀번호 변경</a><span class="top_menu_sep"> </span>
        </c:otherwise>
      </c:choose>
      
      <c:choose>
        <c:when test="${sessionScope.manager_id == null }">
          <a href="/manager/login.do" class="menu_link">관리자 로그인</a>
        </c:when>
        <c:otherwise>
          <a href="/trip/list_all.do" class="menu_link">카테고리 전체 목록</a><span class="top_menu_sep"> </span>
          <a href="/contents/list_all.do" class="menu_link">전체 글 목록</a><span class="top_menu_sep"> </span>
          <a href="/contents/list_all_gallery.do" class="menu_link">Gallery</a><span class="top_menu_sep"> </span>
          <a href="/manager/logout.do" class="menu_link">관리자 ${sessionScope.manager_id } 로그아웃</a>
        </c:otherwise>
      </c:choose>
      
    </nav>
  </div>
  <div class='content_body'> <!--  내용 시작 -->  