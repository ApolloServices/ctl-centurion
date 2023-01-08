document.addEventListener('turbolinks:load', function() {
    $(document).ready(function(){
        $('.datepicker').datepicker({
            autoclose: true,
            format: 'yyyy-mm-d'
        });
    });
});

document.addEventListener('turbolinks:load', function() {
    $(document).ready(function () {
        $("#dttb").dataTable();

        $select = $("#dttb_length").children("label").children("select");
        $select.addClass('btn btn-default dropdown-toggle');

    });

    $(document).ready(function () {
        $(function() {
            $('.checkbox-select').multiselect({
                enableClickableOptGroups: true,
                buttonWidth: '100%',
                numberDisplayed: 1,
                includeSelectAllOption: true,
                maxHeight: 250,
                enableFiltering: true,
                filterBehavior: 'both',
                enableCaseInsensitiveFiltering: true,
            });
        });
    });

});