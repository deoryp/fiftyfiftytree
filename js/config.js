// Place third party dependencies in the lib folder
//
// Configure loading modules from the lib directory,
// except 'app' ones, 
requirejs.config({
    "baseUrl": "js",
    "paths": {
      "backbone": "lib/backbone/backbone-min",
      "handlebars": "lib/handlebars/handlebars.runtime",
      "underscore": "lib/underscore/underscore-min",
      "text": "lib/text/text",
      "jquery": "lib/jquery/jquery-2.0.1.min"
    },
    shim: {
        underscore: {
            exports: '_'
        },
        backbone: {
            deps: ["underscore", "jquery"],
            exports: "Backbone"
        }
    }
});

// Load the main app module to start the app
requirejs(["main"]);
