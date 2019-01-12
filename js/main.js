$(document).ready(function() {
    var toggleFn = function() {
        $(".navbar-burger").toggleClass("is-active");
        $(".navbar-menu").toggleClass("is-active");
    }

    $(".navbar-burger").click(toggleFn);
    $(".navbar-item").click(toggleFn);

    if (typeof grecaptcha !== 'undefined') {
        grecaptcha.ready(function() {
            var btn = $("#feedback-form #submit-button");
            btn.removeClass("is-loading");
            btn.click(function(){
                grecaptcha.execute('6Lf4HokUAAAAAERTH0_TYGv-Z_8-OuTlrPUEeJiM', {action: 'feedback_form'}).then(function(token) {
                    $("#feedback-form #captcha-token").val(token);
                    $("#feedback-form").submit();
                });
            });
        });
    }
});
