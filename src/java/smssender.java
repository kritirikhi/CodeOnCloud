import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;


public class smssender {

    static String username = "DSSKriti";
    static String password = "DWZMOXYP";

    static public void sendSMS(String phoneno, String message) {
        new Thread(new Runnable() {
            @Override
            public void run() {

                try {
                    String urlParameters = "username="+username+"&password="+password+"&message=" + message + "&phone_numbers=" + phoneno;
                   
                    urlParameters=urlParameters.replace(" ", "%20");
                    String request = "http://server1.vmm.education/VMMCloudMessaging/AWS_SMS_Sender?"+urlParameters;
                    URL url = new URL(request);
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();

                    
                    
                    DataInputStream dis = new DataInputStream(conn.getInputStream());
                    while (true) {
                        String s = dis.readLine();
                        if (s == null) {
                            break;
                        }
                        System.out.println(s);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }).start();
    }

}
