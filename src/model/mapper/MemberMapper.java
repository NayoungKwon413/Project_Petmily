package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Member;

public interface MemberMapper {
	@Insert("insert into member" 
			+ "(id, pass, name, email, tel, dname, dage, dsex, dphoto)" 
			+ "values (#{id}, #{pass}, #{name}, #{email}, #{tel}, #{dname}, #{dage}, #{dsex}, #{dphoto})")
	int insert(Member mem);

	@Select({"<script>",
			"select * from member ",
			"<if test='id != null'> where binary id = #{id}</if>",   //binary : 대소문자 구분이 필요할 때 (오라클은 필요없음)
			"</script>"})
	List<Member> select(Map<String, Object> map);

	@Select("select id from member where email=#{email} and tel=#{tel}")
	String findid(@Param("email") String email, @Param("tel") String tel);

	@Select("select pass from member where id=#{id} and email=#{email} and tel=#{tel}")
	String findpw(@Param("id")String id, @Param("email")String email, @Param("tel")String tel);

	@Update("update member set name=#{name}, email=#{email}, tel=#{tel}, dname=#{dname}, dage=#{dage}, dsex=#{dsex}, dphoto=#{dphoto} where id=#{id}")
	int update(Member mem);

	@Update("update member set pass=#{pass} where id=#{id}")
	int updatePass(@Param("id")String id, @Param("pass")String pass);

	@Delete("delete from member where id=#{id}")
	int deletePass(@Param("id")String id);

	@Update("update member set name=#{name}, email=#{email}, tel=#{tel} where id=#{id}")
	int updatead(Member mem);

}
