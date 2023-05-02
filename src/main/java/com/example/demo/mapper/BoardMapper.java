package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface BoardMapper {

	@Select("""
			<script>
			<bind name="pattern" value="'%' + search + '%'" />
			SELECT
				b.id id,
				title,
				writer,
				inserted,
				COUNT(f.id) fileCount
			FROM 
				Board b LEFT JOIN FileName f ON b.id = f.boardId				
			<choose>
			
			<when test="searchOption == 'writerTitle'">
			WHERE
				title LIKE #{pattern}
				OR
				writer LIKE #{pattern}
			</when>
				
			<when test="searchOption == 'title'">
			WHERE
				title LIKE #{pattern}
			</when>
			
			<when test="searchOption == 'writer'">
			WHERE
				writer LIKE #{pattern}	
			</when>
			
			</choose>
			GROUP BY
				b.id
				
			ORDER BY 
				b.id DESC
			LIMIT
			#{startIndex}, #{num}
			</script>
			""")
	@ResultMap("boardListMap")
	List<Board> selectPage(Integer startIndex, Integer num, String search, String searchOption);

	
	
	@Select("""
			SELECT 
				b.id,
				b.title,
				b.body,
				b.inserted,
				b.writer,
				f.fileName
			FROM Board b LEFT JOIN FileName f ON b.id=f.boardId
			WHERE b.id = #{id}
			""")
	@ResultMap("boardResultMap")
	Board selectById(Integer id);

	@Update("""
			UPDATE Board
			SET 
				title = #{title},
				body = #{body},
				writer = #{writer}
			WHERE
				id = #{id}
			""")
	int update(Board board);

	@Delete("""
			DELETE FROM Board
			WHERE id = #{id}
			""")
	int deleteById(Integer id);

	@Insert("""
			INSERT INTO Board (title, body, writer)
			VALUES (#{title}, #{body}, #{writer})
			""")
	@Options(useGeneratedKeys = true, keyProperty = "id")
	int insert(Board board);

	@Select("""
			<script>
			<bind name="pattern" value="'%' + search + '%'" />
			SELECT COUNT(*) FROM Board
			
			<choose>
				<when test="searchOption == 'writerTitle'">
				WHERE
					title LIKE #{pattern}
					OR
					writer LIKE #{pattern}
				</when>
					
				<when test="searchOption == 'title'">
				WHERE
					title LIKE #{pattern}
				</when>
				
				<when test="searchOption == 'writer'">
				WHERE
					writer LIKE #{pattern}	
				</when>
				
			</choose>
			</script>
			""")
	Integer size(String search, String searchOption);


	@Insert("""
			INSERT INTO FileName (boardId, fileName)
			VALUES
			(#{boardId}, #{fileName})
			""")
//	@Options(useGeneratedKeys = true, keyProperty = "id")
	void insertFileName(Integer boardId, String fileName);

	
}





