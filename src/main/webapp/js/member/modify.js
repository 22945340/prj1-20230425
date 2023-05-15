$("#inputPassword,#inputPasswordCheck").keyup(function() {
	const pw1 = $("#inputPassword").val();
	const pw2 = $("#inputPasswordCheck").val();

	if (pw1 == pw2) {
		$("#modifySubmit").removeClass("disabled");
		$("#passwordSuccessText").removeClass("d-none");
		$("#passwordFailText").addClass("d-none");

	} else {
		$("#modifySubmit").addClass("disabled");
		$("#passwordFailText").removeClass("d-none");
		$("#passwordSuccessText").addClass("d-none")
	}
})


$("#checkNickNameBtn").click(function() {
	const userId = $("#inputId").val();
	const userNickName = $("#inputNickName").val();
	$.ajax("/member/checkNickname/" + userNickName, {
		success: function(data) {
			if (data.available) {
				$("#availableNicknameMessage").removeClass("d-none");
				$("#notAvailableNickNameMessage").addClass("d-none");
				checkNickName = true;
			} else {
				if (data.id == userId) {
					$("#availableNicknameMessage").removeClass("d-none");
					$("#notAvailableNickNameMessage").addClass("d-none");
					checkNickName = true;
				} else{
					$("#availableNicknameMessage").addClass("d-none");
					$("#notAvailableNickNameMessage").removeClass("d-none");
					checkNickName = false;
				}
			}
		}
	})
})


$("#inputNickName").keyup(function(){
	$("#availableNicknameMessage").addClass("d-none");
	$("#notAvailableNickNameMessage").addClass("d-none");
})