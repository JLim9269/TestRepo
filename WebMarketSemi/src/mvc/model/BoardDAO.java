package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import mvc.database.DBConnection;

public class BoardDAO {
	
	private static BoardDAO instance;
	
	private BoardDAO() {}

	public static BoardDAO getInstance() {
		if(instance==null)instance = new BoardDAO();
		return instance;
	}

	public int getListCount(String items, String text) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int x = 0;
		
		if(items==null||text.trim().length()==0) {
			sql = "select count(*) from board";
		}else {
			sql = "select count(*) from board where "+items+" like '%"+text+"%'";
		}
		
		try {
			con = DBConnection.getInstance().getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next())x = rs.getInt(1);
		}catch(Exception e) {
			System.out.println("getListCount()에러:"+e);
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(con!=null)con.close();
			}catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		return x;
	}

	public List<BoardDTO> getBoardList(int pageNum, int limit, String items, String text) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int total_record = getListCount(items, text);
		int start = (pageNum-1)*limit;
		int index = start+1;
		
		if(items==null||text.trim().length()==0) {
			sql = "select * from board order by num desc";
		}else {
			sql = "select * from board where "+items+" like '%"+text+"%' order by num desc";
		}
		
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		try {
			con = DBConnection.getInstance().getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.absolute(index)) {
				BoardDTO board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setRegist_day(rs.getString("regist_day"));
				board.setHit(rs.getInt("hit"));
				board.setIp(rs.getString("ip"));
				
				list.add(board);
				if(index<(start+limit)&&index<=total_record) {
					index++;
				}else {
					break;
				}
			}
		}catch(Exception e) {
			System.out.println("getBoardList()에러:"+e);
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(con!=null)con.close();
			}catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		return list;
	}
}