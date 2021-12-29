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
			var operForm = $("#operForm");
			$('button[data-oper="modify"]').on("click", function(e) {
				operForm.attr("action", "/board/modify").submit();
			});

			$('button[data-oper="list"]').on("click", function(e) {
				operForm.find("#bno").remove();
				operForm.attr("action", "/board/list");
				operForm.submit();
			});
		});
	</script>

</body>
</html>
