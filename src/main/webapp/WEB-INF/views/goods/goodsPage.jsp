<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("input:radio[name='gcategory']:radio[value='${gdto.gcategory}']").prop('checked', true); 
		
		$("#image").change(function() {//gimage 변경
			var form = new FormData();
			form.append("image",$("#image")[0].files[0]);
			$.ajax({
				url:"imageName",
				type: "post",
				data: form, 
				contentType : false,
				processData : false,
				success: function (data,status,xhr) {
					$("#gimage").val(data);
					$("#fakeImage").val(data);
				},
				error: function(xhr,status,error) {
					console.log(error);
				}
			});//end ajax
		});
		
		 $("#vADD").click(function() {//제품종류 input 추가
				event.preventDefault();
				if ($("#variDIV").children("#emptyVariation").length != 0) {	
					$("#variDIV").children("#emptyVariation").remove();
				}
				$("#variDIV").append("<li class='VRI'>종류:<span><input type='text' class='variations'></span></li>");
		}); //vADD end
				
		 $("#bADD").click(function() {//번들 input 추가
			event.preventDefault();
			if ($("#bundleDIV").children("#emptyBundle").length != 0) {	
				$("#bundleDIV").children("#emptyBundle").remove();
			}
			$("#bundleDIV").append("<li class='BUD'>번들:<span><input type='text' class='bcategory'></span> 번들가격:<span><input type='text' class='bprice'></span></li>");
			}); //bADD end
			
		$("#vDEL").click(function() {
			event.preventDefault();
			$("#variDIV").find(".VRI").last().remove();
			if ($("#variDIV").find(".VRI").length == 0 && $("#variDIV").find("#emptyVariation").length == 0) {	
				$("#variDIV").append("<li id='emptyVariation'>종류없음</li>");
			}
		});
		$("#bDEL").click(function() {
			event.preventDefault();
			$("#bundleDIV").find(".BUD").last().remove();
			if ($("#bundleDIV").find(".BUD").length == 0 && $("#bundleDIV").find("#emptyBundle").length == 0) {	
				$("#bundleDIV").append("<li id='emptyBundle'>번들없음</li>");
			}
		});
		
		$("#goodsForm").submit(function(event) {
		 	var inputCheck = true;
			/*$("#goodsForm").children("input").each(function() {
				if (this.value.length < 1) {
					inputCheck = false;
					return false;
				}
			});
			if (!inputCheck){
				alert("모든 칸을 채워주세요.");
			}else { */
				if ($("#image").val().length != 0) {
					imageUpload();
				}
				insertVariation();
				insertBundle();
				alert("수정이 완료되었습니다.");
			/* } */
			return inputCheck;
		});//submit end
	});//ready end
	
	function imageUpload() {//이미지 저장, imageUpload의 dir변경
		var form = new FormData();
		form.append("image",$("#image")[0].files[0]);
		$.ajax({
			url:"imageUpload",
			type: "post",
			data: form, 
			contentType : false,
			processData : false,
			async:false,
			success: function (data,status,xhr) {
			},
			error: function(xhr,status,error) {
				console.log(error);
			}
		});//end ajax
	}//imageUpload end
	
	function insertVariation() {//each를 이용해서  variation 저장
		$(".VRI").each(function(i, element) {
			var vri = $(this).find(".variations").val();
			var prevariation = $("#variation").val();	//기존 variation
			if (vri.length != 0) {
				if (prevariation.length == 0) {
					$("#variation").val(vri);
				}else {
					$("#variation").val(prevariation+"/"+vri);
				}
			}
		});//each end
	}//insertVariation end
	
	function insertBundle() {//each를 이용해서  bundle 저장
		$(".BUD").each(function(i, element) {
			var bcategory = $(this).find(".bcategory").val();
			var bprice = $(this).find(".bprice").val();
			var prebundle = $("#bundle").val();
			if (bcategory.length != 0 && bprice.length != 0) {
				if (prebundle.length == 0) {
					$("#bundle").val(bcategory+":"+bprice);
				}else {
					$("#bundle").val(prebundle + "/"+bcategory+":"+bprice);
				}
			}
			
		});//each end
	}//insertBundle end

	
</script>

제품이미지: <input type="file" name="file" id="image" ><br>
<hr>

<form id="goodsForm" action="goodsUpdate" >
<input type="hidden" name="gcode" value="${gdto.gcode}">
<input type="hidden" name="gimage" id="gimage" value="${gdto.gimage}">
<input type="hidden" name="variation" id="variation">
<input type="hidden" name="bundle" id="bundle">
<div>
<ul>
<li>이미지명: <span><input type="text" id="fakeImage" value="${gdto.gimage}" disabled="disabled"></span></li>
<li>제품코드:${gdto.gcode}</li>
<li>
제품카테고리:
	<label><input type="radio" name="gcategory" value="beverage"> beverage</label>
	<label><input type="radio" name="gcategory" value="coffee"> coffee</label>
    <label><input type="radio" name="gcategory" value="liquid"> liquid</label>
 </li>
<li>제품 이름:<span><input type="text" name="gname" value="${gdto.gname}"></span></li>
<li>제품단일 가격 :<span><input type="text" name="gprice" value="${gdto.gprice}"></span></li>
<li>제품 재고:<span><input type="text" name="gamount" value="${gdto.gamount}"></span></li>
<li>
	<div id="variDIV">
		<c:if test="${gdto.variation == null}">
			<span id="emptyVariation">종류없음</span>
		</c:if>
		<c:forTokens var="token" items="${gdto.variation}" delims="/" varStatus="status">
			<li class='VRI'>종류:<span><input type="text" class="variations" value="${token}"></span></li>
		</c:forTokens>
	</div>
	<button id="vADD" >종류추가</button>
	<button id="vDEL">종류삭제</button><br>
</li>

<li>
<div id="bundleDIV">
	<c:if test="${empty blist}">
		<span id="emptyBundle">번들없음</span>
	</c:if>
	<c:forTokens var="tokens" items="${gdto.bundle}" delims="/" varStatus="status">
		<li class="BUD">
			<c:forTokens var="token" items="${tokens}" delims=":" varStatus="status">
				<c:if test="${status.first}">
				번들:<span><input type="text" class="bcategory" value="${token}"></span>
				</c:if>
				<c:if test="${status.last}">
				번들가격:<span><input type="text" class="bprice" value="${token}"></span>
				</c:if>
			</c:forTokens>
		</li>
	</c:forTokens>
</div>
<button id="bADD">번들추가</button>
<button id="bDEL">번들삭제</button>
</li>

<li><input type="submit" value="수정"></li>
</ul>
</div>
</form>

