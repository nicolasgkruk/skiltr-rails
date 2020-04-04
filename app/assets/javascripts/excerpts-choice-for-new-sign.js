$(document).on("turbolinks:load", function() {
    //let excerptIds = [];

    let chosenExcerpts = [];

    $('.add-excerpt-to-sign').click(function() {
        const excerptId = $(this).attr('id').slice(12);
        $(this).addClass('no-show');
        //excerptIds.push(excerptId);
        $("#remove-excerpt-" + excerptId).removeClass('no-show');
        $(this).closest("li").addClass('selected-excerpt');
        const addLiHtml = $(this).closest("li").html();
        chosenExcerpts.push({id: excerptId, html: addLiHtml});
    });

    $('.remove-excerpt-from-sign').click(function() {
        const excerptId = $(this).attr('id').slice(15);
        $(this).addClass('no-show');
        //excerptIds = excerptIds.filter(x => x !== excerptId);
        $("#add-excerpt-" + excerptId).removeClass('no-show');
        $(this).closest("li").removeClass('selected-excerpt');
        chosenExcerpts = chosenExcerpts.filter(x => x.id !== excerptId);
    });

    $('#show-selected-excerpts').click(() => {
        $(".show-selected-excerpts-modal .modal-body").html(chosenExcerpts.map(x => x.html).concat());
        $(".show-selected-excerpts-modal .modal-body .li-container").addClass('show-within-form-modal');
        $('.show-within-form-modal').find('.excerpt-actions').addClass('no-show');
        $('.show-within-form-modal').find('.remove-excerpt-from-sign').addClass('no-show');
        $('.show-within-form-modal').find('.remove-excerpt-from-within-form-modal').removeClass('no-show');

        $('.remove-excerpt-from-within-form-modal').click(function() {
            const excerptId = $(this).attr('id').slice(22);
            $(this).addClass('no-show');
            $("#add-excerpt-" + excerptId).removeClass('no-show');
            //Not sure if (this) is correct... actually no... it should be the specific li...
            //$(this).closest("li").removeClass('selected-excerpt');
            $(this).closest('.li-container').addClass('no-show');

            chosenExcerpts = chosenExcerpts.filter(x => x.id !== excerptId);
        });

        $(".show-selected-excerpts-modal").modal();
    });

    // poner arriba también de este form modal con los selected excerpts un textarea para poner el comment del sign?
    // abajo y arriba del form modal con los selected excerpts... agregar un botón de "Add a sign with these excerpts" (eso hace una ajax call a new con los excerpt_ids como query param).

});