<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="exUploadPost" method="post" enctype="multipart/form-data"> <!-- 파일 업로드 시 enctype 필수!! -->
		<input type="file" name="files"><p>
		<input type="file" name="files"><p>
		<input type="file" name="files"><p>
		<input type="submit" value="Submit">
	</form>
</body>
</html>