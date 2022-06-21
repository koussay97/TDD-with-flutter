import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/Core/errors/failures/failures.dart';
import 'package:untitled/Core/utils/useCases/base_use_case.dart';
import 'package:untitled/Features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:untitled/Features/number_trivia/domain/repository/numbers_trivia_repository.dart';

class GetConcreteNumberTriviaUseCase implements BaseUseCase<NumbersTrivia,Params>{
  final NumbersTriviaRepository repository;
  GetConcreteNumberTriviaUseCase(this.repository);

  @override
  Future<Either<Failures,NumbersTrivia>>call(Params p) async {
    if(p.number==null){
     return await repository.getRandomNumberTrivia();
    }
    return await repository.getConcreteNumberTrivia(p.number!);
  }
}
