const toast = new bootstrap.Toast(document.querySelector("#liveToast"));


$("#likeIcon").click(function() {

	// 게시물 번호 request body에 추가
	const boardId = $("#boardIdText").text().trim();
	const data = { boardId };

	$.ajax("/like", {
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(data),

		success: function(data) {
			if(data.like){
				$("#likeIcon").html(`<i class="fa-solid fa-heart"></i>`);
			} else {
				$("#likeIcon").html(`<i class="fa-regular fa-heart"></i>`);
			}
			
			$("#likeNumber").text(data.count);
		},
		error: function(jqXHR){
			// console.log("좋아요를 누르기 전에 로그인 해 주세요");
			// console.log(jqXHR);
			// console.log(jqXHR.responseJSON);
			
			// $("body").prepend(jqXHR.responseJSON.message)
			
			$(".toast-body").text(jqXHR.responseJSON.message);
			toast.show();
		}

	})
})