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
				<h1 class="page-header">Board</h1>
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
						<button data-oper="modify" class="btn btn-success" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">Modify</button>
						<button data-oper="list" class="btn btn-primary" onclick="location.href='/board/list'">List</button>
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
</body>
</html>
