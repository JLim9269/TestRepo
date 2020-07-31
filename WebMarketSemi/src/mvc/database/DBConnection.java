package mvc.database;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

import javax.servlet.ServletContext;

public class DBConnection {

	private static DBConnection instance = new DBConnection();
	
	private DBConnection() {}

	public static DBConnection getInstance() {
		return instance;
	}
	
	public Connection getConnection() {
		Connection con = null;
		String url = "";
		String user = "";
		String password = "";
		String driver = "";
		try {	
			File file = new File("C:\\jspworkspace\\WebMarket18\\src\\mvc\\database\\dbconnection.properties");
			FileInputStream fis = new FileInputStream(file);
			Properties props = new Properties();
			props.load(fis);
			url = props.getProperty("url");
			user = props.getProperty("user");
			password = props.getProperty("password");
			driver = props.getProperty("driver");
			
			Class.forName(driver);
			con = DriverManager.getConnection(url,user,password);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}