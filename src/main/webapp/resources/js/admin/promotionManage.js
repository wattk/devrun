/**
 * 
 */
 
$(document).ready(()=>{
//체크박스 전체 선택
$(".checkbox-group").on("click", "#checkAll", ((e)=>{
  let checked = $(e.target).is(":checked");

  if(checked){
  	$(e.target).parents(".checkbox-group").find('input:checkbox').prop("checked", true);
  } else {
  	$(e.target).parents(".checkbox-group").find('input:checkbox').prop("checked", false);
  }
}));

//체크박스 개별 선택
$(".promotion-is-checked").on("click", ((e)=>{
    let isChecked = true;
    
    $(".promotion-is-checked").each((i, item)=>{
        isChecked = isChecked && $(item).is(":checked");
    });
    
    $("#checkAll").prop("checked", isChecked);
}));

$("#promotionListDeleteBtn").click((e)=>{
    let isChecked = false;
    
    $(".promotion-is-checked").each((i, item)=>{
        isChecked = isChecked || $(item).is(":checked");
        let target = $(item).data("target");
        
        if($(item).is(":checked")){
        	$(item).after(`<input type="hidden" name="promotionCode" value="\${target}"/>`);
        }
    });
    
    if(!isChecked){
    	alert("선택된 이벤트가 없습니다.");
    	return;
    }
	
    console.log("클릭");
    console.log($(document.promotionDeleteFrm));
    $(document.promotionDeleteFrm).submit();
});
});