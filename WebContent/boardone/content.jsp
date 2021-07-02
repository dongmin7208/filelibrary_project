<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "filelibrary.FileDao" %>
<%@ page import = "filelibrary.FileDto" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<!doctype html>
<html>
<head>
<title>게시판</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/contentstyle.css" rel="stylesheet" type="text/css">
</head>    
<%
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    try{
        FileDao dbPro = FileDao.getInstance();
        FileDto article = dbPro.getArticle(num);
        String fileName = URLEncoder.encode(article.getFilename(), "utf-8");
%>
<body>
<section>
<article>
<b>글 내용 보기</b>
<br/><br/>
<form>
    <table class="contenttable">
        <tr>
            <th>NUMBER</th>
            <td><%= article.getNum() %></td>
            <th>조회수</th>
            <td><%= article.getReadcount() %></td>
        </tr>
        <tr>
            <th>작성자</th>
            <td><%= article.getWriter() %></td>
            <th>작성시간</th>
            <td><%= article.getRegdate() %></td>
        </tr>
        <tr>
            <th>제 목</th>
            <td colspan="3" class="contenttitle"><%= article.getSubject() %></td>
        </tr>
        <tr>
            <th>내 용</th>
            <td colspan="3" class="content"><pre><%= article.getContent() %></pre></td>
        </tr>
        <tr>
        	<th>파일 이름</th>
        	<td colspan="4" class="file"><a href="filedown.jsp?fileName=<%=fileName%>"><%= article.getFilename() %></a></td>
        </tr>
        <tr>
            <td colspan="5">
                <input type="button" value="글수정" 
                onClick="document.location.href=
                'updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value="글삭제" 
                onClick="document.location.href=
                'deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
                    &nbsp;&nbsp;&nbsp;&nbsp;
        <!-- 수정<1> -->
                <input type="button" value="글목록" 
                    onClick="document.location.href=
                    'list.jsp?pageNum=<%=pageNum%>'">
            </td>
        </tr>
    </table>
    <%
    } catch(Exception e){}
    %>
</form>
</article>
</section>
</body>
</html>