<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="name" value="${tripVO.name }" />

<c:set var="tripno" value="${contentsVO.tripno }" />
<c:set var="contentsno" value="${contentsVO.contentsno }" />
<c:set var="thumb1" value="${contentsVO.thumb1 }" />
<c:set var="file1saved" value="${contentsVO.file1saved }" />
<c:set var="title" value="${contentsVO.title }" />
<c:set var="content" value="${contentsVO.content }" />
<c:set var="rdate" value="${contentsVO.rdate }" />
<c:set var="youtube" value="${contentsVO.youtube }" />
<c:set var="map" value="${contentsVO.map }" />
<c:set var="file1" value="${contentsVO.file1 }" />
<c:set var="size1_label" value="${contentsVO.size1_label }" />
 <c:set var="word" value="${contentsVO.word}" />
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

</head> 
 
<body>
<c:import url="/menu/top.do" />
  <DIV class='title_line'><A href="./list_by_tripno.do?tripno=${tripno }" class='title_link'>${name }</A></DIV>

  <ASIDE class="aside_right">
    <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
    <c:if test="${sessionScope.manager_id != null }">
      <%--
      http://localhost:9091/contents/create.do?tripno=1
      http://localhost:9091/contents/create.do?tripno=2
      http://localhost:9091/contents/create.do?tripno=3
      --%>
      <A href="./create.do?tripno=${tripno }">등록</A>
      <span class='menu_divide' >│</span>
      <A href="./update_text.do?scontentsno=${contentsno}&now_page=${param.now_page}&word=${param.word }">글 수정</A>
      <span class='menu_divide' >│</span>
      <A href="./update_file.do?scontentsno=${contentsno}&now_page=${param.now_page}">파일 수정</A>  
      <span class='menu_divide' >│</span>
      <A href="./map.do?tripno=${tripno }&scontentsno=${contentsno}">지도</A>
      <span class='menu_divide' >│</span>
      <A href="./youtube.do?tripno=${tripno }&scontentsno=${contentsno}">Youtube</A>
      <span class='menu_divide' >│</span>
      <A href="./delete.do?scontentsno=${contentsno}&now_page=${param.now_page}&tripno=${tripno}">삭제</A>  
      <span class='menu_divide' >│</span>
    </c:if>

    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>    
    <A href="./list_by_tripno.do?tripno=${tripno }&now_page=${param.now_page}&word=${param.word }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_tripno_grid.do?tripno=${tripno }&now_page=${param.now_page}&word=${param.word }">갤러리형</A>
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_tripno.do'>
      <input type='hidden' name='tripno' value='${tripno }'>  <%-- 게시판의 구분 --%>
      
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' class='input_word'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' class='input_word'>
        </c:otherwise>
      </c:choose>
      <button type='submit' class='btn btn-secondary btn-sm' style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;">검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' class='btn btn-secondary btn-sm' style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;"
                    onclick="location.href='./list_by_tripno.do?tripno=${tripno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <DIV style="width: 100%; word-break: break-all;">
          <c:choose>
            <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
              <%-- /static/contents/storage/ --%>
              <img src="/contents/storage/${file1saved }" style='width: 50%; float: left; margin-top: 0.5%; margin-right: 1%;'> 
            </c:when>
            <c:otherwise> <!-- 기본 이미지 출력 -->
              <img src="/contents/images/none1.png" style='width: 50%; float: left; margin-top: 0.5%; margin-right: 1%;'> 
            </c:otherwise>
          </c:choose>

          <span style="font-size: 1.5em; font-weight: bold;">${title }</span>
          <span style="font-size: 1em;"> ${rdate }</span><br>
          ${content }
        </DIV>
      </li>
      
      <c:if test="${youtube.trim().length() > 0 }">
        <li class="li_none" style="clear: both; padding-top: 5px; padding-bottom: 5px;">
          <DIV style="text-align: center;">
            ${youtube }
          </DIV>
        </li>
      </c:if>
      
      <c:if test="${map.trim().length() > 0 }">
        <li class="li_none" style="clear: both; padding-top: 5px; padding-bottom: 5px;">
          <DIV style='text-align: center; width:640px; height: 360px; margin: 0px auto;'>
            ${map }
          </DIV>
        </li>
      </c:if>
      
      <li class="li_none" style="clear: both;">
        <DIV style='text-decoration: none;'>
          <br>
          검색어(키워드): ${word }
        </DIV>
      </li>
      <li class="li_none">
        <DIV>
          <c:if test="${file1.trim().length() > 0 }"> 
            첨부 파일: <a href='/download?dir=/contents/storage&filename=${file1saved}&downname=${file1}'>${file1}</a> (${size1_label})  
            <A href='/download?dir=/contents/storage&filename=${file1saved}&downname=${file1}'><IMG SRC="/contents/images/download.png"></A>
          </c:if>
        </DIV>
      </li>   
    </ul>
  </fieldset>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

