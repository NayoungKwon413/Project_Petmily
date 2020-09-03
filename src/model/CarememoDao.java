package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.mapper.CarememoMapper;

public class CarememoDao {
	private Class<CarememoMapper> cls = CarememoMapper.class;
	private Map<String, Object> map = new HashMap<>();
	//no의 최대 번호 리턴
		public int maxnum(Carememo cm) {
			SqlSession session = MyBatisConnection.getConnection();
			try {
				return session.getMapper(cls).maxnum(cm);
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				MyBatisConnection.close(session);
			}
			return 0;
		}
	
	public boolean insert(Carememo cm) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			session.getMapper(cls).insert(cm);
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return false;
	}

	public List<Carememo> memolist(String id) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			map.clear();
			map.put("id", id);
			List<Carememo> memolist = session.getMapper(cls).select(map);
			return memolist;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return null;
	}

	public boolean selectid(Carememo cm) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			session.getMapper(cls).selectid(cm);
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			MyBatisConnection.close(session);
		}
		return false;
	}
}
