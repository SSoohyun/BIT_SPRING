<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../includes/header.jsp" %>
<%@include file="../includes/footer.jsp" %>
<!DOCTYPE html>
<html lang="en">
	<script type="text/javascript" src="/resources/js/reply.js"></script>
<head>
<style>
.uploadResult {
	width: 100%;
	background-color: #ddd;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 20px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 400px;
</style>
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
						<i class="fa fa-comments fa-fw"></i> File Attach
					</div>
					<div class="panel-body">
						<!-- 첨부파일 띄우기 -->
						<div class="uploadResult">
							<ul></ul>
						</div>

						<!-- 이미지 크게 보이게 -->
						<div class="bigPictureWrapper">
							<div class="bigPicture"></div>
						</div>
					</div>
					<div class="panel-footer"></div>
				</div>
				
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
					<div class="panel-footer"></div>
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
								<button id="modalCloseBtn" type="button" class="btn btn-outline btn-warning">CLOSE</button>
								<!-- <button id="modalCloseBtn" type="button" class="btn btn-outline btn-warning" data-dismiss="modal">CLOSE</button> -->
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
		// 썸네일 클릭 이벤트
		function showImage(fileCallPath) {
			//alert(fileCallPath);
			$(".bigPictureWrapper").css("display", "flex").show();
			$(".bigPicture")
			.html("<img src='/display?fileName=" + encodeURI(fileCallPath) + "'>")
			.animate({width: '100%', height: '100%'}, 1000);
			
			// 이미지를 다시 클릭하면 사라지도록 처리
			$(".bigPictureWrapper").on("click", function(e) {
				$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
				setTimeout(function() {
					$('.bigPictureWrapper').hide();
				}, 1000);
			}); // bigPictureWrapper click
		}
	
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
						, function(replyCnt, list) {
							console.log("replyCnt: " + replyCnt);
							console.log("list: " + list);
							
							if(page == 0) {
								pageNum = Math.ceil(replyCnt/10.0); // 한 페이지에 10개씩
								showList(pageNum);
								return;
							}
							
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
							showReplyPage(replyCnt); // 댓글 페이지 번호 처리
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
			var modalCloseBtn = $("#modalCloseBtn");
			
			$("#addReplyBtn").on("click", function(e) {
				modal.find("input").val("");
				modalInputReplyDate.closest("div").hide();
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalRegisterBtn.show();
				$(".modal").modal("show");
			});
			
			// 새 댓글 등록
			modalRegisterBtn.on("click", function(e) {
				var reply = {
						reply:modalInputReply.val(),
						replyer:modalInputReplyer.val(),
						bno:bnoValue
				};
				replyService.add(reply, function(result) {
					alert(result); // 댓글 등록이 정상임을 팝업으로 알림
					modal.find("input").val(""); // 댓글 등록이 정상적으로 이뤄지면, 내용을 지움
					modal.modal("hide"); // 모달창 닫음
					
					// 새로운 댓글 추가 -> page 값을 0으로 전송하고 댓글의 전체 숫자를 파악한 후에 페이지 이동
					showList(0); // 새로 등록된 댓글이 보이도록 목록 자체 갱신
				});
			});
			
			// 특정 댓글 클릭 이벤트
			$(".chat").on("click", "li", function(e) {
				var rno = $(this).data("rno");
				console.log(rno);
				
				modalInputReplyDate.closest("div").show(); // 댓글 작성 버튼 클릭하면 날짜 지워지기 때문에 무조건 날짜 보이게 설정
				replyService.get(rno, function(reply) {
					modalInputReply.val(reply.reply);
					modalInputReplyer.val(reply.replyer);
					modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
					modal.data("rno", reply.rno);
					
					modal.find("button[id != 'modalCloseBtn']").hide();
					modalModBtn.show();
					modalRemoveBtn.show();
					$(".modal").modal("show");
				});
			});
			
			// 댓글 수정
			modalModBtn.on("click", function(e) {
				var reply = {rno:modal.data("rno"), reply:modalInputReply.val()};
				replyService.update(reply, function(result) {
					alert(result);
					modal.modal("hide");
					
					showList(pageNum); // 수정 시 댓글이 포함된 페이지로 이동
				});
			});
				
			// 댓글 삭제
			modalRemoveBtn.on("click", function(e) {
				var rno = modal.data("rno");
				replyService.remove(rno, function(result) {
					alert(result);
					modal.modal("hide");
					
					showList(pageNum); // 삭제 시 댓글이 포함된 페이지로 이동
				});
			});
			
			// 모달창 닫기
			modalCloseBtn.on("click", function(e) {
				modal.modal("hide");
			});
			
			// 댓글의 페이지 번호 처리
			var pageNum = 1;
			var replyPageFooter = $(".panel-footer");
			function showReplyPage(replyCnt) {
				console.log("showReplyPage : " + replyCnt);
				
				var endNum = Math.ceil(pageNum/10.0) * 10;
				var startNum = endNum - 9;
				var prev = startNum != 1;
				var next = false;
				if(endNum * 10 >= replyCnt) {
					endNum = Math.ceil(replyCnt/10.0);
				}
				if(endNum * 10 < replyCnt) {
					next = true;
				}
				var str = "<ul class='pagination pull-right'>";
				
				if(prev) {
					str += "<li class='page-item'><a class='page-link' href='" + (startNum - 1)  + "'>Previous</a></li>";
				}
				for(var i = startNum; i <= endNum; i++) {
					var active = pageNum == i ? "active" : "";
					str += "<li class='page-item " + active + "'><a class='page-link' href='"  +i + "'>" + i + "</a></li>";
				}
				if(next) {
					str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>"; 
				}
				str += "</ul></div>";
				console.log(str);
				replyPageFooter.html(str);
	 
			} // showReplyPage
			
			
			// 페이지 번호 클릭 시 새로운 댓글 출력
			replyPageFooter.on("click", "li a", function(e) {
				e.preventDefault();
				console.log("page click");
				var targetPageNum = $(this).attr("href");
				console.log("targetNum : " + targetPageNum);
				pageNum = targetPageNum;
				showList(pageNum);
			});
			
			// BoardController의 getAttachList로 bno 보내서 arr(첨부파일 리스트) 받아서 출력 
			var bno = '<c:out value="${board.bno}"/>';
			$.getJSON("/board/getAttachList", {bno:bnoValue}, function(arr) { // url, data, success
				console.log(arr);
				var str = "";
				$(arr).each(function(i, obj) {
					if(!obj.fileType) { // 이미지가 아닌 경우
						
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
						str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>";
						str += "<img src='/resources/images/attach.png'>";
						str += "</div></li>";
					} else {
						
						// 썸네일 나오게 처리
						var fileCallPath = encodeURIComponent(obj.uploadPath +  "/s_" + obj.uuid + "_" + obj.fileName);
						var originPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
						console.log("originPath1 : " + originPath);
						originPath = originPath.replace(new RegExp(/\\/g), "/"); // \를 /로 통일
						console.log("originPath2 : " + originPath);
						str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>";
						str += "<a href=\"javascript:showImage(\'" + originPath + "\')\"><img src='/display?fileName=" + fileCallPath + "'></a>";
						str += "</div></li>";
					}
				});
				$(".uploadResult ul").html(str);
			}); // getJSON
		});
	</script>

</body>
</html>
