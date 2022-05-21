<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script type="text/javascript">
	$(function() {
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
					console.log($("#gimage").val());
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
		
	
		$("#gcode").keyup(function() {//코드중복 검사
			$.ajax({
				url:"gcodeDuplicateCheck",
				type: "get",
				data: {gcode : $("#gcode").val()}, 
				dataType: "text",
				success: function (data,status,xhr) {
					$("#result").text(data);
				},
				error: function(xhr,status,error) {
					console.log(error);
				}
			});//end ajax
		});//end keyup
		

		$("#vDEL").click(function() {
			event.preventDefault();
			$("#variDIV").children(".VRI").last().remove();
			if ($("#variDIV").children(".VRI").length == 0 && $("#variDIV").children("#emptyVariation").length == 0) {	
				$("#variDIV").append("<li id='emptyVariation'>종류없음</li>");
			}
		});
		$("#bDEL").click(function() {
			event.preventDefault();
			$("#bundleDIV").children(".BUD").last().remove();
			if ($("#bundleDIV").children(".BUD").length == 0 && $("#bundleDIV").children("#emptyBundle").length == 0) {	
				$("#bundleDIV").append("<li id='emptyBundle'>번들없음</li>");
			}
		});
		
		$("#submitBtn").click(submit); //submitBtn end
		
		
	});//end ready 
	
		 function submit() {//동기로 구현
			
			if ($("#gcode").val().length == 0) {
				alert("제품코드를 입력해주세요.");
				$("#gcode").focus();
				event.preventDefault();
			}else if ($("#gname").val().length == 0) {
				alert("제품이름을 입력해주세요.");
				$("#gname").focus();
				event.preventDefault();
			}else if ($("#gprice").val().length == 0) {
				alert("제품가격을 입력해주세요.");
				$("#gprice").focus();
				event.preventDefault();
			}else if ($("#gamount").val().length == 0) {
				alert("재고수량을 입력해주세요.");
				$("#gamount").focus();
				event.preventDefault();
			}else if ($("#result").text() == "코드 중복") {
				alert("중복된 코드입니다. 다시입력해주세요.");
				$("#gcode").focus();
				event.preventDefault();
			}else {
				imageUpload();	//이미지 저장
				insertVariation(); //종류 저장
				insertBundle();	//번들 저장
				$("#goodsForm").submit();	
			}
		}
	
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
	
	
	function insertVariation() {//variation 입력
		$(".VRI").each(function(i, element) {
			var vri = $(this).find(".variations").val(); //추가하는 variation
			var prevariation = $("#variation").val();	//기존 variation
			if (prevariation.length == 0) {
				$("#variation").val(vri);
			}else {
				$("#variation").val(prevariation+"/"+vri);
			}
		});//each end
	}//insertVariation end
	
	function insertBundle() {//bundle 입력
		$(".BUD").each(function(i, element) {
			var bcategory = $(this).find(".bcategory").val();
			var bprice = $(this).find(".bprice").val();
			var prebundle = $("#bundle").val();
			if (prebundle.length == 0) {
				$("#bundle").val(bcategory+":"+bprice);
			}else {
				$("#bundle").val(prebundle + "/"+bcategory+":"+bprice);
			}
		});//each end
	}//insertBundle end

</script>

<div>
<ul>
<li>제품이미지: <span><input type="file" name="file" id="image"> </span></li>
</ul>
</div>
<hr>

<form id="goodsForm" action="goodsInsert">
<input type="hidden" name="gimage" id="gimage" value="null">
<input type="hidden" name="variation" id="variation">
<input type="hidden" name="bundle" id="bundle" >
<div>
<ul>
<li>제품코드:<span><input type="text" name="gcode" id="gcode"></span>
<span id="result"></span></li>

<li>
제품카테고리:
	<label><input type="radio" name="gcategory" value="beverage" checked> beverage</label>
	<label><input type="radio" name="gcategory" value="coffee"> coffee</label>
    <label><input type="radio" name="gcategory" value="liquid"> liquid</label> </li>
<li>제품 이름:<span><input type="text" name="gname" id="gname"></span> </li>
<li>제품단일 가격 :<span><input type="text" name="gprice" id="gprice"></span> </li>
<li>제품 재고:<span><input type="text" name="gamount" id="gamount"></span></li>

<li>
<div id="variDIV">
	<span id="emptyVariation">종류없음</span>
</div>
<button id="vADD" >종류추가</button>
<button id="vDEL">종류삭제</button><br>
</li>

<li>
<div id="bundleDIV">
<span id="emptyBundle">번들없음</span>
</div>
<button id="bADD">번들추가</button>
<button id="bDEL">번들삭제</button><br>
</li>
<li> <input type="reset" value="취소"><br> </li>
</ul>
</div>
</form>
<hr>



<li><button id="submitBtn">등록</button></li>

