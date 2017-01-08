$(document).ready(function(){
  hideRus = $(".hideRus");
  hideRus.on('click', function () {
    $(hideRus).fadeOut(350);
})
  sidebar = $('.sidebar_search');
  toggle_button = $('.options_search_button');
  
  toggle_button.click(function() {
    sidebar.toggle(function(){
    sidebar.animate({width:300});
    // $('.content_word').animate({left:0});
    //   },function(){
    // sidebar.animate({width:200});
    // $('.content_word').animate({left:200});
    // toggle_button.animate({left:200});
})
  // $(".get_word").on('click', function () {
  //   $.ajax({
  //     type:"GET",
  //     url:"words",
  //     dataType:"json",
  //     cache:"false",
  //     format: 'script',
  //     data: {word: { english: "", russian: "", id: "" }},
  //     success:function(words){
  //       console.log('всё круто');
  //       console.log(words);
  //       $('.wordEng').text(words['words']['eng'])
  //       $('.wordRus').text(words['words']['rus'])
  //       // hideRus.fadeIn(0);
  //       // $("#REST_edit").attr("href", "/words/"+data["data"]["id"]+"/edit");
  //       // $("#REST_show").attr("href", "/words/"+data["data"]["id"]+"");
  //     },
  //     error:function(data){
  //       // console.log('пиздец');
  //     }
  //   });
  // });
  });
});