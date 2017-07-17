$(function () {
    var ie6 = document.all;
    var dv = $('#tcy'), st;
    dv.attr('otop', dv.offset().top); //存储原来的距离顶部的距离
    $(window).scroll(function () {
        st = Math.max(document.body.scrollTop || document.documentElement.scrollTop);
        if (st > parseInt(dv.attr('otop'))) {
            if (ie6) {//IE6不支持fixed属性，所以只能靠设置position为absolute和top实现此效果
                dv.css({ position: 'absolute', top: st });
            }
            else if (dv.css('position') != 'fixed') dv.css({ 'position': 'fixed', top: 0 });
        } else if (dv.css('position') != 'static') dv.css({ 'position': 'static' });
    });
});
var myTimer;
var currentIndex = -1;	//当前图片索引
var $big = $('.big_img li');
var $title = $('.slider_title li');
var $small = $('.slider_list li');	//小图索引
function show() {		//进行索引位置的处理
    var next = currentIndex < ($big.length - 1) ? currentIndex + 1 : 0;	//判断图像的索引
    showImg(next);
}

function showImg(index) {
    $($big[index]).stop().fadeIn().siblings().stop().fadeOut();
    $($title[index]).stop().show().siblings().stop().hide();
    $($small[index]).addClass('current').siblings().removeClass('current');
    currentIndex = index;
}

$(function () {
    myTimer = setInterval("show()", 3000);
    //大图停止事件
    $big.hover(function () {
        clearInterval(myTimer);
    }, function () {
        myTimer = setInterval("show()", 3000);
    });
    //小图事件
    $small.hover(function () {
        var index = $(this).attr('index');
        clearInterval(myTimer);
        showImg(index - 1);
    }, function () {
        myTimer = setInterval("show()", 3000);
    });
    show();
});

$(document).ready(function () {
//限制字符个数
    $(".ltxt").each(function () {
        //字符个数
        var maxwidth = 11;
        if ($(this).text().length > maxwidth) {
            $(this).text($(this).text().substring(0, maxwidth));
            $(this).html($(this).html() + "...");
        }
    });
});
$("#box section .tab_top li").click(function () {
    $(this).addClass("active").siblings().removeClass("active")
    var $index = $(this).index();
    $("#box section .s_right > div").eq($index).show().siblings().hide();
})
$("#box .slider_list li").hover(function () {
    var $index = $(this).index();
    $("#box .wenzi_show > div").eq($index).show().siblings().hide();
})
//回到顶部和底部
$(document).ready(function () {
    $(".sct").hide();
    $(window).scroll(function () {
        if ($(window).scrollTop() > 100) {
            $(".sct").fadeIn(500);
        }
        else {
            $(".sct").fadeOut(500);
        }
    });
    $(".sct").click(function () {
        $('html,body').stop(true, true).animate({scrollTop: '0px'}, 800)
    });
    $(".ewm").hover(function (event) {
        $(".ewm_img").show()
    }, function (event) {
        $(".ewm_img").hide()
    });

});
