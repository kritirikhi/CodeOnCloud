import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import utility.DBLoader;


@MultipartConfig
public class shareCodeServlet extends HttpServlet {
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        Object sessionusername = request.getSession().getAttribute("username");
        if(sessionusername==null){
            String type="Error";
            String message="Login To Share Code";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata);
        }
        else{
            String sharedwith = request.getParameter("sharedwith");
            int scid = Integer.parseInt(request.getParameter("scid"));
            System.out.println(scid);
            try{
                ResultSet rs2 = DBLoader.executeSQl("select * from savedcodes where scid='"+scid+"'");
                String lang=null;
                if(rs2.next()){
                    lang = rs2.getString("lang");
                }
                try{
                    ResultSet rs = DBLoader.executeSQl("select * from sharedcodes");
                    while(rs.next()) {
                    }
                    rs.moveToInsertRow();
                    rs.updateInt("scid",scid);
                    rs.updateString("sharedwith", sharedwith);
                    rs.updateString("lang", lang);
                    rs.updateString("ownedby", sessionusername.toString());
                    rs.insertRow();

                    String type="Success";
                    String message="Code Shared Successfully";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                    out.println(jsondata);
                 }
                catch(Exception e){
                    e.printStackTrace();
                    String type="Error";
                    String message="inner Server Error";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                    out.println(jsondata);
                }
            }
            catch(Exception e){
                e.printStackTrace();
                String type="Error";
                String message="outer Server Error";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
            }
        }
    }

}
