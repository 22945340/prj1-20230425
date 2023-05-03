package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.servlet.mvc.support.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;

@Controller
@RequestMapping("/")
public class BoardController {

	@Autowired
	private BoardService service;

	// 경로 : http://localhost:8080?page=3
	// 경로 : http://localhost:8080/list?page=5
	// 게시물 목록
//	@RequestMapping(value = {"/", "list"}, method = RequestMethod.GET)
	@GetMapping({ "/", "list" })
	public String list(@RequestParam(value = "page", defaultValue = "1") Integer page,
					@RequestParam(value = "num", defaultValue = "10")  Integer num ,
					@RequestParam(value = "search", defaultValue = "") String search,
					String searchOption,
					Model model) {

		
		Map<String, Object> result = service.listBoard(page, num, search, searchOption);

//		model.addAttribute("boardList", result.get("boardList"));
//		model.addAttribute("pageInfo", result.get("pageInfo"));
		model.addAllAttributes(result);

		// 4. forward/redirect
		return "list";
	}

	@GetMapping("/id/{id}")
	public String board(@PathVariable("id") Integer id, Model model) {
		// 1. request param
		// 2. business logic
		Board board = service.getBoard(id);
		// 3. add attribute
		model.addAttribute("board", board);
		// 4. forward/redirect
		
		System.out.println(board.getFileName());
		return "get";
	}

	@GetMapping("/modify/{id}")
	public String modifyForm(@PathVariable("id") Integer id, Model model) {
		model.addAttribute("board", service.getBoard(id));
		return "modify";
	}

//	@RequestMapping(value = "/modify/{id}", method = RequestMethod.POST)
	@PostMapping("/modify/{id}")
	public String modifyProcess(Board board,
			@RequestParam(value="removeFiles", required = false) List<String> removeFileNames,
			RedirectAttributes rttr) {

		System.out.println(removeFileNames);
		boolean ok = service.modify(board, removeFileNames);

		if (ok) {
			// 해당 게시물 보기로 리디렉션
//			rttr.addAttribute("success", "modify");
			rttr.addFlashAttribute("message", board.getId() + "번 게시물이 수정되었습니다.");
			return "redirect:/id/" + board.getId();
		} else {
			// 수정 form 으로 리디렉션
//			rttr.addAttribute("fail", "modify");
			rttr.addFlashAttribute("message", board.getId() + "번 게시물이 수정되지 않았습니다.");
			return "redirect:/modify/" + board.getId();
		}
	}

	@PostMapping("remove")
	public String remove(Integer id, RedirectAttributes rttr) {
		boolean ok = service.remove(id);
		if (ok) {
//			rttr.addAttribute("success", "remove"); - Query String에 추가
			rttr.addFlashAttribute("message", id + "번 게시물이 삭제되었습니다.");
			return "redirect:/list";
		} else {
			return "redirect:/id/" + id;
		}
	}

	@GetMapping("add")
	public void addForm() {
		// 게시물 작성 form (view)로 포워드

	}

	@PostMapping("add")
	public String addProcess(@RequestParam("files") MultipartFile[] files,
			Board board, RedirectAttributes rttr) throws Exception {
		// 새 게시물 db에 추가
		// 1.

		// 2.
		boolean ok = service.addBoard(board, files);

		// 3.
		if (ok) {
			;
			rttr.addFlashAttribute("message", board.getId() + "번 게시물이 등록되었습니다.");
			return "redirect:/id/" + board.getId();
		} else {
			rttr.addFlashAttribute("board", "게시물 등록 중 문제가 발생하였습니다.");
			return "redirect:/add";
		}

		// 4.
	}
}
