$(document).on("turbolinks:load", function() {
    let chosenExcerpts = [];

    function updateHref() {
        const excerptIds = chosenExcerpts.map(x => x.id);
        let excerptIdsToParams = '';

        for (let i = 0; i < excerptIds.length; i++) {
            excerptIdsToParams = excerptIdsToParams.concat('excerpt_ids%5B%5D=' + excerptIds[i]);
            if (i !== excerptIds.length - 1) {
                excerptIdsToParams = excerptIdsToParams.concat('&');
            }
        }
        return 'signs/new?' + excerptIdsToParams;
    };

    function addListeners() {
        $('.add-excerpt-to-sign').click(function() {
            const excerptId = $(this).attr('id').slice(12);
            $(this).addClass('no-show');
            $(".remove-excerpt-" + excerptId).removeClass('no-show');
            $(this).closest("li").addClass('selected-excerpt');
            const addLiHtml = $(this).closest("li").html();
            chosenExcerpts.push({id: excerptId, html: addLiHtml});

            // Update href of .create-sign-with-chosen-excerpts
            $('.create-sign-with-chosen-excerpts').attr('href', updateHref());
        });

        $('.remove-excerpt-from-sign').click(function() {
            const excerptId = $(this).attr('id').slice(15);
            $(this).addClass('no-show');
            $(".add-excerpt-" + excerptId).removeClass('no-show');
            $(this).closest("li").removeClass('selected-excerpt');
            chosenExcerpts = chosenExcerpts.filter(x => x.id !== excerptId);

            // Update href of .create-sign-with-chosen-excerpts
            $('.create-sign-with-chosen-excerpts').attr('href', updateHref());
        });
    };

    addListeners();

    $('#search-results').on('DOMSubtreeModified', function(){
        addListeners();

        //check the ids of those already selected and do the same we do when we click add-excerpt-to-sign
        for (let id of chosenExcerpts.map(x => x.id)) {
            $('.add-excerpt-' + id).addClass('no-show');
            $(".remove-excerpt-" + id).removeClass('no-show');
            $('.add-excerpt-' + id).closest("li").addClass('selected-excerpt');
        }
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
            $(".add-excerpt-" + excerptId).removeClass('no-show');
            $(".remove-excerpt-" + excerptId).addClass('no-show');
            $(".remove-excerpt-" + excerptId).closest("li").removeClass('selected-excerpt');
            $(this).closest('.li-container').addClass('no-show');
            chosenExcerpts = chosenExcerpts.filter(x => x.id !== excerptId);

            // Update href of .create-sign-with-chosen-excerpts
            $('.create-sign-with-chosen-excerpts').attr('href', updateHref());

            if (chosenExcerpts.length === 0) {
                $(".show-selected-excerpts-modal").modal('hide');
            }
        });

        $(".show-selected-excerpts-modal").modal();
    });

});