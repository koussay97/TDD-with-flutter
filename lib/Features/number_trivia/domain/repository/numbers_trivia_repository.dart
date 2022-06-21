
import 'package:dartz/dartz.dart';
import 'package:untitled/Core/errors/failures/failures.dart';
import 'package:untitled/Features/number_trivia/domain/entities/number_trivia_entity.dart';


abstract class NumbersTriviaRepository {

  Future<Either<Failures,NumbersTrivia>> getRandomNumberTrivia();
  Future<Either<Failures,NumbersTrivia>> getRandomNumberTriviaDate();
  Future<Either<Failures,NumbersTrivia>> getRandomNumberTriviaYear();

  Future<Either<Failures,NumbersTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failures,NumbersTrivia>> getConcreteNumberTriviaByDate(DateTime date);
  Future<Either<Failures,NumbersTrivia>> getConcreteNumberTriviaByYear(int year);

}