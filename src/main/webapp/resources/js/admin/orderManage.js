/**
 * 
 */
 $(document).ready(()=>{
	
//주문 검색 날짜 배지 클릭에 따른 날짜 지정
$(".date-badge").click((e)=>{
	const $startDate = $("[name=startDate]"); 
	const $endDate = $("[name=endDate]"); 
	$(".date-badge")
		.removeClass("badge-primary")
		.addClass("badge-secondary");
	$(e.target)
		.removeClass("badge-secondary")
		.addClass("badge-primary");
	
	if($(e.target).data("target") == 'today'){
		let now = new Date();
        let nowDay = now.getDate(); 
        let nowMonth = now.getMonth(); 
        let nowYear = now.getYear(); 
        nowYear += (nowYear < 2000) ? 1900 : 0; 
		$startDate.val(formatDate(now));
        $endDate.val(formatDate(new Date(nowYear, nowMonth, nowDay, 11, 59, 59)));
	}
	else if($(e.target).data("target") == 'week'){
		let now = new Date(); 
        let nowDayOfWeek = now.getDay(); 
        let nowDay = now.getDate(); 
        let nowMonth = now.getMonth(); 
        let nowYear = now.getYear(); 
        nowYear += (nowYear < 2000) ? 1900 : 0; 
        let weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek); 
        let weekEndDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek), 11, 59, 59);
        $startDate.val(formatDate(weekStartDate));
        $endDate.val(formatDate(weekEndDate));
	}
	else if($(e.target).data("target") == 'month'){
		let now = new Date();
	    let nowYear = now.getYear();
	    nowYear += (nowYear < 2000) ? 1900 : 0; 
	    let firstDate = new Date(nowYear,now.getMonth(), 1);
	    let lastDate = new Date(nowYear,now.getMonth()+1, 0, 11, 59, 59);
        $startDate.val(formatDate(firstDate));
        $endDate.val(formatDate(lastDate));
	}
	else if($(e.target).data("target") == 'all'){
		$startDate.val('');
        $endDate.val('');
	}
});

function formatDate(date) {
    let d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) 
        month = '0' + month;
    if (day.length < 2) 
        day = '0' + day;

    return [year, month, day].join('-');
}
});