//Buttons Logic

$(document).ready(function () {
    $("#generalBtn").addClass('active');
    $("#lowBtn, #mediumBtn, #highBtn").addClass('general');
});

$(document).on('click', '#generalBtn', function (e) {
  //, #lowBtn, #mediumBtn, #highBtn"
    $("#maleBtn, #femaleBtn").removeClass('active');
    $("#lowBtn, #mediumBtn, #highBtn").addClass('general').removeClass('male').removeClass('female');
});
//, #lowBtn, #mediumBtn, #highBtn
$(document).on('click', '#maleBtn, #femaleBtn', function (e) {
   $("#generalBtn").removeClass('active');
});

$(document).on('click', '#maleBtn', function (e) {
    $("#lowBtn, #mediumBtn, #highBtn").toggleClass('male');
});

$(document).on('click', '#femaleBtn', function (e) {
    $("#lowBtn, #mediumBtn, #highBtn").toggleClass('female');
});


$(document).on('change', function() {
   //alert($('input[name="Subject"]:checked').val()); 
  $('input[name="Subject"]:not(:checked)').parent().removeClass("active");
  $('input[name="Subject"]:checked').parent().addClass("active");
  //TODO: gender and escs
});

$(document).ready(function () {
   $("#Country1, #Country2, #Country1Survey, #Country1SurveyPlot, #Country2Survey, #Country2SurveyPlot").css('width', ($("#Country1Plot").width()+'px'));
});

//Set countries width the same width as plots width
$(window).on('resize', function(){
  $("#Country1, #Country2, #Country1Survey, #Country1SurveyPlot, #Country2Survey, #Country2SurveyPlot").css('width', ($("#Country1Plot").width()+'px'));
}).resize();