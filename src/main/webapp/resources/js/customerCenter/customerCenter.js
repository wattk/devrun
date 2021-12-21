// 각 .faq-title을 클릭하면 인접한 다음 p.content가 slideToggle처리되도록 해야한다.
// 그외의 .faq-content는 slideUp해야 한다.(아코디언 효과)
$(".faq-title").on('click', function(e){
    //console.log(e.target, this);
    const $target = $(this); // this용법6에서 사용하기 위해 담아둠.

    // this용법6 : jquery each메소드 안의 callback함수에서 this는 이번턴에 전달된 요소를 가리킨다.
    $(".faq-content").each(function(i, p){
        //console.log(i, p);
        //console.log(this);

        // 현재 .faq-content가 이벤트발생객체 다음 .faq-content인 경우는 slideToggle, 그외는 slideUp처리한다.
        // jquery객체 비교메소드 is(selector | jquery객체)
        if($(this).is($target.next())){
            $(this).slideToggle(0);
        }
        else {
            $(this).slideUp(0);
        }
    })
});