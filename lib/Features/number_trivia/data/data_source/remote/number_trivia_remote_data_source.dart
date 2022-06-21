import 'dart:io';

import 'package:untitled/Core/errors/failures/exceptions.dart';
import 'package:untitled/Features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource{

  /*------------------ Randoms ------------------*/
  /// calls http://numbersapi.com/random/trivia
  /// on any [Exception] throws a [ServerExceptions]

  Future<NumbersTriviaModel> getRandomNumberTrivia();

  /// calls http://numbersapi.com/random/date
  /// on any [Exception] throws a [ServerExceptions]

  Future<NumbersTriviaModel> getRandomNumberTriviaDate();

  /// calls http://numbersapi.com/random/year
  /// on any [Exception] throws a [ServerException]

  Future<NumbersTriviaModel> getRandomNumberTriviaYear();


  /*-----------------Concretes-------------------*/
  /// calls http://numbersapi.com/#number
  /// on any [Exception] throws a [ServerExceptions]
  Future<NumbersTriviaModel> getConcreteNumberTrivia(int number);

  /// calls http://numbersapi.com/month/day/date
  /// on any [Exception] throws a [ServerExceptions]

  Future<NumbersTriviaModel> getConcreteNumberTriviaByDate(DateTime date);

  /// calls http://numbersapi.com/#number/year
  /// on any [Exception] throws a [ServerExceptions]

  Future<NumbersTriviaModel> getConcreteNumberTriviaByYear(int year);

}