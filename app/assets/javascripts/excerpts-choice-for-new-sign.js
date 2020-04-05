$(document).on("turbolinks:load", function() {
    let chosenExcerpts = [];

    $('.add-excerpt-to-sign').click(function() {
        const excerptId = $(this).attr('id').slice(12);
        $(this).addClass('no-show');
        $("#remove-excerpt-" + excerptId).removeClass('no-show');
        $(this).closest("li").addClass('selected-excerpt');
        const addLiHtml = $(this).closest("li").html();
        chosenExcerpts.push({id: excerptId, html: addLiHtml});
    });

    $('.remove-excerpt-from-sign').click(function() {
        const excerptId = $(this).attr('id').slice(15);
        $(this).addClass('no-show');
        $("#add-excerpt-" + excerptId).removeClass('no-show');
        $(this).closest("li").removeClass('selected-excerpt');
        chosenExcerpts = chosenExcerpts.filter(x => x.id !== excerptId);
    });

    $('#show-selected-excerpts').click(() => {

        if (chosenExcerpts.length === 0) {
            alert('Select at least one excerpt first');
            return;
        }

        $(".show-selected-excerpts-modal .modal-body").html(chosenExcerpts.map(x => x.html).concat());
        $(".show-selected-excerpts-modal .modal-body .li-container").addClass('show-within-form-modal');
        $('.show-within-form-modal').find('.excerpt-actions').addClass('no-show');
        $('.show-within-form-modal').find('.remove-excerpt-from-sign').addClass('no-show');
        $('.show-within-form-modal').find('.remove-excerpt-from-within-form-modal').removeClass('no-show');

        $('.remove-excerpt-from-within-form-modal').click(function() {
            const excerptId = $(this).attr('id').slice(22);
            $(this).addClass('no-show');
            $("#add-excerpt-" + excerptId).removeClass('no-show');
            $("#remove-excerpt-" + excerptId).addClass('no-show');
            $("#remove-excerpt-" + excerptId).closest("li").removeClass('selected-excerpt');
            $(this).closest('.li-container').addClass('no-show');
            chosenExcerpts = chosenExcerpts.filter(x => x.id !== excerptId);
            if (chosenExcerpts.length === 0) {
                $(".show-selected-excerpts-modal").modal('hide');
            }
        });

        $(".show-selected-excerpts-modal").modal();
    });

    // abajo y arriba del form modal con los selected excerpts... agregar un botón de "Add a sign with these excerpts" (eso hace una ajax call a new con los excerpt_ids como query param).

        $('.create-sign-with-chosen-excerpts').click(function() {
            const excerptIds = chosenExcerpts.map(x => x.id);
            $.ajax({
                method: "GET",
                url: 'signs/new',
                data: 'excerpt_ids%5B%5D=1&excerpt_ids%5B%5D=2',
                success: function(res) {}
            });
        });

});