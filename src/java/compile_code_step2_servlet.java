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
public class compile_code_step2_servlet extends HttpServlet {
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String language = request.getParameter("language");
        Object fname = request.getSession().getAttribute("filename");
        String filename="";
        if(fname!=null){
            filename = fname.toString();
            
            String foldername = "public";

            ProcessBuilder pb = new ProcessBuilder("cmd","/C","javac "+filename+".java");

            String absolutepath = request.getServletContext().getRealPath("/all_users_data");
            absolutepath+="\\"+foldername+"\\"+language;

            File f1 = new File(absolutepath);
            pb.directory(f1);
            Process p = pb.start();

            String ans="";
            InputStream is=null;

            try{
                int exitCode = p.waitFor();
                if(exitCode==0){
                    is=p.getInputStream();
                    out.println("File Saved And Compiled Successfully");   
                }
                else{
                    is=p.getErrorStream();
                    File f2 = new File(absolutepath+"\\"+filename+".java");
                    File f3 = new File(absolutepath+"\\"+filename+".class");
                    if(f2.exists()){
                        f2.delete();
                    }
                    if(f3.exists()){
                        f3.delete();
                    }
                    out.println("Compilation Error");
                }
                InputStreamReader isr = new InputStreamReader(is);
                BufferedReader br = new BufferedReader(isr);
                
                while(true){
                    String s = br.readLine();
                    System.out.println("while loop"+s);
                    if(s==null) break;
                    out.println(s); 
                }
            }
            catch(Exception e){
                out.println("Server Error");
            }
        }
        
    }
}
