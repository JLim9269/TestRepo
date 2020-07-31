package mvc.database;

public class DBTest {

	public static void main(String[] args) {
		
		DBConnection con = DBConnection.getInstance();
		con.getConnection();
		if(con!=null)System.out.println("연결 성공!");
		else System.out.println("연결 실패...");
	}
}
