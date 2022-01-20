<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<title>Get</title>
<style>
.uploadResult {
   width: 100%;
   background-color: gray;
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
   align-content: center;
   text-align: center;
}

.uploadResult ul li img {
   width: 100px;
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
   width: 600px;
}
</style>
<%@include file="../includes/header.jsp"%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<!-- 푸터에 있음 -->
<div id="page-wrapper">
   <div class="row">
      <div class="col-lg-12">
         <h1 class="page-header">BOARD GET</h1>
      </div>
      <!-- /.col-lg-12 -->
   </div>
   <!-- /.row -->
   <div class="row">
      <div class="col-lg-12">
         <div class="panel panel-default">
            <div class="panel-heading">Board Get (게시글 조회)</div>
            <!-- /.panel-heading -->
            <div class="panel-body">

               <div class="form-group">
                  <label>Bno</label><input class="form-control" name="bno"
                     value='<c:out value="${board.bno}"/>' readonly="readonly">
               </div>
               <div class="form-group">
                  <label>Title</label><input class="form-control" name="title"
                     value='<c:out value="${board.title}"/>' readonly="readonly">
                  <%-- <label>Title</label><input class="form-control" name="title" value="${board.title}"/> --%>
               </div>
               <div class="form-group">
                  <label>Content</label>
                  <textarea class="form-control" name="content" rows="3"
                     readonly="readonly">${board.content}</textarea>
               </div>
               <div class="form-group">
                  <label>Writer</label><input class="form-control" name="writer"
                     value='<c:out value="${board.writer}"/>' readonly="readonly">
               </div>
               
                  <div class='uploadResult'>
                     <ul>
                     </ul>
                  </div>
               

               <%-- <button data-oper="modify" class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">Modify</button>
               <button data-oper="list" class="btn btn-default" onclick="location.href='/board/list'">List</button> --%>


               <!-- <button data-oper='modify' class="btn btn-outline btn-primary">Modify</button>
                  <button data-oper='list' class="btn btn-outline btn-success">List</button> -->
               <form id='operForm' action="/board/modify" method="get">
                  <input type="hidden" id="bno" name="bno" value="${board.bno}">
                  <input type="hidden" name="pageNum" value="${cri.pageNum}">
                  <input type="hidden" name="amount" value="${cri.amount}">
                  <input type="hidden" name="type" value="${cri.type}"> <input
                     type="hidden" name="keyword" value="${cri.keyword}">
               
                  <button data-oper="modify"
                     class="btn btn-outline btn-primary btn-sm">Modify</button>
                  <button data-oper="list" class="btn btn-outline btn-info btn-sm">List</button>
               </form>
            <!-- /.panel-body -->
         </div>

         <!-- /.panel -->
      </div>
               <!--첨부파일 -->
               <div class='bigPictureWrapper'>
                  <div class='bigPicture'></div>
               </div>
            </div>

      <!-- /.col-lg-12 -->
      <div class="col-lg-12">
         <div class="panel panel-default">
            <div class="panel-heading">
               <i class="fa fa-comments fa-fw"></i>Reply
               <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New
                  Reply</button>
            </div>
            <!-- /.panel-heading -->

            <div class="panel-body">
               <ul class="chat">
                  <!-- start reply -->
                  <li class="left clearfix" data-rno='12'>
                     <div>
                        <div class="header">
                           <strong class="primary-font">user00</strong> <small
                              class="pull-right text-muted">2021-05-18 13:13</small>
                        </div>
                        <p>Good job!</p>
                     </div>
                  </li>
                  <!--  end reply -->
               </ul>
               <!--  ./end ul -->
            </div>
            <!-- /.row -->
            <div class="panel-footer">
               <div></div>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
               aria-labelledby="myModalLabel" aria-hidden="true">
               <div class="modal-dialog">
                  <div class="modal-content">
                     <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"
                           aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
                     </div>
                     <div class="modal-body">
                        <div class="form-group">
                           <label>Reply</label> <input class="form-control" name="reply"
                              value="New Reply!!!">
                        </div>
                        <div class="form-group">
                           <label>Replyer</label> <input class="form-control"
                              name="replyer" value="replyer">
                        </div>
                        <div class="form-group">
                           <label>Reply date</label> <input class="form-control"
                              name="replyDate" value="">
                        </div>
                     </div>
                     <div class="modal-footer">
                        <button type="button" id="modalModBtn" class="btn btn-warning">Modify</button>
                        <button type="button" id="modalRemoveBtn" class="btn btn-danger">Remove</button>
                        <button type="button" id="modalRegisterBtn"
                           class="btn btn-primary">Register</button>
                        <button type="button" id="modalCloseBtn" class="btn btn-default"
                           data-dismiss="modal">Close</button>
                     </div>
                  </div>
                  <!-- /.modal-content -->
               </div>
               <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
            <!-- /#page-wrapper -->

            <script type="text/javascript" src="/resources/js/reply.js"></script>
            <script type="text/javascript">
            
