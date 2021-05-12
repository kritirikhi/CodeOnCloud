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
import java.sql.*;

@MultipartConfig
public class addFriendServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        Object sessionusername = request.getSession().getAttribute("username");           
        if (sessionusername==null){
            String type="Error";
            String message="Login To Add Friend";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata);
        }
        else{
            String requestfrom = request.getSession().getAttribute("username").toString();        
            String requestto = request.getParameter("requestto");
            
            try{
                ResultSet rs = DBLoader.executeSQl("select * from friends where requestfrom='"+requestfrom+"' and requestto='"+requestto+"'");
                if(rs.next()){
                    String type="Already Friend";
                    String message="Request Already Sent";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                    out.println(jsondata);
                }
                else{
                    rs.moveToInsertRow();
                    rs.updateString("requestfrom", requestfrom);
                    rs.updateString("requestto", requestto);
                    rs.insertRow();
                    
                    String type="Request Sent";
                    String message="Request Sent Successfully";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                    out.println(jsondata);
                }
            }
            catch(Exception e){
                e.printStackTrace();
                String type="Error";
                String message="Server Error";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
            }
        }
    }
}
