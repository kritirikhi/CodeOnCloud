package utility;

import java.util.Base64;

public class encryptDecrypt {
    public static String getEncodedString(String password1){
        return Base64.getEncoder().encodeToString(password1.getBytes());
    }
    public static String getDecodedString(String encryptPassword){
        return new String(Base64.getMimeDecoder().decode(encryptPassword));
    }
}
