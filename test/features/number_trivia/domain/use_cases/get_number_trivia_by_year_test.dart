import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:untitled/Core/utils/useCases/base_use_case.dart';
import 'package:untitled/Features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:untitled/Features/number_trivia/domain/use_cases/get_number_trivia_by_year_use_case.dart';

import '../../../../core/mocks/mocks_generator.mocks.dart';



void main(){
  late MockNumbersTriviaRepository repository;
  late NumbersTrivia tNumberTrivia;
  late NumbersTrivia rNumberTrivia;
  late GetNumberTriviaByYear useCase;
  late int year;
  setUp(()  {
    repository= MockNumbersTriviaRepository();
    useCase= GetNumberTriviaByYear(repository);
    year=2020;
    tNumberTrivia= NumbersTrivia(
        text: 'test 1 ',
        number: year,
        type: '',
        found: true);
    rNumberTrivia=const NumbersTrivia(
        text: 'test 2',
        number: 2001,
        type: 'type',
        found: true);
  });
  group('testing get trivia by year use case', () {

    test('should return a number trivia object if supplied a valid year', () async{

      // arrange
      when(repository.getConcreteNumberTriviaByYear(year))
          .thenAnswer((realInvocation) async =>Right(tNumberTrivia));

      // act
      final result = await useCase(Params.year(year: year));

      // assert
      expect(result, Right(tNumberTrivia));
      verify(repository.getConcreteNumberTriviaByYear(year));
     verifyNoMoreInteractions(repository);
    });

    test('should return random NumbersTrivia instance by year once the year is null', () async{

      // arrange
      when(repository.getRandomNumberTriviaYear())
          .thenAnswer((realInvocation) async=> Right(rNumberTrivia));

      // act
      final result = await useCase(Params.nullParams());

      // assert
      expect( result, Right(rNumberTrivia));
      verify(repository.getRandomNumberTriviaYear());
      verifyNoMoreInteractions(repository);
    });


  });
}