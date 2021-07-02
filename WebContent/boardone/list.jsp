<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "filelibrary.FileDao" %>
<%@ page import = "filelibrary.FileDto" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
	int count = 0;
	int number = 0;
	List<FileDto> articleList = null;
	FileDao dbPro = FileDao.getInstance();
	count = dbPro.getArticleCount();
	if(count> 0){
		articleList = dbPro.getArticles();
	}
	number = count;
%>
<!doctype html>
<html>
<head>
<title>게시판</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/liststyle.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<section>
<article>
<b>게시판 LIST (전체 글 갯수:<%= count %>)</b>
<table class="listwritebutton">
    <tr>
    <td><a href="writeForm.jsp">글쓰기</a></td>
    <tr>
</table>
<%
    if(count == 0){
%>
<table class="listtable">
<tr>
    <td>게시판에 저장된 글이 없습니다.</td>
</table>
<% } else { %>
<table  class="listtable">
    <tr>
        <th id="num">NUMBER</th>
        <th id="title">글 제 목</th>
        <th id="writer">작성자</th>
        <th id="date">작성시간</th>
        <th id="counter">조 회 수</th>
        <th id="counter">파일이름</th>
    </tr>
<%
    for(int i = 0; i < articleList.size(); i++){
        FileDto article = (FileDto)articleList.get(i);
%>
    <tr>
        <td> <%= number-- %></td>
        <td class="titletd">
        <!-- 수정<5> -->
        <a href="content.jsp?num=<%= article.getNum() %>&pageNum=1"><!-- 수정<6> -->
            <%= article.getSubject() %></a>
            <% if(article.getReadcount() >= 20){ %>
            <img src="images/hot.gif"><% } %></td>
        <td>
            <a href="mailto:<%= article.getEmail() %>">
            <%= article.getWriter() %></a></td>
        <td>
            <%= sdf.format(article.getRegdate()) %></td>
        <td><%= article.getReadcount() %></td>
        <td><%= article.getFilename() %></td>
    </tr>
        <% } %>
</table>
</article>
<% } %>
<!-- 수정<7> -->
</section>
</body>
</html>