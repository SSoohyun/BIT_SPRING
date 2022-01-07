<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<%@include file="../includes/footer.jsp"%>
<!DOCTYPE html>
<html lang="en">

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
</style>
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
								<label>TITLE</label> <input class="form-control" name="title"
									placeholder="제목을 입력하세요">
							</div>
							<div class="form-group">
								<label>CONTENT</label>
								<textarea class="form-control" rows="3" name="content"
									placeholder="내용을 입력하세요"></textarea>
							</div>
							<div class="form-group">
								<label>WRITER</label> <input class="form-control" name="writer"
									placeholder="작성자를 입력하세요">
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

		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">File Attach</div>
					<div class="panel-body">
						<div class="form-group uploadDiv">
							<input type="file" name="uploadFile" multiple>
						</div>
						<div class="uploadResult">
							<ul></ul>
						</div>
					</div>
				</div>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->

	</div>
	<!-- /#page-wrapper -->


	<script>
		$(document).ready(function(e) {
			var formObj = $("form[role='form']");
			$("button[type='submit']").on("click", function(e) {
				e.preventDefault(); // sumbit 동작 막기
				console.log("submit clicked");
				
				var str = "";
				$(".uploadResult ul li").each(function(i, obj) {
					console.log("aaaa");
					var jobj = $(obj);
					console.dir(jobj);
					str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
				});
				formObj.append(str).submit();
			}); // submit button event
			
			// 정규식을 이용해서 파일 확장자 체크
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880;
			function checkExtension(fileName, fileSize) {
				if(fileSize >= maxSize) {
					alert("파일 크기 초과");
					return false;
				}
				if(regex.test(fileName)) {
					alert("해당 종류의 파일은 업로드 할 수 없음");
					return false;
				}
				return true;
			}
			
			// 업로드 전에 <input type="file"> 객체가 포함된 <div> 복사
			var cloneObj = $(".uploadDiv").clone();
			
			// <input type="file"> 내용이 변경되는 것을 감지해서 무조건 업로드 처리
			//$(document).on('change', "input[type='file']", function(e) {
			$("input[type='file']").change(function(e) {
				// 파일 업로드
				// ajax 이용하는 경우에는 FormData 객체 이용 (form 태그와 같은 역할)
				var formData = new FormData();
				var inputFile = $("input[name='uploadFile']");
				var files = inputFile[0].files;
				console.log(files);
				
				// add filedata to formdata
				for(var i = 0; i < files.length; i++) {
					if(!checkExtension(files[i].name, files[i].size)) { // 파일 확장자 체크
						return false;
					}
					formData.append("uploadFile", files[i]);
				}
				console.log("files.length : " + files.length);
				
				$.ajax({
					url : '/uploadAjaxAction',
					processData : false, // 전달할 데이터를 query string을 만들지 말 것
					contentType : false,
					data : formData, // 전달할 데이터
					type : 'POST',
					dataType: 'json', // 데이터 타입: json
					success : function (result) {
						alert('Uploaded');
						console.log(result);
						showUploadedFile(result); // json 형태의 업로드 결과를 인자로 줌				
						//$(".uploadDiv").html(cloneObj.html()); // 업로드 성공 후 초기 상태로 복원
					}
				}); // $.ajax
			});
			
			var uploadResult = $(".uploadResult ul");
			function showUploadedFile(uploadResultArr) {
				if(!uploadResultArr || uploadResultArr.length == 0) {
					return;
				}
				var str = "";
				$(uploadResultArr).each(function(i, obj) {
					if(!obj.image) { // 이미지가 아닌 경우
						
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
						str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
						str += "<span>" + obj.fileName + "</span>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/resources/images/attach.png'>";
						str += "</div></li>";
					} else {
						
						// 썸네일 나오게 처리
						var fileCallPath = encodeURIComponent(obj.uploadPath +  "/s_" + obj.uuid + "_" + obj.fileName);
						var originPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
						console.log("originPath1 : " + originPath);
						originPath = originPath.replace(new RegExp(/\\/g), "/"); // \를 /로 통일
						console.log("originPath2 : " + originPath);
						str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
						str += "<span>" + obj.fileName + "</span>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/display?fileName=" + fileCallPath + "'>";
						str += "</div></li>";
					}
				});
				uploadResult.append(str); // 요소 추가 (<li> 추가)
			} // showUploadedFile
			
			// 버튼 클릭시 삭제
			$(".uploadResult").on("click", "button", function(e) {
				alert("delete file");
				
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				var targetLi = $(this).closest("li");
				
				$.ajax({
					url: '/deleteFile',
					data: {fileName: targetFile, type: type},
					dataType: 'text',
					type: 'post',
					success: function(result) {
						alert(result);
						targetLi.remove(); // li 삭제
					}
				}); // $.ajax
			}); // uploadResult
	
			
		});
	</script>
</body>
</html>
