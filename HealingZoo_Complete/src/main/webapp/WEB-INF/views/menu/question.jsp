<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.margin {
	width: 100%;
	height: 70px;
}
#searchIcon:hover {
	cursor: pointer;
}
.title{
		max-width: 200px; /* 원하는 최대 길이 설정 */
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
	}
</style>
<title>문의 게시판</title>
</head>
<body>
	<!-- 헤더 -->
	<%@ include file='../common/logoBar.jsp'%>
	<%@ include file='../common/mainCategoryBar.jsp'%>
	<!-- /헤더 -->
	<div class='margin'></div>

	<div class="container text-center">
		<div class="row">
			<div class="col"></div>
			<div class="col-8 text-start">
				<h2 style="border-left: 5px solid #65B741; padding-left: 10px; display: inline-block; margin-bottom: 15px;">문의 게시판</h2>
			</div>
			<div class="col"></div>
		</div>
	</div>
	<div class="container text-center">
		<div class="row">
			<div class="col"></div>
			<div class="col-8">
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col" width='10%'>글 번호</th>
							<th scope="col" width='40%'>글 제목</th>
							<th scope="col" width='20%'>작성자</th>
							<th scope="col" width='20%'>작성일</th>
							<th scope="col" width='10%'>진행 상태</th>
						</tr>
					</thead>
					<tbody class='table-group-divider'>
						<c:forEach items="${ questionList }" var='question'>
							<tr>
								<td scope="row">${ question.boardNo }</td>
								<td class='title'>${ question.boardTitle }</td>
								<td>${ question.boardWriterName }</td>
								<td>${ question.boardModifyDate }</td>
								<c:if test="${ question.quBoBoardStatus == 'N' }">
									<td style='color: red;'>미답변</td>
								</c:if>
								<c:if test="${ question.quBoBoardStatus == 'Y' }">
									<td style='color: green;'>답변</td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<!-- 페이지네이션 -->
				<div class="container" style='margin-top: 30px;'>
					<div class="row">
						<div class="col-3"></div>
						<div class="col-6">
							<nav aria-label="Standard pagination">
								<ul class="pagination justify-content-center">
									<li class="page-item">
										<c:if test="${ empty condition }">
											<c:url var='goBack' value="${ loc }">
												<c:param name='page' value="${ pi.currentPage -1 }" />
											</c:url>
										</c:if>
										<c:if test="${ !empty condition }">
											<c:url var='goBack' value="${ loc }">
												<c:param name='page' value="${ pi.currentPage -1 }" />
												<c:param name='condition' value="${ condition }" />
												<c:param name='search' value="${ search }" />
											</c:url>
										</c:if>
										<a class="page-link" href="${ goBack }" aria-label="Previous">
											<span aria-hidden="true" style='color: black;'>&laquo;</span>
										</a>
									</li>
									
									<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
										<c:if test="${ empty condition }">
											<c:url var='goNum' value='${ loc }'>
												<c:param name="page" value="${ p }" />
											</c:url>
										</c:if>
										<c:if test="${ !empty condition }">
											<c:url var='goNum' value='${ loc }'>
												<c:param name="page" value="${ p }" />
												<c:param name='condition' value="${ condition }" />
												<c:param name='search' value="${ search }" />
											</c:url>
										</c:if>
										<li class="page-item">
											<a class="page-link" href="${ goNum }" style='color: black;'>${ p }</a>
										</li>
									</c:forEach>
									<li class="page-item">
										<c:if test="${ empty condition }">
											<c:url var='goNext' value='${ loc }'>
												<c:param name="page" value="${ pi.currentPage +1 }" />
											</c:url>
										</c:if>
										<c:if test="${ !empty condition }">
											<c:url var='goNext' value='${ loc }'>
												<c:param name="page" value="${ pi.currentPage +1 }" />
												<c:param name='condition' value="${ condition }" />
												<c:param name='search' value="${ search }" />
											</c:url>
										</c:if>
										<a class="page-link" href="${ goNext }" aria-label="Next">
											<span aria-hidden="true" style='color: black;'>&raquo;</span>
										</a>
									</li>
								</ul>
							</nav>
						</div>
						<div class="col-3 text-end">
							<button id='writeBoard' class="btn" style='background: #60A869; color: white;'>글쓰기</button>
						</div>
					</div>
				</div>
				<!-- 페이지네이션 -->
				
				<div class="container text-center" style='margin: 1%;'>
					<div class="row">
						<div class="col"></div>
						<div class="col-8">
							<select name='searchOption'>
								<option selected>-----</option>
								<option value="title">제목</option>
								<option value="phone">핸드폰 번호</option>
							</select>
							&nbsp;&nbsp; 
							
							<input type='text' name='search' id='search' size='30' placeholder='제목/핸드폰번호로 검색이 가능합니다' />
							&nbsp;&nbsp; 
							<img src="resources/image/search.svg" id='searchIcon'>
						</div>
						<div class="col"></div>
					</div>
				</div>
			</div>
			<div class="col"></div>
		</div>
	</div>

	<div class='margin'></div>
	<!-- 푸터 -->
	<%@ include file='../common/footer.jsp'%>
	<!-- /푸터 -->




	<script>
		// 상세 글 페이지 이동
		const tds = document.querySelectorAll('td');
		for(const td of tds){
			const parent = td.parentElement;
			
			td.addEventListener('click', ()=>{
				const boardNo = parent.children[0].innerText;
				location.href = '${contextPath}/pwdConfirm.bo?bId=' + boardNo + "&page=" + ${pi.currentPage} + "&category=101";
			})
		}
		
		// 글쓰기 페이지 이동
		document.getElementById('writeBoard').addEventListener('click', () =>{
			location.href = '${contextPath}/writeView.bo?category=question';
														//?category=question
		})
		
		// 검색창 검색
		document.getElementById('searchIcon').addEventListener('click', function(){
			const condition = this.parentElement.children[0].value;
			const search = this.parentElement.children[1].value;
			
			location.href = "${contextPath}/searchQuestion.menu?condition=" + condition + "&search=" + search + "&page=" + ${pi.currentPage};
		})
		
		// 검색창 엔터
		document.getElementById('search').addEventListener('keyup', function(e){
			if(e.key == 'Enter'){
				const condition = this.parentElement.children[0].value;
				const search = this.parentElement.children[1].value;
				
				location.href = "${contextPath}/searchQuestion.menu?condition=" + condition + "&search=" + search + "&page=" + ${pi.currentPage};
			}
		})
	</script>
</body>
</html>