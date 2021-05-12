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
public class userChangePasswordServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // getting data from the request
        String username = request.getParameter("username");
        String oldpassword = request.getParameter("oldpassword");
        String newpassword = request.getParameter("newpassword");
        String confirmnewpassword = request.getParameter("confirmnewpassword");
        
        
        if (username.length()==0  || oldpassword.length()==0 || newpassword.length()==0 || confirmnewpassword.length()==0){
                String type="Error";
                String message="All the Fields are Mandatory";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
        }
        
        else if (!(newpassword.equals(confirmnewpassword))){
            String type="Error";
            String message="New and Confirm Passwords do not Match";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata);
        }
       
        else{
            try{
                // checking the username and password existance in the database;
                ResultSet rs  = DBLoader.executeSQl("Select * from users where username="+"\'"+username+"\'"+" and password="+"\'"+oldpassword+"\'");
                if(rs.next()){
                    rs.updateString("password",newpassword);
                    rs.updateRow();
                    String type = "Success";
                    String message = "Password is Changed. Login Again";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                    request.getSession().removeAttribute("username");
                    out.println(jsondata);
                }

                // password changed failure fail
                else{
                    String type="Error";
                    String message="Invalid Username or Old Password";
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
}

