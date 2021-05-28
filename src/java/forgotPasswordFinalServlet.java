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
public class forgotPasswordFinalServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        // getting data from the request
        String newpassword = request.getParameter("newpassword");
        String confirmnewpassword = request.getParameter("confirmnewpassword");
        String username = request.getParameter("username");
        
        System.out.println(newpassword);
        System.out.println(confirmnewpassword);
        System.out.println(username);
      
        // performing validations at server side
        if (newpassword.length()==0){
            String type = "Error";
            String message = "Password Fields Are Mandatory";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata);    
        }
        else if(confirmnewpassword.length()==0){
            String type = "Error";
            String message = "Password Fields Are Mandatory";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata);  
        }
        
        else if(!( newpassword.equals(confirmnewpassword) )){
            String type = "Error";
            String message = "Passwords Do Not Match";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata);   
        }
        else if(newpassword.length()<8){
            String type = "Error";
            String message = "Password is very short";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata);   
        }
        else if(newpassword.length()>45){
            String type = "Error";
            String message = "Password Can Not Be Too Long";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata); 
        }
        
        else{
            try{
                ResultSet rs  = DBLoader.executeSQl("select * from users where username='"+username+"'");
                if(rs.next()){
                    rs.updateString("password",newpassword);
                    rs.updateRow();
                    
                    String type = "Success";
                    String message = "Password is Changed, Login Again";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                    out.println(jsondata);                   
                }
                else{
                    String type = "Error";
                    String message = "Invalid Username";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                    out.println(jsondata);    
                }
            }
            catch(Exception e){
                e.printStackTrace();
                String type = "Error";
                String message = "Server Error";
                String otp="";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
            }
        }
    }
}
