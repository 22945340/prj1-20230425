package com.example.demo.service;

import java.io.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;
import org.springframework.web.multipart.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

import software.amazon.awssdk.services.s3.*;

@Service
@Transactional(rollbackFor = Exception.class)
public class BoardService {
	
	@Autowired
	private S3Client s3;

	@Autowired
	private BoardMapper mapper;
	
	@Value("${aws.s3.bucketName}")
	private String bucketName;

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

	public boolean modify(Board board, MultipartFile[] addFiles, List<String> removeFileNames) throws Exception {
		String dirPath = "C:\\study\\upload\\" + board.getId() ;
		
		// FileName 테이블 삭제
		if (removeFileNames != null && !removeFileNames.isEmpty()) {
			for (String fileName : removeFileNames) {
				
				// 하드 디스크에서 삭제
				String path = dirPath + "\\"  + fileName;
				File file = new File(path);
				File dir = new File(dirPath);
				if (file.exists()) {
					file.delete();
					if (dir.isDirectory() && dir.list().length == 0) {
						dir.delete();
					}
				}
				
				
				// 테이블에서 삭제
				mapper.deleteFileNameByBoardIdAndFileName(board.getId(), fileName);
			}
		}
		
		// 새 파일 추가
		for (MultipartFile newFile : addFiles) {
			if (newFile.getSize() > 0) {
				// 테이블에 파일명 추가
				mapper.insertFileName(board.getId(), newFile.getOriginalFilename());
				
				String fileName = newFile.getOriginalFilename();
				String path = dirPath + "\\" + fileName;
				
				File dir = new File(dirPath);
				
				// 디렉터리 없으면 만들기
				if (!dir.exists()) {
					dir.mkdirs();
				}
				
				// 파일을 하드디스크에 저장
				File file = new File(path);
				newFile.transferTo(file);
			}
		}
		
		// 게시물 (Board) 테이블 수정
		int cnt = mapper.update(board);
		
		return cnt == 1;
	}

	public boolean remove(Integer id) {
		// 파일명 조회
		List<String> fileNames = mapper.selectFileNamesByBoardId(id);
		
		// FileName 테이블의 데이터 지우기
		mapper.deleteFileNameByBoardId(id);
		
		// 하드 디스크의 파일 지우기
		for (String fileName : fileNames) {
			String dirPath = "C:\\study\\upload\\" + id ;
			String path = dirPath + "\\"  + fileName;
			File file = new File(path);
			File dir = new File(dirPath);
			if (file.exists()) {
				file.delete();
				dir.delete();
			}
		}
		
		
		// 게시물 테이블의 데이터 지우기
		int cnt = mapper.deleteById(id);
		return cnt == 1;
	}

	
	public boolean addBoard(Board board, MultipartFile[] files) throws Exception {
		
		// 게시물 insert
		int cnt = mapper.insert(board);
		
		
		for(MultipartFile file : files) {
			if(file.getSize() > 0) {
				System.out.println(file.getOriginalFilename());
				System.out.println(file.getSize());
				
				// (파일 시스템에) 파일 저장
				String folder = "C:\\study\\upload\\" + board.getId();
				File targetFolder = new File(folder);
				if (!targetFolder.exists()) {
					targetFolder.mkdir();
				}
				String path = folder + "\\" + file.getOriginalFilename();
				File target = new File(path);
				file.transferTo(target);
				
				// db에 관련 정보 저장 (insert)
				mapper.insertFileName(board.getId(), file.getOriginalFilename());
				
				
			}
		}
		
		return cnt == 1;
	}

}








