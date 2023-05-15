let checkId = true;
let checkEmail = true;
let checkNickName = true;
let checkPassword = true;

function enableSubmit() {
	if (checkId && checkEmail && checkNickName && checkPassword) {
		$("#modifySubmit").removeAttr("disabled");
	} else {
		$("#modifySubmit").attr("disabled", "");
	}

}

$("#inputPassword,#inputPasswordCheck").keyup(function() {
	const pw1 = $("#inputPassword").val();
	const pw2 = $("#inputPasswordCheck").val();

	if (pw1 == pw2) {
		$("#modifySubmit").removeClass("disabled");
		$("#passwordSuccessText").removeClass("d-none");
		$("#passwordFailText").addClass("d-none");
		checkPassword = true;

	} else {
		$("#modifySubmit").addClass("disabled");
		$("#passwordFailText").removeClass("d-none");
		$("#passwordSuccessText").addClass("d-none")
		checkPassword = false;
	}
	enableSubmit();
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
				} else {
					$("#availableNicknameMessage").addClass("d-none");
					$("#notAvailableNickNameMessage").removeClass("d-none");
					checkNickName = false;
				}
			}
		},
		complete: enableSubmit
	})
})


$("#inputNickName").keyup(function() {
	const userId = $("#inputId").val();
	const userNickName = $("#inputNickName").val();
	$.ajax("/member/checkNickname/" + userNickName, {
		success: function(data) {

			if (data.id == userId) {
				checkNickName = true;
				$("#availableNicknameMessage").addClass("d-none");
				$("#notAvailableNickNameMessage").addClass("d-none");
			} else {
				checkNickName = false;
				$("#availableNicknameMessage").addClass("d-none");
				$("#notAvailableNickNameMessage").addClass("d-none");
			}

		},
		complete: enableSubmit
	})
})





$("#checkEmailBtn").click(function() {
	const userId = $("#inputId").val();
	const userEmail = $("#inputEmail").val();
	$.ajax("/member/checkEmail/" + userEmail, {
		success: function(data) {
			if (data.available) {
				$("#availableEmailMessage").removeClass("d-none");
				$("#notAvailableEmailMessage").addClass("d-none");
				checkEmail = true;
			} else {
				if (data.id == userId) {
					$("#availableEmailMessage").removeClass("d-none");
					$("#notAvailableEmailMessage").addClass("d-none");
					checkEmail = true;
				} else {
					$("#availableEmailMessage").addClass("d-none");
					$("#notAvailableEmailMessage").removeClass("d-none");
					checkEmail = false;
				}
			}
		},
		complete: enableSubmit
	})
})


$("#inputEmail").keyup(function() {
	const userId = $("#inputId").val();
	const userEmail = $("#inputEmail").val();
	$.ajax("/member/checkEmail/" + userEmail, {
		success: function(data) {
			if (data.id == userId) {
				checkEmail = true;
				$("#availableEmailMessage").addClass("d-none")
				$("#notAvailableEmailMessage").addClass("d-none")
			} else {
				checkEmail = false;
				$("#availableEmailMessage").addClass("d-none")
				$("#notAvailableEmailMessage").addClass("d-none")
			}

		},
		complete: enableSubmit

	})

})



// 비밀번호 표시
$("#showPassword").click(function() {
	if ($("#inputPassword").attr("type") == "password") {
		$("#inputPassword").attr("type", "text")
		$("#showPassword").html(`<i class="fa-solid fa-eye"></i>`)
	} else {
		$("#inputPassword").attr("type", "password")
		$("#showPassword").html(`<i class="fa-solid fa-eye-slash"></i>`)
	}
})

$("#showPasswordCheck").click(function() {
	if ($("#inputPasswordCheck").attr("type") == "password") {
		$("#inputPasswordCheck").attr("type", "text")
		$("#showPasswordCheck").html(`<i class="fa-solid fa-eye"></i>`)
	} else {
		$("#inputPasswordCheck").attr("type", "password")
		$("#showPasswordCheck").html(`<i class="fa-solid fa-eye-slash"></i>`)
	}
})

$("#showOldPassword").click(function() {
	if ($("#inputOldPassword").attr("type") == "password") {
		$("#inputOldPassword").attr("type", "text")
		$("#showOldPassword").html(`<i class="fa-solid fa-eye"></i>`)
	} else {
		$("#inputOldPassword").attr("type", "password")
		$("#showOldPassword").html(`<i class="fa-solid fa-eye-slash"></i>`)
	}
})





