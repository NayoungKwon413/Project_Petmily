package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.mapper.CalendarMapper;

public class CalendarDao {
	private Class<CalendarMapper> cls = CalendarMapper.class;
	private Map<String, Object> map = new HashMap<>();
	
	public int maxcalno(Calendar cal) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).maxcalno(cal);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}
	
	public boolean insert(Calendar cal) {
		System.out.println(cal);
		SqlSession session = MyBatisConnection.getConnection();
		try {
			session.getMapper(cls).insert(cal);
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return false;
	}

	public Calendar selectOne(int calno, String id) {
		SqlSession session = MyBatisConnection.getConnection();
	    try {
	    	map.clear();
	    	map.put("calno", calno);
	    	map.put("id", id);
	    	List<Calendar> list = session.getMapper(cls).select(map);
	    	return list.get(0);
	    }catch(Exception e) {
	    	e.printStackTrace();
	    }finally {
	    	MyBatisConnection.close(session);
	    }
	    return null;
	}

	public boolean delete(int calno, String id) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).delete(calno, id);
			if(cnt > 0) return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return false;
	}

	public boolean update(Calendar cal) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).update(cal);
			if(cnt > 0) return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return false;
	}

	

}
