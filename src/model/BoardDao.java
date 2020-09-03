package model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.mapper.BoardMapper;

public class BoardDao {
	private Class<BoardMapper> cls = BoardMapper.class;
	private Map<String, Object> map = new HashMap<>();
	
	//게시물의 최대 번호 리턴
	public int maxnum() {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).maxnum();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}
	
	public boolean insert(Board b) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			session.getMapper(cls).insert(b);
			return true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return false;
	}
	
	public int boardCount(String column, String search) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			map.clear();
			//subject,name 값이 들어왔을 때,
			if(column != null) {
				String[] cols = column.split(","); // 콤마를 기준으로 나눈 값들이 배열로 배치
				map.put("col1", cols[0]);  // col1 키값에 value는 subject
				if(cols.length > 1) {   
					map.put("col2", cols[1]);  //col2 키값에 value 는 name
				}
				if(cols.length > 2) {
					map.put("col3", cols[2]);
				}
			}
			map.put("search", search);
			return session.getMapper(cls).boardCount(map);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}
	
	public List<Board> list(int pageNum,int limit, String column, String search){
		  SqlSession session = MyBatisConnection.getConnection(); 
	      try {
	    	  map.clear();
	    	  if(column != null) {
					String[] cols = column.split(",");
					map.put("col1", cols[0]);
					if(cols.length > 1) {
						map.put("col2", cols[1]);
					}
					if(cols.length > 2) {
						map.put("col3", cols[2]);
					}
				}
	    	  map.put("start", (pageNum-1)*limit);
	    	  map.put("limit", limit);
	    	  map.put("search", search);
	    	  return session.getMapper(cls).select(map);
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	    	  MyBatisConnection.close(session);
	      }
	      return null;
	   }
	
	public Board selectOne(int boardno) {
		SqlSession session = MyBatisConnection.getConnection();
	    try {
	    	map.clear();
	    	map.put("boardno", boardno);
	    	List<Board> list = session.getMapper(cls).select(map);
	    	return list.get(0);
	    }catch(Exception e) {
	    	e.printStackTrace();
	    }finally {
	    	MyBatisConnection.close(session);
	    }
	    return null;
	}

	public void readcntAdd(int boardno) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			session.getMapper(cls).readcntAdd(boardno);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
	   
	}
	
	public boolean update(Board b) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			session.getMapper(cls).update(b);
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return false;
	}
	
	public boolean delete(int boardno) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).delete(boardno);
			if(cnt > 0) return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return false;
		
	}
	
	
	
}
