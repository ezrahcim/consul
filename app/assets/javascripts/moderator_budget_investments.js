(function() {
  "use strict";
  App.ModeratorBudgetInvestments = {
    add_class_faded: function(id) {
      $("#" + id).addClass("faded");
      $("#comments").addClass("faded");
    },
    hide_moderator_actions: function(id) {
      $("#" + id + " .js-moderator-investment-actions:first").hide();
    }
  };
}).call(this);
