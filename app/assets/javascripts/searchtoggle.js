$(document).ready(function () {
    $('#mycategories').hide();
    $('#mytags').hide();
    $('#sort_by_tags').hide();
    $('#sort_by_titles').hide();
    $('#sort_by_dates').hide();
    $('#tag_button').bind('click', function() {
        $('#mytags').show();
        $('#mycategories').hide();
    });
    $('#category_button').bind('click', function() {
        $('#mytags').hide();
        $('#mycategories').show();



    });
    $('#tags_sort_button').bind('click', function() {
        $('#sort_by_titles').slideUp();
        $('#sort_by_dates').slideUp(function () {
            $('#sort_by_tags').slideDown();
        });



    });
    $('#titles_sort_button').bind('click', function() {
        $('#sort_by_dates').slideUp();
        $('#sort_by_tags').slideUp(function () {
            $('#sort_by_titles').slideDown();
        });



    });
    $('#dates_sort_button').bind('click', function() {
        $('#sort_by_tags').slideUp();
        $('#sort_by_titles').slideUp(function () {
            $('#sort_by_dates').slideDown();
        });


    });
});