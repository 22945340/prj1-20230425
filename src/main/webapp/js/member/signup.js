$("#inputPassword, #inputPasswordCheck").keyup(function() { // 패스워드, 패스워드 체크에 키업 이벤트 발생하면
	// 패스워드에 입력한 값 
	const pw1 = $("#inputPassword").val();
	// 패스워드확인에 입력한 값		
	const pw2 = $("#inputPasswordCheck").val();

	if (pw1 == pw2) { // 같으면
		// submit버튼 disabled 삭제
		$("#signupSubmit").removeClass("disabled");
		// 패스워드 일치 메시지 출력
		$("#passwordSuccessText").removeClass("d-none");
		$("#passwordFailText").addClass("d-none");
	} else { // 같지 않으면
		// submit버튼 disabled 추가
		$("#signupSubmit").addClass("disabled");
		// 패스워드 불일치 매시지 출력
		$("#passwordFailText").removeClass("d-none");
		$("#passwordSuccessText").addClass("d-none");
	}

})
