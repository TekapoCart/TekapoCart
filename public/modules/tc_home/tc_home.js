$(document).ready(function () {
    var begin = $('.scheduled_delivery_date').attr('data-begin');
    var disable = $('.scheduled_delivery_date').attr('data-disable');
    var option = {
        dateFormat: 'yy/mm/dd',
        minDate: '+' + begin,
        maxDate: '+1M +' + begin + 'D'
    };
    $('.scheduled_delivery_date').datepicker(option);
    $('.scheduled_delivery_date').on('click', function() {
        if (disable.length > 0) {
            disable.split(',').forEach(function(item){
                $('.ui-datepicker-calendar > tbody > tr').find('td:eq(' + item + ')').addClass('ui-datepicker-unselectable').addClass('ui-state-disabled');
            })
        }
    });

});
