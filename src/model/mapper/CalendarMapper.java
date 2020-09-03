package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Board;
import model.Calendar;

public interface CalendarMapper {

	@Insert("insert into calendar"
			+ "(calno, id, startdate, enddate, starttime, endtime, plan)"
			+ "values(#{calno}, #{id}, #{startdate}, #{enddate}, #{starttime}, #{endtime}, #{plan})")
	void insert(Calendar cal);
	
	@Select("select ifnull(max(calno),0) from calendar where id=#{id}")
	int maxcalno(Calendar cal);

	@Select({"<script>",
			"select * from calendar where id=#{id} and calno=#{calno}",
			"</script>"})
	List<Calendar> select(Map<String, Object> map);

	@Delete("delete from calendar where calno=#{calno} and id=#{id}")
	int delete(@Param("calno")int calno, @Param("id")String id);

	@Update("update calendar set "
			+ "startdate=#{startdate}, enddate=#{enddate}, starttime=#{starttime}, endtime=#{endtime}, plan=#{plan}"
			+ "where calno=#{calno} and id=#{id}")
	int update(Calendar cal);

	

}
