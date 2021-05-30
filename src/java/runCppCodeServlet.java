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
public class runCppCodeServlet extends HttpServlet {
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        String language = request.getParameter("language");
        String codetext = request.getParameter("codetext");
        String commandargs = request.getParameter("commandargs");
        
        Object fname = request.getSession().getAttribute("filename");
        String filename="";
        if(fname!=null){
            filename = fname.toString();
            
            String foldername = "public";


            String absolutepath = request.getServletContext().getRealPath("/all_users_data");
            absolutepath+="\\"+foldername+"\\"+language;

            File f1 = new File(absolutepath);
            
            ProcessBuilder pb = new ProcessBuilder("cmd", "/c", filename+".exe"+" "+commandargs);
            pb.directory(f1);
            Process p = pb.start();

            InputStreamReader isr = new InputStreamReader(p.getInputStream());
            BufferedReader br = new BufferedReader(isr);
            InputStreamReader isr2 = new InputStreamReader(p.getErrorStream());
            BufferedReader br2 = new BufferedReader(isr2);
            
            String ans1="";
            String ans2="";
            
            while(true){
                String s = br.readLine();
                if(s==null) break;
                ans1+=s;
                ans1+="\n";
            }
            out.println(ans1);
            
            while(true){
                String s = br.readLine();
                if(s==null) break;
                ans2+=s;
                ans2+="\n";
            }
            out.println(ans2);
        }
        
    }
}
