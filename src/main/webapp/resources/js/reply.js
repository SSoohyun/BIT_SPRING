/**
 * 
 */
console.log("Reply Module....");
/*
var replyService = (function() { // 익명 함수
	return {name:"AAA"}; // replyService라는 변수에 name이라는 속성, 'AAA'라는 값을 가진 객체 할당
})();
*/
// 모듈 패턴: 즉시 실행하는 함수 내부에 메소드를 구성해서 객체로 반환
var replyService = (function() {
	function add(reply, callback, error) { // Ajax 처리 후 동작해야하는 함수
		console.log("reply...");
		$.ajax({
			type: 'post',
			url: '/replies/new',
			data: JSON.stringify(reply),
			contentType: "application/json;charset=utf-8",
			success: function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error:function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	} // add
	
	// 게시글 조회할 때마다 댓글 추가 확인
	function getList(param, callback, error) {
	var bno = param.bno;
	var page = param.page || 1;
	$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
		function(data) {
			if(callback) {
				callback(data);
			}
		}).fail(function(xhr, status, err) {
			if(error) {
				error();	
			}
		});		
	} // getList
	
	// 존재하는 댓글의 번호를 이용해서 처리
	function remove(rno, callback, error) {
		$.ajax({
			type: 'delete',
			url: '/replies/' + rno,
			success:function(deleteResult, status, xhr) {
				if(callback) {
					callback(deleteResult);
				}
			},
			error:function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	} // remove
	
	function update(reply, callback, error) {
		$.ajax({
			type: 'put',
			url: '/replies/' + reply.rno,
			data: JSON.stringify(reply),
			contentType: "application/json;charset=utf-8",
			success:function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error:function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	} // update
	
	// 모듈 패턴으로 외부에 노출하는 정보
	return {add:add, // add라는 이름으로 add 함수 할당
			getList:getList,
			remove:remove,
			update:update};
})();

