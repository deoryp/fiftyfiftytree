define(['jquery', 'backbone'], function($, Backbone) {

    var AppRouter = Backbone.Router.extend({
        initialize: function() {
             console.log("init the router");
            //Required for Backbone to start listening to hashchange events
            Backbone.history.start();
        },
        routes: {
            '': 'default'
        },
        'default': function(actions) {
            console.log("default");
            $('body').html("coming soon!!"); 
        }
    });

    return { 
        initialize: function () {
            var app_router = new AppRouter;
        }
    };
});
