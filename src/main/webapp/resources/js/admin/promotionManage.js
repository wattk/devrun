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


});