import javax.servlet.annotation.MultipartConfig;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.sql.*;
import java.sql.*;
import java.util.Date;
import utility.DBLoader;
import java.lang.*;


@MultipartConfig
public class saveCodeServlet extends HttpServlet {
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        Object sessionusername = request.getSession().getAttribute("username");
        if(sessionusername==null){
            String type="Error";
            String message="Login To Save Your Code";
            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
            out.println(jsondata);
        }
        else{
            
            String language = request.getParameter("language");
            language=language.toLowerCase();
            String codeTitle = request.getParameter("codeTitle");
            String username = request.getSession().getAttribute("username").toString();
            String filename = request.getSession().getAttribute("filename").toString();
            
            String extension=null;
            if(language.equals("java")){
                extension="java";
            }
            else if(language.equals("c")){
                extension="c";
            }
            else if(language.equals("cpp")){
                extension="cpp";
            }
            else if(language.equals("python")){
                extension="py";
            }
            
            String foldername="public";
            
            
            String absolutepath = request.getServletContext().getRealPath("/all_users_data");
            
            File f = new File(absolutepath+"\\"+username);
            if(!(f.exists())){
                f.mkdir();
            }
        
            File f1 = new File(absolutepath+"\\"+username+"\\"+language);
            if(!(f1.exists())){
                f1.mkdir();
            }
            
            String oldpath = absolutepath + "\\" + foldername + "\\" + language + "\\" + filename + "." + extension;
            String newpath = absolutepath + "\\" + username + "\\" + language + "\\" + filename + "." + extension;
            
            
            FileReader fr = new FileReader(oldpath);    
            FileWriter fw = new FileWriter(newpath);
           
            int i;    
            while((i=fr.read())!=-1){  
                fw.write((char)i);
            }
            fw.flush();
            fw.close();
            fr.close();   
            
            try{
                ResultSet rs = DBLoader.executeSQl("select * from savedcodes");
                while(rs.next()) {
                }
                rs.moveToInsertRow();
                rs.updateString("lang", language);
                rs.updateString("title", codeTitle);
                rs.updateString("username", username);
                rs.updateString("filepath", newpath);
                rs.insertRow();
                
                String type="Success";
                String message="Code Saved Successfully";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
            }
            catch(Exception e){
                e.printStackTrace();
                String type="Error";
                String message="Server Error";
                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
                out.println(jsondata);
            }
        }
        
    }
}
