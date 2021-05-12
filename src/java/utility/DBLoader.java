package utility;
import java.sql.*;
public class DBLoader {
    public static ResultSet executeSQl(String sql) throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cloudcompiler", "root", "2026dkka");
        
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        
        ResultSet rs = stmt.executeQuery(sql);
        return rs;
    }
}
