package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
public class BoardService {

	@Autowired
	private BoardMapper mapper;

	public Map<String, Object> listBoard(Integer page, Integer num, String search, String searchOption) {
		Integer startIndex = (page -1) * num;
		
		
		// 데이터 수
		Integer size = mapper.size(search, searchOption);
		
		// 페이지네이션 가장 왼쪽 번호, 오른쪽번호 구하기
//		Integer leftPageNumber = (page - 1) / 10 * 10 + 1;
//		Integer rightPageNumber = leftPageNumber + 9;
		
		Integer leftPageNumber = Math.max(1, page-5);
		Integer rightPageNumber = Math.min(size, page + 5);
		
		
		// 이전버튼 페이지 번호 구하기
		Integer prevPageNumber = Math.max(1, page - 1);
		Integer nextPageNumber = Math.min(size, page + 1);

		// 마지막 페이지 구하기
		Integer lastPageNumber = (size - 1) / num + 1;

		// 2. business logic 처리

		// 오른쪽 페이지 번호가 마지막 페이지 번호보다 클 수 없음
		rightPageNumber = Math.min(rightPageNumber, lastPageNumber);
		
		
		List<Board> boardList = mapper.selectPage(startIndex, num, search, searchOption);
		
		Map<String, Object> pageInfo = new HashMap<>();
		
		pageInfo.put("begin", leftPageNumber);
		pageInfo.put("end", rightPageNumber);
		pageInfo.put("prevPageNumber", prevPageNumber);
		pageInfo.put("nextPageNumber", nextPageNumber);
		pageInfo.put("lastPageNumber", lastPageNumber);
		pageInfo.put("currentPageNumber", page);
		pageInfo.put("num", num);
		

		
		return Map.of("pageInfo", pageInfo, "boardList", boardList);
	}

	public Board getBoard(Integer id) {
		return mapper.selectById(id);
	}

	public boolean modify(Board board) {
		int cnt = mapper.update(board);
		
		return cnt == 1;
	}

	public boolean remove(Integer id) {
		int cnt = mapper.deleteById(id);
		return cnt == 1;
	}

	public boolean addBoard(Board board) {
		int cnt = mapper.insert(board);
//		int cnt = 0;	
		
		return cnt == 1;
	}

}