$(document).ready(function() {//즉시 실행 함수
   var operForm = $("#operForm");
   $('button[data-oper="modify"]').on(
         "click",function(e) {
            operForm.attr("action","/board/modify").submit();
         });
   $('button[data-oper="list"]').on(
         "click",function(e) {
            operForm.find("#bno").remove();
            operForm.attr("action","/board/list");
            operForm.submit();
         });

   console.log("댓글 replyService : "+ replyService);
   var bnoValue = '<c:out value="${board.bno}"/>';
   //가장 먼저 해당 게시물의 댓글을 가져오는 부분(자동)
   
   $.getJSON("/board/getAttachList", {bno:bnoValue}, function(arr) { // url, data, success
            console.log(arr);
            var str = "";
            $(arr).each(function(i, obj) {
               if(!obj.fileType) { // 이미지가 아닌 경우
                  
                  var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
                  str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
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
                  str += "<a href=\"javascript:showImage(\'" + originPath + "\')\"><img src='/display?fileName=" + fileCallPath + "'></a>";
                  str += "</div></li>";
               }
            });
            $(".uploadResult ul").html(str);
         }); // getJSON
    $(".uploadResult").on("click","li", function(e){
         
          console.log("view image");
          
          var liObj = $(this);
          
          var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
          
          if(liObj.data("type")){
            showImage(path.replace(new RegExp(/\\/g),"/"));
          }else {
            //download 
            self.location ="/download?fileName="+path
          }
          
          
        });
        
          //이미지 크게 보여주기
        function showImage(fileCallPath){
          //alert(fileCallPath);
          
          $(".bigPictureWrapper").css("display","flex").show();
          
          $(".bigPicture")
          .html("<img src='/display?fileName="+fileCallPath+"' >")
          .animate({width:'100%', height: '100%'}, 1000);
          
        }

        $(".bigPictureWrapper").on("click", function(e){
          $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
          setTimeout(function(){
            $('.bigPictureWrapper').hide();
          }, 1000);
        });
   //댓글 등록 테스트(replyService)
   /*replyService.add(
         {reply: "JS Test", replyer:"tester", bno:bnoValue} //댓글 데이터
         ,function(result) {
            alert("RESULT : " + result);
         }
   ); */

   //게시글 조회할 때마다 댓글 추가 확인
   /*replyService.getList({bno:bnoValue, page:1}, function(list) {
      for(var i=0, len=list.length || 0; i<len; i++) {
         console.log(list[i]);
      }
   }); */

   //댓글 삭제 테스트(replyService)
   /* replyService.remove(3, function(count) {
      console.log(count);
      if(count==="success") {
         alert("REMOVED");
      }
   }, function(err) {
      alert('ERROR....');
   }); */

   //댓글 수정 테스트(replyService)
   /*replyService.update({
      rno:11,
      bno: bnoValue,
      reply: "js Modified Reply...."
   }, function(result) {
      alert("수정 완료");
   }); */

   //특정 댓글 조회 테스트(replyService)
   /* replyService.get(11, function(data) {
    console.log("aaaaaa");
   console.log(data);
   });
    */
 
    //댓글의 페이지 번호 처리
   var pageNum = 1;
   var replyPageFooter = $(".panel-footer");
   function showReplyPage(replyCnt) {
      var endNum = Math.ceil(pageNum / 5.0) * 10;
      var startNum = endNum - 9;
      
      var prev = startNum != 1;
      var next = false;
      
      if(endNum * 5 >= replyCnt) {
         endNum = Math.ceil(replyCnt/5.0);
      }
      
      if(endNum * 5 < replyCnt) {
         next = true;
      }
      
      var str = "<ul class='pagination pull-right'>";
      if(prev) {
         str += "<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
      }
      
      for(var i=startNum ; i<=endNum; i++){
         var active = pageNum == i? "active":"";
         str+="<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
      }
      
      if(next) {
         str+= "<li class='page-item'><a class='page-link' href='"+(endNum+1) + "'>Next</a></li>";
      }

      str += "</ul></div>";
      console.log(str);
      
      replyPageFooter.html(str);
   }
   replyPageFooter.on("click", "li a", function(e) {
      e.preventDefault();
      console.log("page click");
      var targetPageNum = $(this).attr("href");
      console.log("targetPageNum : " + targetPageNum);
      pageNum = targetPageNum;
      showList(pageNum);
   });
   
   var replyUL = $(".chat");
   showList(1);

   function showList(page){ //해당 게시글의 댓글을 가져온 후 <li>태그를 만들어서 화면에 출력
      console.log("show list " + page);
      replyService.getList( { bno : bnoValue, page : page || 1}, function(replyCnt,list) {
         
         console.log("replyCnt : " + replyCnt);
         console.log("list : " + list);
         console.log(list);
         
         if(page == 0) {
            pageNum = Math.ceil(replyCnt/5.0); //한 페이지에 5개씩
            showList(pageNum);
            return;
         }
         var str = "";
         if (list == null || list.length == 0) {
            replyUL.html("");
            return;
         }
         for (var i = 0, len = list.length || 0; i < len; i++) {
            str += "<li class='left cleafix' data-rno='"+list[i].rno+"'>";
            str += "    <div><div class='header'><strong class='primary-font'>" + list[i].replyer + "</strong>";
            str += "        <small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>";
            str += "            <p>" + list[i].reply + "</p></div></li>";
         }
         replyUL.html(str);
         showReplyPage(replyCnt);
      
      });//function call
   }//showList
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
      modal.find("button[id!='modalCloseBtn']").hide();
      
      modalRegisterBtn.show();
      $(".modal").modal("show");
   });
   modalRegisterBtn.on("click", function(e) {
      var reply ={
            reply: modalInputReply.val(),
            replyer: modalInputReplyer.val(),
            bno: bnoValue
      };
      replyService.add(reply, function (result){
         alert(result); //댓글 등록이 정상임을 팝업으로 알림
         modal.find("input").val(""); //댓글 등록이 정상적으로 이뤄지면, 내용을 지움
         modal.modal("hide"); //모달창 닫음
         
         showList(0); //새로운 댓글을 추가하면 page값을 0으로 전송하고, 댓글의 전체 숫자를 파악한 후에 페이지 이동
         //showList(1);
      });
   });
    $(".chat").on("click", "li", function(e){
         var rno= $(this).data("rno");
         modalInputReplyDate.closest("div").show();
         replyService.get(rno, function(reply){
            console.log("댓글6. reply.js에서 replyVO를 reply로 받아옴")
             console.log("rno"+reply.rno+" 댓글 클릭 >> " );
            modalInputReply.val(reply.reply);
            modalInputReplyer.val(reply.replyer);
            modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
            modal.data("rno", reply.rno);
            
            modal.find("button[id != 'modalCloseBtn']").hide();
            modalModBtn.show();
            modalRemoveBtn.show();
            
            $(".modal").modal("show");
            
         });
     }) ;// 'chat'을 이용해 이벤트를 걸고 실제 이벤트 대상은 <li>태그가 되도록
   // 댓글 수정
   modalModBtn.on("click", function(e){
      var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
      replyService.update(reply, function(result){
         alert(result);
         modal.modal("hide");
         showList(pageNum);
      });
   });
      
   // 댓글 삭제
   modalRemoveBtn.on("click", function(result){
      var rno = modal.data("rno");
      replyService.remove(rno, function(result){
         alert(result);
         modal.modal("hide");
         showList(pageNum);
      });
   });
   

});
</script>
<%@include file="../includes/footer.jsp"%>
            </body>
</html>