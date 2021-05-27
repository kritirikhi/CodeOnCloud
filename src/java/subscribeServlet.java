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
public class subscribeServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // getting data from the request
        String email = request.getParameter("email");
        
        // performing validations at server side
        if (email.length()==0){
                String type="Error";
                String message="Email is Mandatory";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
        }
        
            try{
                ResultSet rs  = DBLoader.executeSQl("Select * from subscribe where email="+"\'"+email+"\'");
                if(rs.next()){
                    String type = "Error";
                    String message = "Email already Submitted";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                    out.println(jsondata);
                }

                // add data to DB
                else{
                    rs  = DBLoader.executeSQl("select * from subscribe");
                    while(rs.next()) {
                    }
                    rs.moveToInsertRow();
                    rs.updateString("email", email);
                    rs.insertRow();

                    String type = "Success";
                    String message = "Email Added Successfully";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                    out.println(jsondata);
                }   
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
