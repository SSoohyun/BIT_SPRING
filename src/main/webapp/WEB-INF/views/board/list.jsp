<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../includes/header.jsp" %>
<%@include file="../includes/footer.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
</head>
<body>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Board List Page</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">게시글 목록
						<button id="regBtn" type="button" class="btn btn-outline btn-success btn-xs pull-right">글쓰기</button>
					</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<table width="100%"
							class="table table-striped table-bordered table-hover"
							id="dataTables-example">
							<thead>
								<tr>
									<th># 번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>수정일</th>
								</tr>
							</thead>
							<tbody>
								<!-- 목록 출력 -->
 								<c:forEach var="item" items="${list}">
 									<tr>
 										<td>${item.bno}</td>
 										<td><a href='/board/get?bno=<c:out value="${item.bno}"/>'>${item.title}</a></td>
 										<td>${item.writer}</td>
 										<td><fmt:formatDate value="${item.regDate}" pattern="yyyy/MM/dd (E)"/></td>
 										<td><fmt:formatDate value="${item.updateDate}" pattern="yyyy/MM/dd (E)"/></td>
 									</tr>
 								</c:forEach>
							</tbody>
						</table>
						<!-- /.table-responsive -->
						<!-- /.modal fade -->
						<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModallabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
										<h4 class="modal-title" id="myModalLabel">Modal title</h4>
									</div>
									<div class="modal-body">처리가 완료되었습니다.</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-outline btn-info" data-dismiss="modal">Close</button>
										<button type="button" class="btn btn-outline btn-primary">Save Changes</button>
									</div>
								</div>
							</div>
						</div>
						<!-- /.modal fade -->
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /#page-wrapper -->
	
	
	
	
	<script type="text/javascript">
		$(document).ready(function() {
			var result = '<c:out value="${result}"/>';
			
			// 모달 보여주기 추가
			checkModal(result);
			/* history.replaceState({}, null, null); // 현재의 history entry 변경 함수 */
			function checkModal(result) {
				if (result === '' /* || history.state */) {
					return;
				}
				if (parseInt(result) > 0) {
					$(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
				}
				$("#myModal").modal("show");
			}
		});
		
		$("#regBtn").on("click", function() {
			self.location = "/board/register";
		}); // 버튼 클릭 시 register로 이동
	</script>
</body>
</html>
