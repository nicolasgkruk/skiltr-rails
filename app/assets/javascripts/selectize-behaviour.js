$(document).on("turbolinks:load", function() {
    var selectizeAddTagCallback = null;
    var selectizeAddSourceCallback = null;
    var selectizeAddProjectCallback = null;

    $('#new_tag').on('submit', function(e) {
        e.preventDefault();
        $.ajax({
            method: "POST",
            url: $(this).attr("action"),
            data: $(this).serialize(),
            success: function(response) {
                selectizeAddTagCallback({value: response.id, text: response.title});
                selectizeAddTagCallback = null;
                $(".tag-modal").modal('toggle');
            }
        });
    });

    $('#new_source').on('submit', function(e) {
        e.preventDefault();
        $.ajax({
            method: "POST",
            url: $(this).attr("action"),
            data: $(this).serialize(),
            success: function(response) {
                selectizeAddSourceCallback({value: response.id, text: response.title});
                selectizeAddSouceCallback = null;
                $(".source-modal").modal('toggle');
            }
        });
    });

    $('#new_project').on('submit', function(e) {
        e.preventDefault();
        $.ajax({
            method: "POST",
            url: $(this).attr("action"),
            data: $(this).serialize(),
            success: function(response) {
                selectizeAddProjectCallback({value: response.id, text: response.title});
                selectizeAddProjectCallback = null;
                $(".project-modal").modal('toggle');
            }
        });
    });

    $(".selectize-add-tag").selectize({
        plugins: ['remove_button'],
        create: function(input, callback) {
            selectizeAddTagCallback = callback;
            $(".tag-modal").modal();
            $('#tag-title').val(input);
        }
    });

    $(".selectize-add-source").selectize({
        sortField: 'text',
        create: function(input, callback) {
            selectizeAddSourceCallback = callback;
            $(".source-modal").modal();
            $('#source_title').val(input);
        }
    });

    $(".selectize-add-project").selectize({
        sortField: 'text',
        create: function(input, callback) {
            selectizeAddProjectCallback = callback;
            $(".project-modal").modal();
            $('#project_title').val(input);
        }
    });

    $(".tag-modal").on("hide.bs.modal", function(e) {
        if (selectizeAddTagCallback != null) {
            selectizeAddTagCallback();
            selectizeAddTagCallback = null;
        }
        $("#new_tag").trigger("reset");
        $('form input[type="submit"]').prop("disabled", false);
    });

    $(".source-modal").on("hide.bs.modal", function(e) {
        if (selectizeAddSourceCallback != null) {
            selectizeAddSourceCallback();
            selectizeAddSourceCallback = null;
        }
        $("#new_source").trigger("reset");
        $('form input[type="submit"]').prop("disabled", false);
    });

    $(".project-modal").on("hide.bs.modal", function(e) {
        if (selectizeAddProjectCallback != null) {
            selectizeAddProjectCallback();
            selectizeAddProjectCallback = null;
        }
        $("#new_project").trigger("reset");
        $('form input[type="submit"]').prop("disabled", false);
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