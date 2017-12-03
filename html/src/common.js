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

});

