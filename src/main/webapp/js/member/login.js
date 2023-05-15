$("#showPassword").click(function() {
	if ($("#inputPassword").attr("type") == "password") {
		$("#inputPassword").attr("type", "text")
		$("#showPassword").html(`<i class="fa-solid fa-eye"></i>`)
	} else {
		$("#inputPassword").attr("type", "password")
		$("#showPassword").html(`<i class="fa-solid fa-eye-slash"></i>`)
	}
})