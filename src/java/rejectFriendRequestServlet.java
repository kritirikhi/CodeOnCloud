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
public class rejectFriendRequestServlet extends HttpServlet {
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        int fid = Integer.parseInt(request.getParameter("fid"));
        try{
            ResultSet rs = DBLoader.executeSQl("select * from friends where fid='"+fid+"'");
            if(rs.next()){
                rs.deleteRow();
                String type="Success";
                String message="Request Rejected";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
            }  
            else{
                String type="Error";
                String message="Already Rejected";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
            }
        }
        catch(Exception e){
            String type="Error";
            String message="server error";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata);
        }
    }

}
