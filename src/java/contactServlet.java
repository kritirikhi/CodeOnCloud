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
public class contactServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        // getting data from the request
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String phoneno = request.getParameter("phoneno");
        String contactmessage = request.getParameter("message");
      
        // performing validations at server side
        if (firstname.length()==0 || lastname.length()==0 || email.length()==0 || phoneno.length()==0 || contactmessage.length()==0){
                String type="Error";
                String message="All the Fields are Mandatory";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
        }
        
        else if(phoneno.length()!=10){
            String type="Error";
            String message="Phone Number should be of 10 digits";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata);
        }
        
        int flag=0;
        if(phoneno.length()==10){
            for(int i=0;i<phoneno.length();i++){
                if(!(phoneno.charAt(i)>='0' && phoneno.charAt(i)<='9')){
                    String type="Error";
                    String message="Invalid Phone Number";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                    out.println(jsondata);
                    flag=1;
                    break;
                }
            }    
        }
        
        if(flag==0){
            try{
                ResultSet rs  = DBLoader.executeSQl("select * from contact");
                while(rs.next()) {
                }
                rs.moveToInsertRow();
                rs.updateString("firstname", firstname);
                rs.updateString("lastname", lastname);
                rs.updateString("email", email);
                rs.updateString("phoneno", phoneno);
                rs.updateString("message", contactmessage);
                rs.insertRow();

                String type = "Success";
                String message = "Your Messaage Has Been Submitted";
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
