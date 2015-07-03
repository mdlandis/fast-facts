angular.module('fastFacts', [])
    .controller('ItemController', ['$scope', function($scope) {
        $scope.items = items;
    }]);