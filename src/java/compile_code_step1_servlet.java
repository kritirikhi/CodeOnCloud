import javax.servlet.annotation.MultipartConfig;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.sql.*;
import java.sql.*;
import java.util.Date;
import utility.DBLoader;


@MultipartConfig
public class compile_code_step1_servlet extends HttpServlet {
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        String codetext = request.getParameter("codetext");
        String language = request.getParameter("language");
        language = language.toLowerCase();
        
        String foldername = "public";
        String filename = "";
        String absolutepath = getServletContext().getRealPath("/all_users_data");
        
        File f = new File(absolutepath+"\\"+foldername);
        if(!(f.exists())){
            f.mkdir();
        }
        
        File f1 = new File(absolutepath+"\\"+foldername+"\\"+language);
        if(!(f1.exists())){
            f1.mkdir();
        }
        
        if(language.equals("c") || language.equals("cpp") || language.equals("python")){
            Date date = new Date();
            long milli = date.getTime();
            filename = milli+"";
        }
        else{
            filename = codetext.substring(codetext.indexOf("class")+6,codetext.indexOf("{")).trim();
        }
        
        FileWriter fw = new FileWriter(f1+"\\"+filename+"."+language);
        for(int i=0;i<codetext.length();i++){
            fw.write(codetext.charAt(i));
        }
        
        fw.flush();
        fw.close();
        
        request.getSession().setAttribute("filename",filename);
        
        out.println("success");
    }
}
