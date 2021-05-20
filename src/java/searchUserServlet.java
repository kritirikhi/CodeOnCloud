import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.sql.*;
import java.util.Date;
import java.util.Base64;

import utility.DBLoader;
import utility.FileUploader;
import utility.RDBMS_TO_JSON;
import utility.encryptDecrypt;

public class searchUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        Object sessionusername = request.getSession().getAttribute("username");
        if(sessionusername==null){
            String type="Error";
            String message="Login To View User Profile";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata);
        }
        else{
            String keyword = request.getParameter("keyword");
            String loginUsername = request.getSession().getAttribute("username").toString();
            try{
                String jsondata = new RDBMS_TO_JSON().generateJSON("select * from users where name like '%"+keyword+"%' and username!='"+loginUsername+"'");
                out.println(jsondata);
            }
            catch(Exception e){
                out.println("Error");
            }
        }
    }
}

