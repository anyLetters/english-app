$(document).ready(function(){
  hideRus = $(".hide_rus");
  hideRus.on('click', function () {
    $(hideRus).fadeOut(350);
  })
  sidebar = $('.sidebar_search');
  toggle_button = $('.options_search_button');
  toggle_button.click(function() {
    sidebar.toggle(function(){
    sidebar.animate({width:300});
  })
});
});