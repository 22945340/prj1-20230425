// 로그인 표시
$("#showPassword").click(function() {
	if ($("#inputPassword").attr("type") == "password") {
		$("#inputPassword").attr("type", "text")
		$("#showPassword").html(`<i class="fa-solid fa-eye"></i>`)
	} else {
		$("#inputPassword").attr("type", "password")
		$("#showPassword").html(`<i class="fa-solid fa-eye-slash"></i>`)
	}
})

// caps lock 표시

document.querySelector("#inputPassword").addEventListener('keyup',function(event){
	if(event.getModifierState('CapsLock')){
		$("#capsLockCheck").removeClass("d-none")
	} else{
		$("#capsLockCheck").addClass("d-none")
	}
})

