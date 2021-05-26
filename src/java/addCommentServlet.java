import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.sql.*;
import java.util.Date;
import java.util.Base64;

import utility.DBLoader;
import utility.FileUploader;
import utility.encryptDecrypt;


@MultipartConfig
public class addCommentServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        Object sessionusername = request.getSession().getAttribute("username");
        if(sessionusername==null){
            String type="Error";
            String message="Login To Add Comment";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata);
        }
      
        else{
            try{
                String commenttext = request.getParameter("commenttext");
                int shid = Integer.parseInt(request.getParameter("shid"));
                ResultSet rs  = DBLoader.executeSQl("Select * from comments");
                while(rs.next()){
                    
                }
                rs.moveToInsertRow();
                rs.updateString("commenttext", commenttext);
                rs.updateInt("shid",shid);
                rs.updateString("commentedby",sessionusername.toString());
                rs.insertRow();
                
                String type = "Success";
                String message = "Comment Added Successfully";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
            }
            catch(Exception e){
                e.printStackTrace();
                String type = "Error";
                String message = "Server Error";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
            }
        }
    }
}

