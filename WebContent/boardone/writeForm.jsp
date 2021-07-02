<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Library</title>
<link href="css/style.css" rel="stylesheet" type="text/css"/>
<link href="css/writeFormstyle.css" rel="stylesheet" type="text/css"/>
<script src="script.js"></script>
</head>


<body>
<section>
<b>글쓰기</b>
<article>
	<form method="post" name="writeForm" action="writeProc.jsp"
	enctype="multipart/form-data" onsubmit="return writeSave()">
	<table class="library">
		<tr>
			<td class="attr">글쓴이</td>
			<td><input type="text" name="writer"/></td>
		</tr>
		<tr>
			<td class="attr">제목</td>
			<td><input type="text" name="subject"/></td>
		</tr>
		<tr>
			<td class="attr">이메일</td>
			<td><input type="email" name="email"/></td>
		</tr>
		<tr>
			<td class="attr">내용</td>
			<td>
				<textarea name="content" rows="13" cols="50"></textarea>
			</td>
		</tr>
		
		<tr>
			<td class="attr">파일선택</td>
			<td>파일선택 : <input type="file" name="uploadFile"></td>
		</tr>
		
		<tr>
			<td class="attr">비밀번호</td>
			<td><input type="password" name="pass"/></td>
		</tr>
		<tr>
			<td colspan="2" class="attr">
				<input type="submit" value="글쓰기"/>
				<input type="reset" value="다시작성"/>
				<input type="button" value="목록"
						onClick="window.location='list.jsp'">
			</td>
		</tr>
		</table>
		
</form>
</article>
</section>

<!-- 예외처리 -->
</body>
</html>