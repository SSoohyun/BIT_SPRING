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
				<h1 class="page-header">Board Register</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">게시글 등록</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<form role="form" action="/board/register" method="post">
							<div class="form-group">
								<label>TITLE</label>
								<input class="form-control" name="title" placeholder="제목을 입력하세요">
							</div>
							<div class="form-group">
								<label>CONTENT</label>
								<textarea class="form-control" rows="3" name="content" placeholder="내용을 입력하세요"></textarea>
							</div>
							<div class="form-group">
								<label>WRITER</label>
								<input class="form-control" name="writer" placeholder="작성자를 입력하세요">
							</div>
							<button type="submit" class="btn btn-outline btn-primary">Submit</button>
							<button type="reset" class="btn btn-outline btn-danger">Reset</button>
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
</body>
</html>
