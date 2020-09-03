package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import model.Carememo;

public interface CarememoMapper {

	@Insert("insert into carememo" 
			+ "(memono, id, memo)" 
			+ "values(#{memono}, #{id}, #{memo})")
	void insert(Carememo cm);

	@Select("select ifnull(max(memono),0) from carememo where id=#{id}")
	int maxnum(Carememo cm);

	@Select({"<script>",
		"select memono, memo from carememo ",
		"where id = #{id}",   
		"</script>"})
	List<Carememo> select(Map<String, Object> map);

	@Select("select id from carememo where id = #{id}")
	void selectid(Carememo cm);

}
