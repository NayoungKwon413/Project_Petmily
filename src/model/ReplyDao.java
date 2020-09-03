package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.mapper.BoardMapper;
import model.mapper.ReplyMapper;

public class ReplyDao {
	private Class<ReplyMapper> cls = ReplyMapper.class;
	private Map<String, Object> map = new HashMap<>();
	
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

	public boolean insert(Reply r) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			session.getMapper(cls).insert(r);
			return true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return false;
	}

	public List<Reply> replist(int boardno) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			map.clear();
			map.put("boardno", boardno);
			List<Reply> replist = session.getMapper(cls).select(map);
			return replist;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return null;
	}

	public int replycount(int boardno) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			map.clear();
			map.put("boardno", boardno);
			return session.getMapper(cls).replyCount(map);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}

	public boolean delete(int replyno, int boardno) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).delete(replyno, boardno);
			if(cnt > 0) return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return false;
	}

	public Reply selectOne(int replyno) {
		SqlSession session = MyBatisConnection.getConnection();
	    try {
	    	map.clear();
	    	map.put("replyno", replyno);
	    	List<Reply> list = session.getMapper(cls).selectone(map);
	    	return list.get(0);
	    }catch(Exception e) {
	    	e.printStackTrace();
	    }finally {
	    	MyBatisConnection.close(session);
	    }
	    return null;
	}

	public boolean update(Reply r) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			session.getMapper(cls).update(r);
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return false;
	}

//	public Reply selectOne(int boardno, int replyno) {
//		SqlSession session = MyBatisConnection.getConnection();
//	    try {
//	    	map.clear();
//	    	map.put("boardno", boardno);
//	    	map.put("replyno", replyno);
//	    	List<Reply> list = session.getMapper(cls).selectone(map);
//	    	return list.get(0);
//	    }catch(Exception e) {
//	    	e.printStackTrace();
//	    }finally {
//	    	MyBatisConnection.close(session);
//	    }
//	    return null;
//	}

//	public Reply selectOne(int replyno) {
//		// TODO Auto-generated method stub
//		return null;
//	}

}
