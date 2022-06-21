import 'package:dartz/dartz.dart';
import 'package:untitled/Core/errors/failures/failures.dart';
import 'package:untitled/Core/utils/useCases/base_use_case.dart';
import 'package:untitled/Features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:untitled/Features/number_trivia/domain/repository/numbers_trivia_repository.dart';

class GetNumberTriviaByDate implements BaseUseCase<NumbersTrivia, Params>{
  final NumbersTriviaRepository repository;

  GetNumberTriviaByDate(this.repository);

  @override
  Future<Either<Failures,NumbersTrivia>> call(Params params) async{
    if(params.dateTime == null ){
      return await repository.getRandomNumberTriviaDate();
    }
  return await repository.getConcreteNumberTriviaByDate(params.dateTime!);
  }

}