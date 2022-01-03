/**
 * cart.js
 */
 
 $(document).ready(()=>{
 //체크박스 해제 시 합산 가격 변경
$(".cart-checkbox").change((e)=>{
	const isChecked = $(e.target).prop("checked");
	const $parent = $(e.target).parent().parent();
	const price = $parent.data("price");
	const amount = $parent.data("amount");
	const total = $("#total").data("total");
	
	if(!isChecked){
		const cal = total-(price*amount);
		$("#total").html("&#8361;"+(cal).toLocaleString());
		$("#total").data("total", cal);
	}
	else{
		const cal = total + (price*amount)
		$("#total").html("&#8361;"+(cal).toLocaleString());
		$("#total").data("total", cal);
	}
});

//수량 변경 시 가격 변경
$("[name=amount]").change((e)=>{
	const target = "#"+$(e.target).data("target");
	const originalAmount = $(target).data("amount");
	const checkbox = $(target).find("input:checkbox");
	const isChecked = $(checkbox).prop("checked");
	const amount = $(e.target).val();
	const price = $(target).data("price");
	const total = $("#total").data("total");
	console.log(target);
	console.log(amount);
	
	//체크박스 해제되면 가격 빼기, 체크되면 가격 더하기
	if(isChecked){
		const cal = total + (price*amount)
		$("#total").html("&#8361;"+(cal).toLocaleString());
		$("#total").data("total", cal);
	}
	else{
		const cal = total-(price*amount);
		$("#total").html("&#8361;"+(cal).toLocaleString());
		$("#total").data("total", cal);
	}
	
	if(originalAmount<amount){
		const cal = total + (price*(amount-originalAmount));
		$("#total").html("&#8361;"+(cal).toLocaleString());
		$("#total").data("total", cal);
	}
	else{
		const cal = total - (price*(originalAmount-amount));
		$("#total").html("&#8361;"+(cal).toLocaleString());
		$("#total").data("total", cal);
	}
	$(target).data("amount", amount);
	console.log($(target).data("amount"));
});
 
 });