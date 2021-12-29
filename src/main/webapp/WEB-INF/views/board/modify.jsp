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
				<h1 class="page-header">Board Modify Page</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">게시글 수정</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<form role="form" action="/board/modify" method="post">
							<div class="form-group">
								<label>BNO</label>
								<input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly">
							</div>
							<div class="form-group">
								<label>TITLE</label>
								<input class="form-control" name="title" value='<c:out value="${board.title}"/>'>
							</div>
							<div class="form-group">
								<label>CONTENT</label>
								<textarea class="form-control" rows="3" name="content">${board.content}</textarea>
							</div>
							<div class="form-group">
								<label>WRITER</label>
								<input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
							</div>
							<div class="form-group">
								<label>REGDATE</label>
								<input class="form-control" name="regDate" value='<fmt:formatDate value="${board.regDate}" pattern="yyyy/MM/dd (E)"/>' readonly="readonly">
							</div>
							<div class="form-group">
								<label>UPDATEDATE</label>
								<input class="form-control" name="updateDate" value='<fmt:formatDate value="${board.updateDate}" pattern="yyyy/MM/dd (E)"/>' readonly="readonly">
							</div>
							<button type="submit" data-oper='modify' class="btn btn-outline btn-primary" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">Modify</button>
							<button type="submit" data-oper='remove' class="btn btn-outline btn-danger" onclick="location.href='/board/list'">Remove</button>
							<button type="submit" data-oper='list' class="btn btn-outline btn-success" onclick="location.href='/board/list'">List</button>
						</form>
						<!-- /.table-responsive -->
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
			var formObj = $("form");
			
			$('button').on("click", function(e) {
				e.preventDefault();
				var operation = $(this).data("oper");
				console.log(operation);
				if (operation === 'remove') {
					formObj.attr("action", "/board/remove");
				} else if (operation === 'list') {
					// move to list
					/* self.location = "/board/list";
					return; */
					formObj.attr("action", "/board/list").attr("method", "get");
					formObj.empty();
				}
				formObj.submit();
			});
		});
	</script>
	
</body>
</html>
