$(function(){
    /* Navigation */
    $('#js_nav_button').on('click', function(){
        if(!$(this).hasClass('on')){
            $(this).addClass('on');
            $('#js_modal').addClass('on');
        }else{
            $(this).removeClass('on');
            $('#js_modal').removeClass('on');
        }
        return false;
    });

    /* JSON */
    $.getJSON("ayaladate.json" , function($jsonData) {
        var $ulObj = $("#shop_list"),
        $len = $jsonData.length;

        for(var i = 0; i < $len; i++) {
            var $addClass = '';

            if($jsonData[i].id == $startShopName){
                $addClass = 'start_shop';
            }
            if($jsonData[i].id == $goalShopName){
                $addClass = 'goal_shop';
            }
            $ulObj.append($('<li>').attr({'data-shop-id': $jsonData[i].id}).attr({'data-shop-floor': $jsonData[i].floor}).addClass($addClass).text($jsonData[i].shop));
        }
    });
});

