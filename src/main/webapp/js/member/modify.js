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