package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface MemberMapper {

	@Insert("""
			INSERT INTO Member (id, password, nickName, email)
			VALUES (#{id}, #{password}, #{nickName}, #{email})
			
			""")
	int insert(Member member);

	@Select("""
			SELECT *
			FROM Member
			ORDER By inserted DESC
			LIMIT 10
			""")
	List<Member> selectMemberList(Member member);

	@Select("""
			SELECT *
			FROM Member m LEFT JOIN MemberAuthority ma
			ON m.id = ma.memberId
			WHERE 
				id = #{id}
			""")
	@ResultMap("memberMap")
	Member getMemberInfo(String id);

	@Delete("""
			DELETE FROM Member
			WHERE id = #{id}
			""")
	Integer deleteById(Member member);

	@Update("""
			<script>
			UPDATE Member
			SET 
				<if test="password neq null and password neq ''">
				password = #{password},
				</if>
			    nickName = #{nickName},
			    email = #{email}
			WHERE
				id = #{id}

			</script>
			""")
	void update(Member member);

	
	@Select("""
			SELECT * FROM Member
			WHERE nickName = #{nickname}
			""")
	Member selectByNickname(String nickname);

	
	@Select("""
			SELECT * 
			FROM Member
			WHERE email = #{email}
			""")
	Member selectByEmail(String email);

}
