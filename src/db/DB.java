package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.Question;

/**
 * Created by Ryan on 16/03/2018.
 */
public class DB {
	private Connection connection;
	private static final String DB_URL = "jdbc:mysql://localhost:3306/";
	private static final String DB_SCHEMA = "CE903Group3";
	private static final String DB_USER = "root";
	private static final String DB_PASSWD = "1234";
	private static final String DB_DRIVER_CLASS = "com.mysql.jdbc.Driver";
	public String activeUser;

	public DB() {
		try {
			Class.forName(DB_DRIVER_CLASS);
		} catch (ClassNotFoundException e) {
			e.printStackTrace(System.err);
		}
		try {
			connection = DriverManager.getConnection(DB_URL + DB_SCHEMA, DB_USER, DB_PASSWD);
		} catch (SQLException e) {
			try {
				connection = DriverManager.getConnection(DB_URL + DB_SCHEMA, DB_USER, "");
			} catch (SQLException se) {
				se.printStackTrace(System.err);
			}
		}
	}

	public ResultSet getUser(String id, String pass) throws SQLException {
		activeUser = id;
		PreparedStatement statement = connection
				.prepareStatement("SELECT * FROM users WHERE userid=" + id + " AND password=" + pass);
		return statement.executeQuery();
	}
	

	public int getLastQuestion() throws SQLException {
		PreparedStatement statement = connection.prepareStatement("SELECT * FROM users WHERE userid=" + activeUser);
		ResultSet resultSet = statement.executeQuery();
		int result = 0;
		while (resultSet.next()) {
			result = resultSet.getInt("lastquestion");
		}
		return result;
	}
	
	public String getUserName() throws SQLException{
		PreparedStatement statement = connection
				.prepareStatement("SELECT * FROM users WHERE userid=" + activeUser);
		ResultSet resultSet = statement.executeQuery();
		String result = "";
		while (resultSet.next()) {
			result = resultSet.getString("firstname");
		}
		return result;
	}
	
	public List<Question> getQuestions() throws SQLException{
        PreparedStatement statement = connection
                .prepareStatement("SELECT * FROM questions");
        ResultSet rs = statement.executeQuery();
        List<Question> result = new ArrayList<>() ;
        while (rs.next()) {
			Question question = new Question() ;
			question.setId(rs.getInt("idquestion"));
			question.setSystema(rs.getInt("systema"));
			question.setSystemb(rs.getInt("systemb"));
			result.add(question);
        }
        return result;
    }
	

	public void checkQuestion(int question) throws SQLException {
		PreparedStatement statement = connection
				.prepareStatement("SELECT * FROM questions WHERE idquestion=" + question);
		ResultSet resultSet = statement.executeQuery();
		int count = 0;
		while (resultSet.next()) {
			count++;
		}
		if (count == 0) {
			PreparedStatement statement2 = connection
					.prepareStatement("INSERT INTO questions VALUES (" + question + ",0,0)");
			statement2.executeUpdate();
		}
	}

	public void chooseSystem1(int question) throws SQLException {
		checkQuestion(question);
		PreparedStatement statement = connection
				.prepareStatement("UPDATE questions SET systema = systema + 1 WHERE idquestion=" + question);
		statement.executeUpdate();
	}

	public void chooseSystem2(int question) throws SQLException {
		checkQuestion(question);
		PreparedStatement statement = connection
				.prepareStatement("UPDATE questions SET systemb = systemb + 1 WHERE idquestion=" + question);
		statement.executeUpdate();
	}

	public void nextQuestion() throws SQLException {
		PreparedStatement statement = connection
				.prepareStatement("UPDATE users SET lastquestion = lastquestion + 1 WHERE userid=" + activeUser);
		statement.executeUpdate();
	}
	
	

	public void log(String string) {
		System.out.println(string);
	}
	
	public String getActiveUser() {
		return activeUser;
	}
	
	public void resetActiveUser() {
		activeUser = null;
	}
}
