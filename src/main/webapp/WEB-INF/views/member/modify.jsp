<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>

	<my:navBar></my:navBar>

	<my:alert></my:alert>

	<div class="container-lg">
		<div class="row justify-content-center">
			<div class="col-12 col-md-8 col-lg-6">
				<h1>회원 정보 수정</h1>

				<form id="modifyForm" action="/member/modify" method="post">
					<div class="mb-3">
						<label class="form-label" for="inputId"> 아이디 </label>
						<input id="inputId" class="form-control" type="text" name="id" value="${member.id }" readonly />
					</div>
					<div class="mb-3">
						<label class="form-label" for="inputPassword"> 패스워드 </label>
						<div class="input-group">
						<input id="inputPassword" class="form-control" type="password" name="password" value="" />
						<button id="showPassword" type="button" class="btn btn-outline-secondary">
								<i class="fa-solid fa-eye-slash"></i>
						</button>
						</div>
						<div class="form-text">입력하지 않으면 기존 패스워드를 유지합니다.</div>
					</div>
					<div class="mb-3">
						<label class="form-label" for="inputPasswordCheck"> 패스워드 확인 </label>
						<div class="input-group">						
						<input id="inputPasswordCheck" class="form-control" type="password" value="" />
						<button id="showPasswordCheck" type="button" class="btn btn-outline-secondary">
								<i class="fa-solid fa-eye-slash"></i>
						</button>	
						</div>
						<div id="passwordSuccessText" class="formtext text-primary d-none">
							<i class="fa-solid fa-check"></i>
							패스워드 일치!
						</div>
						<div id="passwordFailText" class="formtext text-danger d-none">
							<i class="fa-solid fa-triangle-exclamation"></i>
							패스워드 불일치!
						</div>
					</div>
					
					
					<div class="mb-3">
						<label for="inputNickName" class="form-label">별명</label>
						<div class="input-group">
							<input id="inputNickName" type="text" class="form-control" name="nickName" value="${member.nickName }" />
							<button class="btn btn-outline-secondary" type="button" id="checkNickNameBtn">중복확인</button>
						</div>

						<div class="d-none form-text text-primary" id="availableNicknameMessage">
							<i class="fa-solid fa-check"></i>
							사용 가능한 별명입니다.
						</div>
						<div class="d-none form-text text-danger" id="notAvailableNickNameMessage">
							<i class="fa-solid fa-triangle-exclamation"></i>
							사용 불가능한 별명입니다.
						</div>

					</div>
					
					
					<div class="mb-3">
						<label for="inputEmail" class="form-label">이메일</label>
						<div class="input-group">
							<input id="inputEmail" type="email" class="form-control" name="email" value="${member.email }" />
							<button class="btn btn-outline-secondary" type="button" id="checkEmailBtn">중복확인</button>
						</div>

						<div class="d-none form-text text-primary" id="availableEmailMessage">
							<i class="fa-solid fa-check"></i>
							사용 가능한 이메일입니다.
						</div>
						<div class="d-none form-text text-danger" id="notAvailableEmailMessage">
							<i class="fa-solid fa-triangle-exclamation"></i>
							사용 불가능한 이메일입니다.
						</div>
					</div>
					
					
					

					<button id="modifySubmit" type="button" data-bs-toggle="modal" data-bs-target="#confirmModal" class="btn btn-outline-primary ">수정</button>
					<a href="#" class="btn btn-outline-secondary" onclick="history.back()">취소</a>
				</form>

			</div>
		</div>
	</div>

	<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">수정 확인</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<label for="inputOldPassword">이전 암호</label>
					<div class="input-group">
					<input form="modifyForm" id="inputOldPassword" type="password" name="oldPassword" class="form-control" />
					<button id="showOldPassword" type="button" class="btn btn-outline-secondary">
								<i class="fa-solid fa-eye-slash"></i>
						</button>	
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-outline-primary" form="modifyForm">수정</button>
					<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="/js/member/modify.js"></script>
</body>
</html>




