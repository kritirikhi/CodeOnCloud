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
        
        System.out.println(codetext);
        System.out.println(language);
        
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
        
        if(language.equals("C") || language.equals("C++") || language.equals("Python")){
            Date date = new Date();
            long milli = date.getTime();
            filename = milli+"";
        }
        else{
            filename = codetext.substring(codetext.indexOf("class")+6,codetext.indexOf("{")).trim();
        }
        
        FileWriter fw = new FileWriter(f1+"\\"+filename+".java");
        for(int i=0;i<codetext.length();i++){
            fw.write(codetext.charAt(i));
        }
        
        fw.flush();
        fw.close();
        
        out.println("success");
        
//        int fid = Integer.parseInt(request.getParameter("fid"));
//        try{
//            ResultSet rs = DBLoader.executeSQl("select * from friends where fid='"+fid+"'");
//            if(rs.next()){
//                rs.deleteRow();
//                String type="Success";
//                String message="Request Canceled";
//                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
//                out.println(jsondata);
//            }  
//            else{
//                String type="Error";
//                String message="Already Canceled";
//                String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
//                out.println(jsondata);
//            }
//        }
//        catch(Exception e){
//            String type="Error";
//            String message="server error";
//            String jsondata = "{"+"\"type\":"+"\""+type+"\""+","+"\"message\":"+"\""+message+"\""+"}";
//            out.println(jsondata);
//        }
    }

}
