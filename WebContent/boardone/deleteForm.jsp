<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");
%>
<html>
<head> 
<title>게시판</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/deleteFormstyle.css" rel="stylesheet" type="text/css"/>
<script>
    function deleteSave(){
        if(document.delForm.pass.value == ""){
                alert("비밀번호를 입력하세요.");
                document.delForm.pass.focus();
                return false;
        }
    }
</script>
</head>
<body>
<section>
<b>글삭제</b>
    <form method="post" name="delForm" action=
    "deleteProc.jsp?pageNum=<%=pageNum%>" onsubmit="return deleteSave()">
        <table class="deletetable">
            <tr>
                <th><b>비밀번호를 입력 해 주세요.</b></th>
            </tr>
            <tr>
                <td>비밀번호 : 
                    <input type="password" name="pass">
                    <input type="hidden" name="num" value="<%=num%>">
                </td>
            </tr>
            <tr>
                <td>
                    <input type="submit" value="글삭제">
                    <input type="button" value="글목록" onClick=
                    "document.location.href='list.jsp?pageNum=<%=pageNum%>'">
                </td>
            </tr>
        </table>
    </form>
</section>
</body>
</html>
