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
public class userSignupServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // getting data from the request
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneno = request.getParameter("phoneno");
        String gender = request.getParameter("gender");
        String primarylanguage = request.getParameter("primarylanguage");
        String password1 = request.getParameter("password1");
        String password2 = request.getParameter("password2");
        Part photo = request.getPart("photo");
      
        // performing validations at server side
        if (username.length()==0 || name.length()==0 || email.length()==0 || phoneno.length()==0 || gender.length()==0 || primarylanguage.length()==0 || password1.length()==0 || password2.length()==0){
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
        
        else if (!(password1.equals(password2))){
            String type="Error";
            String message="Passowrd do not match";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata);
        }
            
        else if (password1.length()<8){
            String type="Error";
            String message="Password should be of more than 7 characters";
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
                // checking the username and email id existance in the database;
                ResultSet rs  = DBLoader.executeSQl("Select * from users where username="+"\'"+username+"\'");
                if(rs.next()){
                    String type = "Error";
                    String message = "Username already taken";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                    out.println(jsondata);
                }

                // add data to DB
                else{
                    rs  = DBLoader.executeSQl("select * from users");
                    while(rs.next()) {
                    }
                    rs.moveToInsertRow();
                    rs.updateString("username", username);
                    rs.updateString("name", name);
                    rs.updateString("email", email);
                    rs.updateString("phoneno", phoneno);
                    rs.updateString("gender", gender);
                    rs.updateString("password", password1);
                    rs.updateString("username", username);
                    rs.updateString("primarylanguage", primarylanguage);

                    // add data to database
                    String phototype = photo.getContentType();
                    int idx = phototype.indexOf("/");
                    String extension = phototype.substring(idx+1);
                    Date date = new Date();
                    long milli = date.getTime();
                    String newphotoname = "cloudcompiler"+(java.time.LocalDate.now()).toString()+" at "+milli+"."+extension;
                    String photopath = getServletContext().getRealPath("/myuploads")+"\\"+newphotoname;
                    rs.updateString("photo",newphotoname);
                    rs.insertRow();

                    // save files on server
                    String photoupload = FileUploader.savefileonserver(photo,getServletContext().getRealPath("/myuploads"),newphotoname);
                    String type = "Success";
                    String message = "User Added Successfully";
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
