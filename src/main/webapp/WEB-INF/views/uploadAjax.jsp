<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style type="text/css">
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
}
</style>

</head>
<body>
	<h1>Upload w/i Ajax</h1>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	<div class="uploadResult">
		<ul></ul>
	</div>
	<button id="uploadBtn">Upload</button>
	
	<div class="bigPictureWrapper">
		<div class="bigPicture"></div>
	</div>
	
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
			// 업로드 전에 <input type="file"> 객체가 포함된 <div> 복사
			var cloneObj = $(".uploadDiv").clone(); 
			
			$("#uploadBtn").on("click", function(e) {
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
						$(".uploadDiv").html(cloneObj.html()); // 업로드 성공 후 초기 상태로 복원
					}
				}); // $.ajax
			});
			
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
			
			// 업로드된 결과는 JSON 형태로 수신했으므로
			// 화면에 썸네일을 보여주는 등의 형태로 Ajax 처리 결과 출력
			var uploadResult = $(".uploadResult ul");
			function showUploadedFile(uploadResultArr) {
				var str = "";
				$(uploadResultArr).each(function(i, obj) {
					if(!obj.image) { // 이미지가 아닌 경우
						// 클릭 시 다운로드 가능하게 처리
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
						str += "<li><div><a href='/download?fileName=" + fileCallPath + "'><img src='/resources/images/attach.png'>" + obj.fileName + "</a>"
								+ "<span data-file=\'" + fileCallPath + "' data-type='file'>x</span></div></li>";
					} else {
						// str += "<li>" + obj.fileName + "</li>";
						
						// 썸네일 나오게 처리
						var fileCallPath = encodeURIComponent(obj.uploadPath +  "/s_" + obj.uuid + "_" + obj.fileName);
						var originPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
						console.log("originPath1 : " + originPath);
						originPath = originPath.replace(new RegExp(/\\/g), "/"); // \를 /로 통일
						console.log("originPath2 : " + originPath);
						str += "<li><a href=\"javascript:showImage(\'" + originPath + "\')\"><img src='/display?fileName=" + fileCallPath + "'></a>"
								+ "<span data-file=\'" + fileCallPath + "' data-type='image'>x</span></li>";
					}
				});
				uploadResult.append(str); // 요소 추가 (<li> 추가)
			} // showUploadedFile
			
			$(".uploadResult").on("click", "span", function(e) {
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				console.log(targetFile);
				$.ajax({
					url: '/deleteFile', // controller로 넘겨서 처리
					data: {fileName: targetFile, type: type},
					dataType: 'text',
					type: 'post',
					success: function(result) {
						alert(result);
					}
				}); // $.ajax 
			});
			
		});
	</script>
</body>
</html>