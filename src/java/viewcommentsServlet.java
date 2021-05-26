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

@MultipartConfig
public class viewcommentsServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        Object sessionusername = request.getSession().getAttribute("username");
        if(sessionusername==null){
            String type="Error";
            String message="Login To View Comments";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata);
        }
        else{
            try{
                int shid = Integer.parseInt(request.getParameter("shid"));
                String commentsjson = new RDBMS_TO_JSON().generateJSON("select * from comments where shid='"+shid+"'");
                out.println(commentsjson);
            }
            catch(Exception e){
                String type="Error";
                String message="Server Error";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
            }
        }
    }
}

