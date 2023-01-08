document.addEventListener('turbolinks:load', function(){
    $(document).ready(function() {

        var instrumentCallback = null;

        $("#instrument-modal").on("hide.bs.modal", function (e) {
            if (instrumentCallback != null) {
                instrumentCallback();
                instrumentCallback = null;
            }

            $("#new_instrument").trigger("reset");
            $.rails.enableFormElements($("#new_instrument"));
        });

        $("#new_instrument").on("submit", function (e) {
            e.preventDefault();
            $.ajax({
                method: "POST",
                url: $(this).attr("action"),
                data: $(this).serialize(),
                success: function (response) {
                    instrumentCallback({value: response.id, text: response.name});
                    instrumentCallback = null;

                    $("#instrument-modal").modal('toggle');
                }
            });
        });

        $("#instrument_ids").selectize({
            create: function (input, callback) {
                instrumentCallback = callback;

                $("#instrument-modal").modal();
                $("#instrument_name").val(input);
            }
        });

        ///////////////////////////////////   Surveyor ///////////////////////////////

        var surveyorCallback = null;

        $("#surveyor-modal").on("hide.bs.modal", function (e) {
            if (surveyorCallback != null) {
                surveyorCallback();
                surveyorCallback = null;
            }

            $("#new_user").trigger("reset");
            $.rails.enableFormElements($("#new_user"));
        });

        $("#new_user").on("submit", function (e) {
            e.preventDefault();
            $.ajax({
                method: "POST",
                url: $(this).attr("action"),
                data: $(this).serialize(),
                success: function (response) {
                    surveyorCallback({value: response.id, text: response.name});
                    surveyorCallback = null;

                    $("#surveyor-modal").modal('toggle');
                }
            });
        });

        $("#surveyor_ids").selectize({
            create: function (input, callback) {
                surveyorCallback = callback;

                $("#surveyor-modal").modal();
                $("#user_name").val(input);
            }
        });

        ///////////////////////////////////   Controller ///////////////////////////////

        var controllerCallback = null;

        $("#controller-modal").on("hide.bs.modal", function (e) {
            if (controllerCallback != null) {
                controllerCallback();
                controllerCallback = null;
            }

            $("#new_survey_controller").trigger("reset");
            $.rails.enableFormElements($("#new_survey_controller"));
        });

        $("#new_survey_controller").on("submit", function (e) {
            e.preventDefault();
            $.ajax({
                method: "POST",
                url: $(this).attr("action"),
                data: $(this).serialize(),
                success: function (response) {
                    controllerCallback({value: response.id, text: response.name});
                    controllerCallback = null;

                    $("#controller-modal").modal('toggle');
                }
            });
        });

        $("#controller_ids").selectize({
            create: function (input, callback) {
                controllerCallback = callback;

                $("#controller-modal").modal();
                $("#survey_controller_name").val(input);
            }
        });

        ///////////////////////////////// Client /////////////////////////////////////////

        var clientCallback = null;

        $("#client-modal").on("hide.bs.modal", function (e) {
            if (clientCallback != null) {
                clientCallback();
                clientCallback = null;
            }

            $("#new_client").trigger("reset");
            $.rails.enableFormElements($("#new_client"));
        });

        $("#new_client").on("submit", function (e) {
            e.preventDefault();
            $.ajax({
                method: "POST",
                url: $(this).attr("action"),
                data: $(this).serialize(),
                success: function (response) {
                    clientCallback({value: response.id, text: response.name});
                    clientCallback = null;

                    $("#client-modal").modal('toggle');
                }
            });
        });

        $("#client_id").selectize({
            create: function (input, callback) {
                clientCallback = callback;

                $("#client-modal").modal();
                $("#client_name").val(input);
            }
        });
    });

});