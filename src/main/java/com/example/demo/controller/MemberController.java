package com.example.demo.controller;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;

@Controller
@RequestMapping("member")
public class MemberController {

	@Autowired
	private MemberService service;

	@GetMapping("signup")
	public void signupForm() {

	}

	@PostMapping("signup")
	public String signupProcess(Member member, RedirectAttributes rttr) {

		try {
			service.signup(member);
			rttr.addFlashAttribute("message", "회원 가입 완료!!");
			return "redirect:/list";
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("member", member);
			rttr.addFlashAttribute("message", "회원 가입 실패..");
			return "redirect:/member/signup";
		}
	}
	
	
	@GetMapping("list")
	public void memberList(Member member, Model model) {
		model.addAttribute("memberList", service.showMemberList(member));
	}
	
	// 경로 : /member/info?id=${member.id}
	@GetMapping("info")
	public void memberInfo(String id, Model model) {
		Member member = service.get(id);
		model.addAttribute("member",member);
	}
	
	@PostMapping("remove")
	public String remove(Member member, RedirectAttributes rttr) {
		
		boolean ok = service.remove(member);
		if (ok) {
			rttr.addFlashAttribute("message", "탈퇴 완료!!");
			return "redirect:/list";
		} else {
			rttr.addFlashAttribute("message", "비밀번호를 확인해 주세요");
			return "redirect:/member/info?id=" + member.getId();
		}
	}
	
	@GetMapping("modify")
	public void modify(Member member, Model model) {
		member = service.get(member.getId());
		model.addAttribute("member", member);
	}
	
	
	@PostMapping("modify")
	public String modifyProcess(Member member, RedirectAttributes rttr, String oldPassword) {
		boolean ok = service.modify(member, oldPassword);
		
		if(ok) {
			rttr.addFlashAttribute("message", "회원정보가 수정되었습니다.");
			return "redirect:/member/info?id=" + member.getId();
		} else {
			rttr.addFlashAttribute("message", "이전 암호를 확인해 주세요.");
			return "redirect:/member/info?id=" + member.getId();
		}
	}
	
	
	
	
	
	
}
