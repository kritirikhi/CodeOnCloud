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
public class userLoginServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        // getting data from the request
        String lusername = request.getParameter("lusername");
        String lpassword = request.getParameter("lpassword");
        
        Object sessionusername = request.getSession().getAttribute("username");
        if(sessionusername!=null){
            if (request.getSession().getAttribute("username").toString().equals(lusername)){
                String type="Error";
                String message="User Is Already Logged In";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
            }
        }
        
        else if (lusername.length()==0  || lpassword.length()==0){
                String type="Error";
                String message="All the Fields are Mandatory";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
        }
       
        else{
            try{
                // checking the username and password existance in the database;
                ResultSet rs  = DBLoader.executeSQl("Select * from users where username="+"\'"+lusername+"\'"+" and password="+"\'"+lpassword+"\'");
                if(rs.next()){
                    String type = "Success";
                    String message = "Login Successfull";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                    request.getSession().setAttribute("username",lusername);
                    out.println(jsondata);
                }

                // login fail
                else{
                    String type="Error";
                    String message="Invalid Username or Password";
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

