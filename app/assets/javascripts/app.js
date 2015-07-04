angular.module('fastFacts', [])
    .controller('ItemController', ['$scope', function($scope) {
        $scope.facts = facts;
        $scope.fact_tags = fact_tags;
    }]);