/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function () {


    $('.all').change(function () {
        var notAllChecked = $('.all:checked').size() < $('.all').length;
      
        if (notAllChecked)
        {
            $('#selectAll').prop("checked", false);
        }
        else
        {
            $('#selectAll').prop("checked", true);
        }
    });

    $('#selectAll').change(function ()
    {
        if ($(this).prop('checked'))
        {

            $('.all').prop("checked", true);

        }
        else
        {
            $('.all').prop("checked", false);
        }

    });


    $('#selectAll').trigger('change');
    $('.all').trigger('change');
});

