package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.crypto.password.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
@Transactional(rollbackFor = Exception.class)
public class MemberService {

	@Autowired
	private MemberMapper mapper;

	@Autowired
	private BoardLikeMapper likeMapper;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private BoardService boardService;

	@Autowired
	private commentMapper commentMapper;

	public boolean signup(Member member) {
		// 암호 암호화
		String plain = member.getPassword();
		member.setPassword(passwordEncoder.encode(plain));

		int cnt = mapper.insert(member);
		return cnt == 1;
	}

	public List<Member> showMemberList(Member member) {
		return mapper.selectMemberList(member);
	}

	public Member get(String id) {

		return mapper.getMemberInfo(id);
	}

	public boolean remove(Member member) {
		Member oldMember = mapper.getMemberInfo(member.getId());
		int cnt = 0;

		if (passwordEncoder.matches(member.getPassword(), oldMember.getPassword())) {
			// 암호가 일치하면?

			// 이 회원이 작성한 댓글 삭제
			commentMapper.deleteByMemberId(member.getId());

			// 좋아요 누른 게시글들 좋아요 삭제
			likeMapper.deleteByMemberId(member.getId());

			// 이 회원이 작성한 글 삭제
			boardService.removeByWriter(member.getId());

			// 회원 테이블 삭제

			cnt = mapper.deleteById(member);

		} else {
			// 암호가 일치하지 않으면?
		}
		return cnt == 1;

	}

	public boolean modify(Member member, String oldPassword) {

		// 패스워드를 바꾸기 위해 입력햇다면..
		if (!member.getPassword().isBlank()) {

			// 입력된 패스워드를 암호화
			String plain = member.getPassword();
			member.setPassword(passwordEncoder.encode(plain));
		}

		Member oldMember = mapper.getMemberInfo(member.getId());

		int cnt = 0;

		if (passwordEncoder.matches(oldPassword, oldMember.getPassword())) {
			mapper.update(member);
			return cnt == 0;
		} else {
			return cnt == 1;
		}
	}

	public Map<String, Object> checkId(String id) {
		Member member = mapper.getMemberInfo(id);
		return Map.of("available", member == null);
	}

	public Map<String, Object> checkNickname(String nickname) {
		Member member = mapper.selectByNickname(nickname);
		if (member != null) {
			return Map.of("available", member == null, "id", member.getId());
		} else {
			return Map.of("available", member == null);
		}
	}

	public Map<String, Object> checkEmail(String email) {
		Member member = mapper.selectByEmail(email);

		if (member == null) {
			return Map.of("available", member == null);
		} else {
			return Map.of("available", member == null, "id", member.getId());
		}

	}

}
