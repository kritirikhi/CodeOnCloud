package utility;
import java.io.DataInputStream;
import java.io.FileOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

public class FileUploader 
{
      public static String savefileonserver(Part part,String abspath)
        {
            try
            {
            //File Upload Logic
            //Part part1= request.getPart("fn");
            
            String filename = getFileName(part);
            long filesize = part.getSize();
        
            System.out.println("File Name "+filename);
            System.out.println("File Size "+filesize);
            if(filename==null)
            {
                return "not-a-file";
            }
            else
            {
              //Write file and return filename  
              DataInputStream dis=new DataInputStream(part.getInputStream());
              FileOutputStream fos=new FileOutputStream(abspath+"/"+ filename);
            
              byte b[]=new byte[10000];
              long count=0;
              int r;
            
              while(true)
              {
               r= dis.read(b,0,10000);
               count=count+r;
               fos.write(b, 0, r);
               
               if(count==filesize)
               {
                   break;
               }
              }
            
              fos.close();
            
              return filename;
            }
           }
           catch(Exception ex)
           {
               ex.printStackTrace();
               return ex.getMessage();
           }
        }
         
      
      public static String savefileonserver(Part part,String abspath,String newfilenameonserver)
        {
            try
            {
            //File Upload Logic
            //Part part1= request.getPart("fn");
            
            String filename = getFileName(part);
            long filesize = part.getSize();
        
            System.out.println("File Name "+filename);
            System.out.println("File Size "+filesize);
            if(filename==null)
            {
                return "not-a-file";
            }
            else
            {
              //Write file and return filename  
              filename=newfilenameonserver;
              
              DataInputStream dis=new DataInputStream(part.getInputStream());
              FileOutputStream fos=new FileOutputStream(abspath+"/"+ filename);
            
              byte b[]=new byte[10000];
              long count=0;
              int r;
            
              while(true)
              {
               r= dis.read(b,0,10000);
               count=count+r;
               fos.write(b, 0, r);
               
               if(count==filesize)
               {
                   break;
               }
              }
            
              fos.close();
            
              return filename;
            }
           }
           catch(Exception ex)
           {
               ex.printStackTrace();
               return ex.getMessage();
           }
        }
         
      
      private static String getFileName(final Part part) 
      {
        final String partHeader = part.getHeader("content-disposition");
  
        for (String content : part.getHeader("content-disposition").split(";"))
        {
        if (content.trim().startsWith("filename")) 
        {
            return content.substring(
                    content.indexOf('=') + 1).trim().replace("\"", "");
        }
    }
    return null;
}
}
