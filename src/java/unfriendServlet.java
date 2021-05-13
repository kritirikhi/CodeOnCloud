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
public class unfriendServlet extends HttpServlet {
  
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
                rs.deleteRow();
                try{
                    ResultSet rs2 = DBLoader.executeSQl("select * from friends where requestfrom='"+requestto+"' and requestto='"+requestto+"' and status='friends'");
                    if(rs2.next()){
                        rs2.deleteRow();
                    }
                    
                    String type="Success";
                    String message="Unfriend Done Successfully";
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
                String message="Already Unfriend";
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
