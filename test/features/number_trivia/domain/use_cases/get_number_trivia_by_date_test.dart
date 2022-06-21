import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:untitled/Core/utils/useCases/base_use_case.dart';
import 'package:untitled/Features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:untitled/Features/number_trivia/domain/use_cases/get_number_trivia_by_date_usecase.dart';

import '../../../../core/mocks/mocks_generator.mocks.dart';


void main() {
  late MockNumbersTriviaRepository repository;
  late NumbersTrivia tNumberTrivia;
  late NumbersTrivia rNumberTrivia;
  late GetNumberTriviaByDate useCase;
  late DateTime dateTime;
  setUp(() {
    repository = MockNumbersTriviaRepository();
    useCase = GetNumberTriviaByDate(repository);
    dateTime = DateTime(2020, 12, 1);
    tNumberTrivia = const NumbersTrivia(
        text: 'test 1',
        number: 1220,
        type: 'date',
        found: true);
    rNumberTrivia = const NumbersTrivia(
        text: 'test 2 ',
        number: 20,
        type: 'test date2',
        found: true);
  });
  group('testing get number trivia by date', () {
    test(
        'should return number trivia instance when a valid date was provided to the repository',
        () async {
      // arrange
      when(repository.getConcreteNumberTriviaByDate(dateTime))
          .thenAnswer((realInvocation) async => Right(tNumberTrivia));

      // act
      final result = await useCase(Params.date(dateTime: dateTime));

      // assert
      expect(result, Right(tNumberTrivia));
      verify(repository.getConcreteNumberTriviaByDate(dateTime));
      verifyNoMoreInteractions(repository);
    });

    test(
        'should return random number trivia Date instance if null params was provided',
        () async {

      // arrange
      when(repository.getRandomNumberTriviaDate())
          .thenAnswer((realInvocation) async => Right(rNumberTrivia));

      // act
      final result = await useCase(Params.nullParams());

      // asset
      expect(result, Right(rNumberTrivia));
      verify(repository.getRandomNumberTriviaDate());
      verifyNoMoreInteractions(repository);
    });
  });
}
