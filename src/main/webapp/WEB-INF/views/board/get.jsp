<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../includes/header.jsp" %>
<%@include file="../includes/footer.jsp" %>
<!DOCTYPE html>
<html lang="en">
	<script src="/resources/js/reply.js"></script>
<head>
</head>
<body>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Board Read</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">게시글 조회</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<div class="form-group">
							<label>BNO</label>
							<input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly">
						</div>
						<div class="form-group">
							<label>TITLE</label>
							<input class="form-control" name="title" value='<c:out value="${board.title}"/>' readonly="readonly">
						</div>
						<div class="form-group">
							<label>CONTENT</label>
							<textarea class="form-control" rows="3" name="content" readonly="readonly">${board.content}</textarea>
						</div>
						<div class="form-group">
							<label>WRITER</label>
							<input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
						</div>
						<button data-oper='modify' class="btn btn-outline btn-primary">Modify</button>
						<button data-oper='list' class="btn btn-outline btn-success">List</button>
						<form id="operForm" action="/board/modify" method="get">
							<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
							<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
							<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
							<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
							<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
						</form>
						<!-- /.table-responsive -->
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->

				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-comments fa-fw"></i> Reply
						<button id="addReplyBtn" type="button" class="btn btn-outline btn-success btn-xs pull-right">새 댓글</button>
					</div>
					<div class="panel-body">
						<ul class="chat">
							<!-- 
								<li> 태그는 하나의 댓글
								수정이나 삭제 시 댓글 번호(rno)가 필요하므로 'data-rno' 속성 이용
							 -->
							<li class="left clearfix" data-rno="12">
								<div>
									<div class="header">
										<strong class="primary-font">user00</strong> 
										<small class="pull-right text-muted">2021-05-18 13:13</small>
									</div>
									<p>Good Job!</p>
								</div>
							</li>
						</ul>
					</div>
				</div>
				<!-- /.panel -->

				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModallabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
							</div>
							<div class="modal-body">
								<div class="form-group">
									<label>Reply</label>
									<input class="form-control" name="reply" value="New Reply!!">
								</div>
								<!-- replyer, replyDate를 위한 div 배치 -->
								<div class="form-group">
									<label>Replyer</label>
									<input class="form-control" name="replyer" value="New Reply!!">
								</div>
								<div class="form-group">
									<label>ReplyDate</label>
									<input class="form-control" name="replyDate" value="New Reply!!">
								</div>
							</div>
							<div class="modal-footer">
								<button id="modalModBtn" type="button" class="btn btn-outline btn-info">Modify</button>
								<button id="modalRemoveBtn" type="button" class="btn btn-outline btn-danger">REMOVE</button>
								<button id="modalRegisterBtn" type="button" class="btn btn-outline btn-primary">REGISTER</button>
								<button id="modalCloseBtn" type="button" class="btn btn-outline btn-dark">CLOSE</button>
							</div>
						</div>
					</div>
				</div>
				<!-- /.modal fade -->

			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /#page-wrapper -->




	<script type="text/javascript">
		$(document).ready(function() {
			var operForm = $("#operForm");
			$('button[data-oper="modify"]').on("click", function(e) {
				operForm.attr("action", "/board/modify").submit();
			});

			$('button[data-oper="list"]').on("click", function(e) {
				operForm.find("#bno").remove();
				operForm.attr("action", "/board/list");
				operForm.submit();
			});
			
			// reply module
			console.log(replyService);
			var bnoValue = '<c:out value="${board.bno}"/>'; // bno 가져옴
			
			/* 
			// 조회 화면에서 호출
			replyService.add(
				{reply : "JS TEST", replyer : "js tester", bno : bnoValue} // 댓글 데이터
				, function(result) {
					alert("RESULT : " + result);
				}
			)
			
			// 게시글 조회할 때마다 댓글 추가 확인
			replyService.getList(
				{bno: bnoValue, page:1}
				, function(list) {
					for (var i = 0, len = list.length || 0; i< len; i++) {
						console.log(list[i]);
					}
				});
			
			// 댓글 삭제
			replyService.remove(3
				, function(count) {
					console.log(count);
					if(count === "success") {
						alert("REMOVED");
					}
				}, function(err) {
					alert('error occurred...');
				});
			
			// 댓글 수정
			replyService.update({
				rno: 4,
				bno: bnoValue,
				reply: "modified reply..."
			}, function(result) {
				alert('수정 완료');
			});
			
			// 특정 댓글 조회
			replyService.get(4, function(data) {
				console.log(data);
			});
			*/
			
			// 댓글 이벤트 처리
			var replyUL = $(".chat");
			showList(1);
			
			function showList(page) {
				replyService.getList(
						{bno:bnoValue, page:page||1}
						, function(list) {
							var str = "";
							if(list == null || list.length == 0) {
								replyUL.html("");
								return;
							}
							//console.log('here : %s',replyService.displayTime( new Date()));
							for(var i = 0, len = list.length || 0; i < len; i++) {
								str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
								str += "<div><div class='header'><strong class='primary-font'>" + list[i].replyer + "</strong>";
								str += "<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small><div>";
								str += "<p>" + list[i].reply + "</p><div></li>";
							}
							replyUL.html(str);
						}); // function call
			} // showList
			
			// 댓글 쓰기 모달창 띄우기
			var modal = $(".modal");
			var modalInputReply = modal.find("input[name='reply']");
			var modalInputReplyer = modal.find("input[name='replyer']");
			var modalInputReplyDate = modal.find("input[name='replyDate']");
			
			var modalModBtn = $("#modalModBtn");
			var modalRemoveBtn = $("#modalRemoveBtn");
			var modalRegisterBtn = $("#modalRegisterBtn");
			
			$("#addReplyBtn").on("click", function(e) {
				modal.find("input").val("");
				modalInputReplyDate.closest("div").hide();
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalRegisterBtn.show();
				$(".modal").modal("show");
			});
			
			
		});
	</script>

</body>
</html>
