package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DbConnection {
	private DbConnection() {}   //생성자 : 접근제어자가 private => 객체 생성을 막겠다는 의미 
	static Connection getConnection() {  //static => 클래스 메서드. 클래스의 객체화 필요없이 '클래스명.멤버명'으로 사용가능
			Connection conn = null;
			try {
				Class.forName("org.mariadb.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/petmilydb","scott","4151");
			}catch(Exception e) {
				e.printStackTrace();
			}
			return conn;
		}
		static void close(Connection conn, Statement stmt, ResultSet rs) {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}

