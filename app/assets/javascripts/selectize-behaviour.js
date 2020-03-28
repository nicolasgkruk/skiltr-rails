$(document).on("turbolinks:load", function() {
    var selectizeCallback = null;

    $(".tag-modal").on("hide.bs.modal", function(e) {
        if (selectizeCallback != null) {
            selectizeCallback();
            selectizeCallback = null;
        }
        $("#new_tag").trigger("reset");
        $('form input[type="submit"]').prop("disabled", false);
    });

    $('#new_tag').on('submit', function(e) {
        e.preventDefault();
        $.ajax({
            method: "POST",
            url: $(this).attr("action"),
            data: $(this).serialize(),
            success: function(response) {
                selectizeCallback({value: response.id, text: response.title});
                selectizeCallback = null;
                $(".tag-modal").modal('toggle');
            }
        });
    });

    $(".selectize-add-tag").selectize({
        plugins: ['remove_button'],
        create: function(input, callback) {
            selectizeCallback = callback;
            $(".tag-modal").modal();
           // $('#new_tag').trigger('reset');
            $('#tag-title').val(input);
        }
    });

    $(".selectize-search-multiple").selectize({
        plugins: ['remove_button']
        // delimiter: ',',
        // persist: true
    });

    $('.selectize-search-single').selectize({
        sortField: 'text'
    });


});