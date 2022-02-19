(function() {
  "use strict";

  App.ParticipationNotAllowed = {
    not_allowed: function(votes) {
      var buttons = votes + " [type='submit']";

      $("body").on("click", buttons, function(event) {
        var not_allowed = $("div.participation-not-allowed", $(event.target).closest(votes));

        if (not_allowed.length > 0) {
          event.preventDefault();
          not_allowed.show().focus();

          if (votes === "div.votes") {
            $("button", $(event.target).closest(votes)).prop("disabled", true);
          } else {
            $(event.target).closest("form").remove();
          }
        }
      });
    },
    initialize: function() {
      App.ParticipationNotAllowed.not_allowed("div.votes");
      App.ParticipationNotAllowed.not_allowed("div.supports");
    }
  };
}).call(this);
