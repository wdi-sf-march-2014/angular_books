# Define App
BookApp = angular.module("BookApp", ["ngRoute"])


BookApp.config(["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider)->
  $routeProvider
  .when("/books", {
    templateUrl: "/books_templates/index",
    controller: "BooksCtrl"
  }).when("/books/:id", {
    templateUrl: "/books_templates/show",
    controller: "BooksDetailCtrl"
  }).otherwise({
    redirectTo: '/books'
  })
  $locationProvider.html5Mode(true);
])

# Define Controller
BookApp.controller("BooksCtrl", ["$scope", "$http", "$routeParams", ($scope, $http, $routeParams) ->

  $scope.books = []

  $http.get("/books.json").success (data)->
    $scope.books = data

  $scope.addBook = ->
    console.log $scope.newBook
    $http.post("/books.json", $scope.newBook).success (data)->
      console.log "BOOK SAVED!"
      $scope.newBook = {}
      $scope.books.push(data)

  $scope.deleteBook = ->
    console.log @book
    $http.delete("/books/#{@book.id}.json").success (data)=>
      console.log "book deleted"
      $scope.books.splice(@$index,1)

])

BookApp.controller("BooksDetailCtrl", ["$scope", "$http", "$routeParams", ($scope, $http, $routeParams) ->

  $scope.id = $routeParams.id

  $http.get("/books/" + $scope.id+ ".json").success (data)->
    $scope.book = data
])

# Define Config
BookApp.config(["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])