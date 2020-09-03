package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Carememo;
import model.Dailycare;

public interface DailycareMapper {

	@Insert("insert into dailycare" 
			+ "(caredate, id, weight, bcs)" 
			+ "values(#{caredate}, #{id}, #{weight}, #{bcs})")
	void insert(Dailycare dc);

	@Select({"<script>",
		"select caredate, weight, bcs from dailycare ",
		"where id= #{id} and caredate= '${search}'",
		"</script>"})
	List<Dailycare> select(Map<String, Object> map);

	@Select({"<script>",
		"select count(*) from dailycare",
		"where id = #{id} and caredate = '${search}'",
		"</script>"})
	int dccount(Map<String, Object> map);

	@Update("update dailycare set weight=#{weight}, bcs=#{bcs} where caredate=#{caredate} and id=#{id}")
	void update(Dailycare dc);

	@Select("select caredate, weight, bcs from dailycare where id=#{id} order by caredate")
	List<Map<String, Integer>> graph(String id);

	
	
}
