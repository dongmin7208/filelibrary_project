package filelibrary;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.*;

public class FileDao {
	private static FileDao instance = null;
	private FileDao() {}
	public static FileDao getInstance() {
		if(instance == null) {
			synchronized(FileDao.class) {
				instance = new FileDao();
			}
		}
		return instance;
	}
	
    public List<FileDto> getArticles(/* 수정<1> */){
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<FileDto> articleList = null;
        try{
            conn = ConnUtil.getConnection();
            /* 수정<2> */
            pstmt = conn.prepareStatement(
                                        "select * from FILELIBRARY order by NUM desc"); //수정<3>
            rs = pstmt.executeQuery();
            if(rs.next()){
                articleList = new ArrayList<FileDto>(); //수정<4>
                do {
                    FileDto article = new FileDto();
                    article.setNum(rs.getInt("num"));
                    article.setWriter(rs.getString("writer"));
                    article.setEmail(rs.getString("email"));
                    article.setSubject(rs.getString("subject"));
                    article.setPass(rs.getString("pass"));
                    article.setReadcount(rs.getInt("readcount"));
                    article.setRegdate(rs.getTimestamp("regdate"));
                    article.setContent(rs.getString("content"));
                    article.setFilename(rs.getString("filename"));
                    articleList.add(article);
                } while(rs.next());
            }
        } catch(Exception e){
            e.printStackTrace();
        } finally{
            if(rs != null) try { rs.close(); } catch (SQLException e){}
            if(pstmt != null) try { pstmt.close(); } catch (SQLException e){}
            if(conn != null) try { conn.close(); } catch (SQLException e){}
        }
        return articleList;
    }
	
	
    
    public void insertArticle(FileDto article){
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        try{
            conn = ConnUtil.getConnection();
            sql = "insert into FILELIBRARY"
                    + "(NUM, WRITER, EMAIL, SUBJECT, PASS, "
                    + "REGDATE, CONTENT, FILENAME) "
                    + "values(FILELIBRARY_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, article.getWriter());
            pstmt.setString(2, article.getEmail());
            pstmt.setString(3, article.getSubject());
            pstmt.setString(4, article.getPass());
            pstmt.setTimestamp(5, article.getRegdate());
            pstmt.setString(6, article.getContent());
            pstmt.setString(7, article.getFilename());
            pstmt.executeQuery();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(rs != null) try { rs.close(); } catch (SQLException e){}
            if(pstmt != null) try { pstmt.close(); } catch (SQLException e){}
            if(conn != null) try { conn.close(); } catch (SQLException e){}
        }
    }


	public int getArticleCount(){
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int x = 0;
	    try{
	        conn = ConnUtil.getConnection();
	        pstmt = conn.prepareStatement("select count(*) from FILELIBRARY");
	        rs = pstmt.executeQuery();
	        if(rs.next()){
	            x = rs.getInt(1);
	        }
	    } catch(Exception e){
	        e.printStackTrace();
	    } finally{
	        if(rs != null) try { rs.close(); } catch (SQLException e){}
	        if(pstmt != null) try { pstmt.close(); } catch (SQLException e){}
	        if(conn != null) try { conn.close(); } catch (SQLException e){}
	    }
	    return x;
	}

	  public FileDto getArticle(int num){
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        FileDto article = null;
	        try{
	            conn = ConnUtil.getConnection();
	            pstmt = conn.prepareStatement(
	                    "update FILELIBRARY set READCOUNT=READCOUNT+1 where NUM = ?");
	            pstmt.setInt(1, num);
	            pstmt.executeQuery();
	            pstmt.close();
	            pstmt = conn.prepareStatement("select * from FILELIBRARY where NUM = ?");
	            pstmt.setInt(1, num);
	            rs = pstmt.executeQuery();
	            if(rs.next()){
	                article = new FileDto();
	                article.setNum(rs.getInt("num"));
	                article.setWriter(rs.getString("writer"));
	                article.setEmail(rs.getString("email"));
	                article.setSubject(rs.getString("subject"));
	                article.setPass(rs.getString("pass"));
	                article.setRegdate(rs.getTimestamp("regdate"));
	                article.setReadcount(rs.getInt("readcount"));
	                article.setContent(rs.getString("content"));
	                article.setFilename(rs.getString("filename"));
	            }
	        } catch(Exception e){
	            e.printStackTrace();
	        } finally{
	            if(rs != null) try { rs.close(); } catch (SQLException e){}
	            if(pstmt != null) try { pstmt.close(); } catch (SQLException e){}
	            if(conn != null) try { conn.close(); } catch (SQLException e){}
	        }
	        return article;
	    }

	
	  
