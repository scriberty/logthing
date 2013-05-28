// with much help from http://www.fullscale.co/blog/2013/02/28/getting_started_with_elasticsearch_and_AngularJS_searching.html

////////////////////////////////////////////////////////////////////////////////
/// angular setup
////////////////////////////////////////////////////////////////////////////////

angular.module('logthing', [
    'controllers',
    'elasticjs.service'
]);

////////////////////////////////////////////////////////////////////////////////
/// controllers
////////////////////////////////////////////////////////////////////////////////

angular
    .module('controllers', [])
    .controller('SearchCtrl', function($scope, ejsResource) {
        var location = window.location;
        var ejs;

        if( /_plugin/.test(location.href.toString()) ) {
            ejs = ejsResource(location.protocol + "//" + location.host);
        } else {
            ejs = ejsResource("http://localhost:9200")
        }

        var oQuery = ejs.QueryStringQuery().defaultField('text');
        var client = ejs.Request()
            .indices('logthing')
            .types('message');

        $scope.search = function() {
            $scope.results = client
                .query(oQuery.query($scope.queryTerm || '*'))
                .size(10)
                .doSearch();
        };
    });
