package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.mapper.DailycareMapper;

public class DailycareDao {
	private Class<DailycareMapper> cls = DailycareMapper.class;
	private Map<String, Object> map = new HashMap<>();
	
	public boolean insert(Dailycare dc) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			session.getMapper(cls).insert(dc);
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return false;
	}

	public List<Dailycare> selectdc(String search, String id) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			map.clear();
			map.put("search", search);
			map.put("id", id);
			return session.getMapper(cls).select(map);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return null;
	}

	public int dccount(String search, String id) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			map.clear();
			map.put("search", search);
			map.put("id", id);
			return session.getMapper(cls).dccount(map);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}

	public boolean update(Dailycare dc) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			session.getMapper(cls).update(dc);
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return false;
	}

	public List<Map<String, Integer>> dcgraph(String id) {
		SqlSession session = MyBatisConnection.getConnection();
		List<Map<String, Integer>> list = null;
		try {
			list = session.getMapper(cls).graph(id);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return list;
	}


	
}
