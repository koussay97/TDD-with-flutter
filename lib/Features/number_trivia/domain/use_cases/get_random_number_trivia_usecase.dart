

import 'package:dartz/dartz.dart';
import 'package:untitled/Core/errors/failures/failures.dart';
import 'package:untitled/Core/utils/useCases/base_use_case.dart';
import 'package:untitled/Features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:untitled/Features/number_trivia/domain/repository/numbers_trivia_repository.dart';

class GetRandomNumberTriviaUseCase implements BaseUseCase<NumbersTrivia,Params>{
  final NumbersTriviaRepository repository;

  GetRandomNumberTriviaUseCase(this.repository);

  @override
  Future<Either<Failures, NumbersTrivia>> call(Params nullParams) async {
   return await repository.getRandomNumberTrivia();
  }
}