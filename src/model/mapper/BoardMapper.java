package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Board;
import model.Dailycare;


public interface BoardMapper {
	
	@Select("select ifnull(max(boardno),0) from board")
	int maxnum();

	@Insert("insert into board" 
			+ "(boardno, id, title, content, file1, regdate, readcnt)" 
			+ "values(#{boardno}, #{id}, #{title}, #{content}, #{file1}, now(), 0)")
	void insert(Board b);

	@Select({"<script>",
			"select count(*) from board",
			"<if test='col1 != null'> where ${col1} like '%${search}%' </if>",
			"<if test='col2 != null'> or ${col2} like '%${search}%' </if>",
			"<if test='col3 != null'> or ${col3} like '%${search}%' </if>",
			"</script>"})
	int boardCount(Map<String, Object> map);
	
//	@Select("select * from board order by grp desc, grpstep asc limit #{pageNum},#{limit}")
//	List<Board> list(@Param("pageNum")int pageNum, @Param("limit")int limit);

	@Select({"<script>",
			"select * from board",
			"<if test='col1 != null'> where ${col1} like '%${search}%' </if>",
			"<if test='col2 != null'> or ${col2} like '%${search}%' </if>",
			"<if test='col3 != null'> or ${col3} like '%${search}%' </if>",
//			"<if test='num != null'> where num = #{num} </if>",
//			"<if test='pageNum != null || limit != null'> order by grp desc, grpstep asc limit #{start},#{limit} </if>",
			"<choose>",
			"<when test='boardno != null'> where boardno = #{boardno} </when>",
			"<otherwise> order by boardno desc limit #{start}, #{limit} </otherwise>",
			"</choose>",
			"</script>"})
	List<Board> select(Map<String, Object> map);

	@Update("update board set readcnt = readcnt+1 where boardno=#{value}")
	void readcntAdd(int boardno);

	@Update("update board set title=#{title}, content=#{content}, file1=#{file1} where boardno=#{boardno}")
	void update(Board b);

	@Delete("delete from board where boardno=#{value}")
	int delete(int boardno);
	
}
