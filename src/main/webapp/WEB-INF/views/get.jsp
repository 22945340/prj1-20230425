<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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

	<my:navBar />
	<my:alert />

	<div class="container-lg">
		<div class="row justify-content-center ">
			<div class="col-12 col-md-8 col-lg-6">
				<h2>
					<span id="boardIdText">
					${board.id }
				</span>
				번게시물
				</h2>
				<div>
						<h2>
							<span id="likeIcon">
								<i class="fa-regular fa-heart"></i>
							</span>
							<span id="likeNumber">
								<%-- ${board.like} --%>
							</span>
						</h2>
					</div>
				<hr />
				<div class="mb-3">

					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="name" var="userId" />
						<c:if test="${userId eq board.writer }">
							<a class="btn btn-outline-primary" href="/modify/${board.id }">수정</a>
							<button id="removeButton" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">삭제</button>
						</c:if>
					</sec:authorize>
					<button type="button" class="btn btn-outline-success" onclick="location.href='/add'">글쓰기</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='/list'" style="float: right; margin: 0px 1px;">이전▽</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='/list'" style="float: right; margin: 0px 1px;">목록으로</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='/list'" style="float: right; margin: 0px 1px;">다음△</button>
				</div>
				<div class="mb-3">
					<label for="" class="form-label">제목</label>
					<input type="text" class="form-control" value="${board.title}" readonly />
				</div>

				<!-- 그림 파일 출력 -->
				<div class="mb-3">
					<c:forEach items="${board.fileName }" var="fileName">
						<div class="mb-3">
							<img class="img-thumbnail img-fluid" src="${bucketUrl }/${board.id }/${fileName}" alt="" />
							<br />
						</div>
					</c:forEach>
				</div>


				<div class="mb-3">
					<label for="" class="form-label">본문</label>
					<textarea rows="10" class="form-control" readonly>${board.body}</textarea>
				</div>

				<div class="mb-3">
					<label for="" class="form-label">작성자</label>
					<input type="text" class="form-control" value="${board.writer}" readonly />
				</div>

				<div class="mb-3">
					<label for="" class="form-label">작성일시</label>
					<input type="datetime" class="form-control" value="${board.inserted}" readonly />
				</div>
			</div>
		</div>
	</div>

	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="name" var="userId" />
		<c:if test="${userId eq board.writer }">
			<div class="d-none">
				<form action="/remove" method="post" id="removeForm">
					<input type="text" name="id" value="${board.id }" />
				</form>
			</div>

			<!-- Modal -->
			<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="exampleModalLabel">삭제 확인</h1>
							<button type="button" class="btn-outline-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">삭제하시겠습니까?</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-outline-danger" form="removeForm">삭제</button>
							<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</c:if>
	</sec:authorize>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="/js/board/like.js"></script>

</body>
</html>








