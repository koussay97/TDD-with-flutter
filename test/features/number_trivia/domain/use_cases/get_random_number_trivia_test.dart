import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:untitled/Core/utils/useCases/base_use_case.dart';
import 'package:untitled/Features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:untitled/Features/number_trivia/domain/use_cases/get_random_number_trivia_usecase.dart';

import '../../../../core/mocks/mocks_generator.mocks.dart';


void main() {
  late NumbersTrivia tNumberTrivia;
  late MockNumbersTriviaRepository repository;
  late GetRandomNumberTriviaUseCase useCase;

  setUp(() {
    repository = MockNumbersTriviaRepository();
    useCase = GetRandomNumberTriviaUseCase(repository);
    tNumberTrivia = const NumbersTrivia(
        text: 'random number trivia test',
        number: 23,
        type: 'random',
        found: true);
  });
  group('testing get random number trivia use case', () {
    test(
        'should get NumbersTrivia object when supplied no prams to the repository ',
        () async {
      // arrange
      when(repository.getRandomNumberTrivia())
          .thenAnswer((realInvocation) async => Right(tNumberTrivia));
      // act
      final result = await useCase(Params.nullParams());
      // assert
      expect(result, Right(tNumberTrivia));
      verify(repository.getRandomNumberTrivia());
      verifyNoMoreInteractions(repository);
    });
  });
}
