# # Define App
# BookApp = angular.module("BookApp", [
#   "ngRoute",
#   "ngResource"
# ])

# # Setup the angular router during the
# #   config state of the application
# BookApp.config(["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider)->
#   $routeProvider
#     .when("/books", {
#       templateUrl: "/books_templates/index",
#       controller: "BooksCtrl"
#     })
#     .when("/books/:id", {
#       templateUrl: "/books_templates/show",
#       controller: "BookDetailsCtrl"
#     })
#     .otherwise({
#       redirectTo: "/books"
#     })
#   $locationProvider.html5Mode(true)
# ])

# BookApp.factory("Books", ["$resource", ($resource)->
#   $resource("/books/:id.json", {id: "@id"}, {update: {method: "PUT"}})
# ])

# # Need a BookDetailsCtrl
# BookApp.controller("BookDetailsCtrl", ["$scope", "$http", "$routeParams", ($scope, $http, $routeParams)->
#   $scope.book_id = $routeParams.id

#   $http.get("/books/#{$scope.book_id}.json")
#     .success((data)-> $scope.book = data)
# ])

# # Define Controller
# BookApp.controller("BooksCtrl", ["$scope", "$http", "Books", ($scope, $http, Books) ->

#   $scope.books = []

#   Books.query (data)-> 
#     console.log("RETRIEVED ALL BOOKS!!!")
#     $scope.books = data

#   $scope.addBook = ->
#     console.log $scope.newBook
#     $http.post("/books.json", $scope.newBook).success (data)->
#       console.log "BOOK SAVED!"
#       $scope.newBook = {}
#       $scope.books.push(data)

#   $scope.deleteBook = ->
#     console.log @book
#     $http.delete("/books/#{@book.id}.json").success (data)=>
#       console.log "book deleted"
#       $scope.books.splice(@$index,1)

# ])

# # Define Config
# BookApp.config(["$httpProvider", ($httpProvider)->
#   $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
# ])