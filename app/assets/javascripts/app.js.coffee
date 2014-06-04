# Define App
BookApp = angular.module("BookApp", [])

# Define Controller
BookApp.controller("BooksCtrl", ["$scope", "$http", ($scope, $http) ->

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

# Define Config
BookApp.config(["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])