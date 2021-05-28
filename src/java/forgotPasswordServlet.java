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
public class forgotPasswordServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        // getting data from the request
        String username = request.getParameter("username");
      
        // performing validations at server side
        if (username.length()==0){
            String type = "Error";
            String message = "Username is Mandatory";
            String otp="";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+","+"\"otp\":"+"\""+otp+"\""+"}";
            out.println(jsondata);    
        }
        
        else{
            try{
                ResultSet rs  = DBLoader.executeSQl("select * from users where username='"+username+"'");
                if(rs.next()){
                    String phoneno = rs.getString("phoneno");
                    int otp_int = (int) (1000+(9999-1000)*Math.random());
                    String otp=Integer.toString(otp_int);
                    
                    // send sms to phoneno
                    smssender.sendSMS(phoneno, "Your OTP is "+otp);
                    
                    String type = "Success";
                    String message = "Otp Has Been Sent To Your Registered Number";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+","+"\"otp\":"+"\""+otp+"\""+"}";
                    out.println(jsondata);                    
                }
                else{
                    String type = "Error";
                    String message = "Invalid Username";
                    String otp="";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+","+"\"otp\":"+"\""+otp+"\""+"}";
                    out.println(jsondata);    
                }

            }
            catch(Exception e){
                e.printStackTrace();
                String type = "Error";
                String message = "Server Error";
                String otp="";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+","+"\"otp\":"+"\""+otp+"\""+"}";
                out.println(jsondata);
            }
        }
    }
}
