<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
	String fileName = request.getParameter("fileName");
	
	String savePath = "/boardone/upload";
	ServletContext context = getServletContext();
	String FilePath = context.getRealPath(savePath);
	
	File file = new File(FilePath, fileName);
	
	String encodeName = URLEncoder.encode(fileName, "utf-8");
	
	byte[] b = new byte[5*1024*1024];
	
	FileInputStream fis = new FileInputStream(file);
	BufferedInputStream bis = new BufferedInputStream(fis);
	
	response.setHeader("Content-Disposition", "attachment; filename=" + encodeName);
	
	out.clear();
	out = pageContext.pushBody();
	BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());

	int numRead = 0;
	
	while((numRead = bis.read(b,0,b.length)) != -1){
		bos.write(b,0,numRead);
	}
	bos.flush();
	bos.close();
	bis.close();
	
%>