	  public FileDto updateGetArticle(int num){
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    FileDto article = null;
		    try{
		        conn = ConnUtil.getConnection();
		        pstmt = conn.prepareStatement("select * from FILELIBRARY where NUM = ?");
		        pstmt.setInt(1, num);
		        rs = pstmt.executeQuery();
		        if(rs.next()){
		            article = new FileDto();
		            article.setNum(rs.getInt("num"));
		            article.setWriter(rs.getString("writer"));
		            article.setEmail(rs.getString("email"));
		            article.setSubject(rs.getString("subject"));
		            article.setPass(rs.getString("pass"));
		            article.setRegdate(rs.getTimestamp("regdate"));
		            article.setReadcount(rs.getInt("readcount"));
		            article.setContent(rs.getString("content"));
		            article.setFilename(rs.getString("filename"));
		        }
		    } catch(Exception e){
		        e.printStackTrace();
		    } finally{
		        if(rs != null) try { rs.close(); } catch (SQLException e){}
		        if(pstmt != null) try { pstmt.close(); } catch (SQLException e){}
		        if(conn != null) try { conn.close(); } catch (SQLException e){}
		    }
		    return article;
		}
	  
	  
	  
	  public int updateArticle(FileDto article){
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    String dbpassword = "";
		    String sql = "";
		    int result = -1; //결과 값
		    try{
		        conn = ConnUtil.getConnection();
		        pstmt = conn.prepareStatement("select PASS from FILELIBRARY where NUM = ?");
		        pstmt.setInt(1, article.getNum());
		        rs = pstmt.executeQuery();
		        if(rs.next()){
		            dbpassword = rs.getString("pass");//비밀번호 비교
		    
		            if(dbpassword.equals(article.getPass())){
		                sql = "update FILELIBRARY set EMAIL=?,"
		                    + "SUBJECT=?,CONTENT=?,FILENAME=? where NUM=?";
		                pstmt.close();
		                pstmt = conn.prepareStatement(sql);
		                pstmt.setString(1, article.getEmail());
		                pstmt.setString(2, article.getSubject());
		                pstmt.setString(3, article.getContent());
		                pstmt.setString(4, article.getFilename());
		                pstmt.setInt(5, article.getNum());
		                pstmt.executeQuery();
		                result = 1; //수정 성공
		            } else {
		                result = 0; //수정 실패
		            }
		        }
		    } catch(Exception e){
		        e.printStackTrace();
		    } finally{
		        if(rs != null) try { rs.close(); } catch (SQLException e){}
		        if(pstmt != null) try { pstmt.close(); } catch (SQLException e){}
		        if(conn != null) try { conn.close(); } catch (SQLException e){}
		    }
		    return result;
		}

	  
	  public int deleteArticle(int num, String pass){
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    String dbpasswd = "";
		    int result = -1; //결과 값
		    try{
		        conn = ConnUtil.getConnection();
		        pstmt = conn.prepareStatement(
		                "select PASS from FILELIBRARY where NUM=?");
		        pstmt.setInt(1, num);
		        rs = pstmt.executeQuery();
		        if(rs.next()){
		            dbpasswd = rs.getString("pass");
		            if(dbpasswd.equals(pass)){
		                pstmt.close();
		                pstmt = conn.prepareStatement("delete from FILELIBRARY where NUM=?");
		                pstmt.setInt(1, num);
		                pstmt.executeQuery();
		                result = 1; //글삭제 성공
		            } else {
		                result = 0; //비밀번호 틀림
		            }
		        }
		    }catch(Exception e){
		        e.printStackTrace();
		    } finally{
		        if(rs != null) try { rs.close(); } catch (SQLException e){}
		        if(pstmt != null) try { pstmt.close(); } catch (SQLException e){}
		        if(conn != null) try { conn.close(); } catch (SQLException e){}
		    }
		    return result;
		}

	  
	

}
