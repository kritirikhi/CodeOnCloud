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
public class acceptFriendRequestServlet extends HttpServlet {
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        int fid = Integer.parseInt(request.getParameter("fid"));
        try{
            ResultSet rs = DBLoader.executeSQl("select * from friends where fid='"+fid+"'");
            if(rs.next()){
                String requestto = rs.getString("requestto");
                String requestfrom = rs.getString("requestfrom");
                rs.updateString("status", "friends");
                rs.updateRow();
                try{
                    ResultSet rs2 = DBLoader.executeSQl("select * from friends where fid='"+fid+"'");
                    rs2.moveToInsertRow();
                    rs2.updateString("requestto", requestfrom);
                    rs2.updateString("requestfrom", requestto);
                    rs2.updateString("status", "friends");
                    rs2.insertRow();
                    
                    String type="Success";
                    String message="You Are Now Friends";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                    out.println(jsondata);
                }
                catch(Exception e){
                    String type="Error";
                    String message="server error inner";
                    String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                    out.println(jsondata);
                }
            }  
            else{
                String type="Error";
                String message="Already Friends";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
            }
        }
        catch(Exception e){
            String type="Error";
            String message="server error outer";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata);
        }
    }

}
