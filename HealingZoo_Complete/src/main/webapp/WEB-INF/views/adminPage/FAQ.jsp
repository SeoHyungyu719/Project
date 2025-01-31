<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<meta charset="UTF-8">
<style>
   .search {
     position: relative;
     width: 300px;
     display: inline-block;
     float: right;
     margin-bottom: 30px;
   }
   
   input {
     width: 100%;
     border: 1px solid #bbb;
     border-radius: 8px;
     padding: 10px 12px;
     font-size: 14px;
   }
   
   #search {
     position : absolute;
     width: 17px;
     top: 14px;
     right: 12px;
     margin: 0;
   }
   
   .form-check-input{
      transform : scale(0.5);
      accent-color: #65B741;
   }
   
   #delete_button {
      background-color: #DD5353;
      width: 80px;
      border: none;
   }

   #insert_button {
      background-color: #65B741;
      width: 80px;
      border: none;
      margin-right: 5px;
   }
  
   
   .pagination-container {
     display: flex;
     justify-content: center;
   }
   
   .number-button-wrapper {
      padding: 10px;
   }
   tr{text-align:center;}
   .content{
		max-width: 200px; /* 원하는 최대 길이 설정 */
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
	}
	 .title{
		max-width: 100px; /* 원하는 최대 길이 설정 */
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
	}
   
</style>
<title>자주 묻는 Q&A 관리</title>
</head>
<body>
	<%@ include file='../common/logoBar.jsp' %>
   <%@ include file='../common/mainCategoryBar.jsp' %>
   <%@ include file='../common/adminSidebar.jsp'%>
   
   <!-- /헤더 -->
   <div class='margin' style="margin-top:100px"></div>
   <div class="container" style="width: 900px; margin-top: 100px;">
		<h2 style="border-left: 5px solid #65B741; padding-left: 10px; display: inline-block; margin-bottom: 30px;">자주 묻는 Q&A</h2>
		 <form action="${contextPath}/deleteFAQ.admin" id="deleteForm">
			<table class="table table-hover">
			  <thead>
			    <tr>
			      <th scope="col" width='8%'><input class="form-check-input" type="checkbox" id="selectAll"></th>
			      <th scope="col" width='8%'>번호</th>
			      <th scope="col" width='25%'>질문</th>
			      <th scope="col" width='44%'>답변</th>
			      <th scope="col" width='15%'>작성 일자</th>
			    </tr>
			  </thead>
			  <tbody class='table-group-divider'>
			  	<c:forEach items="${ FAQList }" var='FAQ'>
				  	<tr>
				  	  <th><input class="form-check-input" type="checkbox" value="${ FAQ.boardNo }" id="flexCheckDefault" name='FAQNo' ></th>
				      <td>${ FAQ.boardNo }</td>
				      <td class='title'>${ FAQ.boardTitle }</td>
				      <td class='content'>${ FAQ.boardContent }</td>
				      <td>${ FAQ.boardModifyDate }</td>
				    </tr>
			    </c:forEach>
			  </tbody>
			</table>
			<div class="container text-center">
			  <div class="row">
			    <div class="col-3"></div>
			    <div class="col-6">
					<nav aria-label="Standard pagination">
						<ul class="pagination justify-content-center">
							<li class="page-item">
								<c:url var='goBack' value="${ loc }">
									<c:param name='page' value="${ pi.currentPage -1 }" />
								</c:url>
								<a class="page-link" href="${ goBack }" aria-label="Previous">
									<span aria-hidden="true" style='color: black;'>&laquo;</span>
								</a>
							</li>
							
							<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
								<c:url var='goNum' value='${ loc }'>
									<c:param name="page" value="${ p }" />
								</c:url>
								<li class="page-item">
									<a class="page-link" href="${ goNum }" style='color: black;'>${ p }</a>
								</li>
							</c:forEach>
							<li class="page-item">
								<c:url var='goNext' value='${ loc }'>
									<c:param name="page" value="${ pi.currentPage +1 }" />
								</c:url>
								<a class="page-link" href="${ goNext }" aria-label="Next">
									<span aria-hidden="true" style='color: black;'>&raquo;</span>
								</a>
							</li>
						</ul>
					</nav>
				</div>
			    <div class="col-3 text-end">
			    	<button class="btn btn-primary" type="button" id="insert_button">추가</button> &nbsp;&nbsp;
					<!-- 삭제 버튼 type을 submit으로 변경 -->
					<button class="btn btn-primary" id="delete_button">삭제</button>
			    </div>
			  </div>
			</div>
		</form>
	</div>  
	                 
	              
       <!-- 우측공간  -->
     <div class="col"></div>
   <div class='margin'></div>
   <!-- 공간 -->
      <div style="margin-bottom: 300px;"></div>
      
      
   <!-- 푸터 -->
   <%@ include file='../common/footer.jsp' %>
   <!-- /푸터 -->
   
   
   <script>
		 //상세 게시글 보기
		const tds = document.querySelectorAll('td');
		for(const td of tds){
			const parent = td.parentElement;
			
			td.addEventListener('click', ()=>{
				const FAQNo = parent.children[1].innerText;
				location.href = '${contextPath}/FAQDetail.admin?FAQNo=' + FAQNo + "&page=" + ${pi.currentPage};
			})
		}
	
		//삭제 처리
		document.getElementById('delete_button').addEventListener('click', function(e) {
		    e.preventDefault(); // 기본 이벤트 방지
		
		    const checkboxes = document.querySelectorAll('input[name="FAQNo"]:checked');
		    
		    if (checkboxes.length === 0) {
		        alert('삭제할 항목을 선택해주세요.');
		        return;
		    }
		
		    if (confirm('선택한 ' + checkboxes.length + '개의 항목을 삭제하시겠습니까?')) {
		        document.getElementById('deleteForm').submit(); // 폼 제출
		    }
		});
	
	
		// 추가 클릭시
		document.getElementById('insert_button').addEventListener('click', () => {
		    location.href = '${contextPath}/insertFAQView.admin?page=' + ${pi.currentPage};
		});
		
		// 전체 선택
		document.getElementById('selectAll').addEventListener('change', function() {
		    const checkboxes = document.querySelectorAll('input[name="FAQNo"]');
		    checkboxes.forEach(checkbox => {
		        checkbox.checked = this.checked;
		    });
		});
   
   
   </script>
</body>
</html>