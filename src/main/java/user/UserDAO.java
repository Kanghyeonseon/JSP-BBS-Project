package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	//생성자
	public UserDAO() {
		try {
			
			/*----- MYSQL 접속정보 시작--- */
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			// 내 컴퓨터에 설치된 MYSQL의 포트번호가 3306이기때문에 localhost:3306이라고 하면 MYSQL에 접속하겠다는뜻이다. 거기서 BBS라는 데이터베이스에 접속하도록 한다.
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			//MYSQL드라이버를 찾을 수 있도록해준다.
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			//conn객체에 접속 정보가 담기게 된다.
			/*----- MYSQL 접속정보 끝--- */
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
		
	//로그인 함수 구현
	public int login(String userID, String userPassword) {
		String SQL =  "SELECT userPassword FROM USER WHERE userID = ?";
		//실제로 데이터베이스에서 입력 할 SQL문장
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					// ResultSet의 1번 인덱스의 값이라는건 데이터베이스에 입력된 패스워드이고 이 값이 userPassword(유저가 입력한 패스워드의 값)과 같은지 물어보는 것이다.
					return 1;
					// 로그인 성공을 의미하는 값을 알려준다.
				} else { return 0; }
					// 비밀번호가 틀렸다는 것을 의미한다.
			}
			return -1;
			// 아이디가 없다고 알려주는 값이다.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
		//데이터베이스 오류를 의미한다.
	}
	
	public int join(User user) {
		String SQL ="INSERT into USER values(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
			// insert를 실행한 경우 반드시 0 이상의 숫자가 반환된다. -1이 아닌경우 성공적으로 회원가입이 이루어졌다고 볼 수 있다.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

}