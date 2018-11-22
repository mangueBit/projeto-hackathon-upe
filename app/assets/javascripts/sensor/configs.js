//= require jquery

$(".config-save").click(function(){
    $(this).prop('disabled',true);
    var input_class = ($(this).data("input_reference"));
    var input_content = $(`.${input_class}`).val();
    console.log(input_content);
    setTimeout(function(){
        $(".config-save").prop('disabled',false);
    }, 6000);
})