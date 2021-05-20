import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.sql.*;
import java.util.Date;
import utility.DBLoader;
import java.lang.*;
import java.util.Map;

@MultipartConfig
public class c_compile_code_step2_servlet extends HttpServlet {
  
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

            String absolutepath = request.getServletContext().getRealPath("/all_users_data");
            absolutepath+="\\"+foldername+"\\"+language;

            File f1 = new File(absolutepath);
            
            ProcessBuilder pb = new ProcessBuilder("cmd", "/c","gcc " + filename + ".c -o "+filename+".exe");
            Map<String,String> enviroment= pb.environment();
            enviroment.clear();
            enviroment.put("Path", path.c);
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
                    File f2= new File(absolutepath+"\\"+filename+".exe");
                    if(f2.exists()){
                        f2.delete();
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
                
                br.close();
            }
            catch(Exception e){
                out.println("Server Error");
            }
        }
        
    }
}
