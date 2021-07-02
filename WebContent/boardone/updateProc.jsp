<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "filelibrary.FileDao" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="article" scope="page" class="filelibrary.FileDto"/>

<%
    String pageNum = request.getParameter("pageNum");
	article.setRegdate( new Timestamp( System.currentTimeMillis() ) );
    FileDao dbPro = FileDao.getInstance();
    
    
        
        String savePath = "/boardone/upload";
    	int uploadFileSizeLimit = 5 * 1024 * 1024;
    	String encType = "UTF-8";
    	
    	ServletContext context = getServletContext();
    	String uploadFilePath = context.getRealPath(savePath);
    	System.out.println("서버상의 실제 디렉터리");
    	System.out.println(uploadFilePath);
    	try{
    		MultipartRequest multi = new MultipartRequest(
    				request,
    				uploadFilePath,
    				uploadFileSizeLimit,
    				encType,
    				new DefaultFileRenamePolicy());
    		String fileName = multi.getFilesystemName("uploadFile");
    		if(fileName == null){
    			System.out.print("파일 업로드 실패");
    		}
    		else{
				article.setNum(Integer.parseInt(multi.getParameter("num")));
    			article.setSubject(multi.getParameter("subject"));
    			article.setEmail(multi.getParameter("email"));
    			article.setContent(multi.getParameter("content"));
    			article.setPass(multi.getParameter("pass"));
    			article.setFilename(fileName);
    		    int check = dbPro.updateArticle(article); 
    		    if(check == 1){
 %>
    <meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%= pageNum %>">
<%    } else { %>
    <script>

        alert("비밀번호가 맞지 않습니다.");
        history.go(-1);

    </script>
<%    }
    		}
    	}catch(Exception e){
    		System.out.print("예외 발생 : " + e);
    		e.printStackTrace();
    	}
    	
%>

