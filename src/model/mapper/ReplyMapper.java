package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Reply;

public interface ReplyMapper {

	@Select("select ifnull(max(replyno),0) from reply")
	int maxnum();

	@Insert("insert into reply"
			+ "(replyno, boardno, id, repdate, repcontent)"
			+ "values(#{replyno}, #{boardno}, #{id}, now(), #{repcontent})")
	void insert(Reply r);

	@Select({"<script>",
		"select * from reply ",
		"where boardno = #{boardno}",   
		"</script>"})
	List<Reply> select(Map<String, Object> map);

	@Select({"<script>",
			"select count(*) from reply",
			"where boardno = #{boardno}",
			"</script>"})
	int replyCount(Map<String, Object> map);

	@Delete("delete from reply where replyno=#{replyno} and boardno=#{boardno}")
	int delete(@Param("replyno") int replyno, @Param("boardno") int boardno);

	@Select({"<script>",
			"select * from reply where replyno = #{replyno}",
			"</script>"})
	List<Reply> selectone(Map<String, Object> map);

	@Update("update reply set repdate=now(), repcontent=#{repcontent} where replyno=#{replyno}")
	void update(Reply r);

}
