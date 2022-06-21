/*
* GetConcreteNumbers trivia use case will get its data from the NumbersTriviaRepository
* although the NumbersTriviaRepository is abstract, therefore we need to mock it
* */
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:untitled/Core/errors/failures/failures.dart';
import 'package:untitled/Core/utils/useCases/base_use_case.dart';

import 'package:untitled/Features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:untitled/Features/number_trivia/domain/repository/numbers_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:untitled/Features/number_trivia/domain/use_cases/get_concrete_number_trivia_usecase.dart';

import '../../../../core/mocks/mocks_generator.mocks.dart';



void main() {
  late GetConcreteNumberTriviaUseCase concreteUseCase;
  late MockNumbersTriviaRepository mockNumberTriviaRepository;
  late int tNumber;
  late NumbersTrivia tNumberTrivia;
  late NumbersTrivia tRandomTrivia;
late ServerFailures failure;
  setUp(() {
    failure=ServerFailures(properties: []);
    tNumber = 1;
    tRandomTrivia = const NumbersTrivia(
        text: 'random', number: 22, type: 'test', found: true);
    tNumberTrivia = NumbersTrivia(
        text: 'test number text', number: tNumber, type: 'type', found: true);

    mockNumberTriviaRepository = MockNumbersTriviaRepository();
    concreteUseCase =
        GetConcreteNumberTriviaUseCase(mockNumberTriviaRepository);
  });

  group('testing get concrete number trivia use case', () {

    test('should get trivia object for the number passed to the repository',
        () async {
      // arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber))
          .thenAnswer((realInvocation) async => Right(tNumberTrivia));
      // act
      final result = await concreteUseCase(Params.number(number: tNumber));
      // assert
      expect(result, Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    });

    test(
        'should get random trivia object if the number passed to the repository was null',
        () async {
      // arrange
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((realInvocation) async => Right(tRandomTrivia));
      // act
      final result = await concreteUseCase(Params.nullParams());
      // assert
      expect(result, Right(tRandomTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    });
    test('should return Failure object on socket exception', () async {
      // arrange
      when(concreteUseCase.call(Params.number(number: tNumber))
          .timeout(const Duration(microseconds: 500)))
          .thenAnswer((realInvocation) async=> Left(failure));

      /*when(concreteUseCase.call(Params.number(number: tNumber)).onError((error, stackTrace) => Left(failure)))
          .thenAnswer((realInvocation) async => Left(failure));*/
      // act
     final result =  await Future.delayed(
       const Duration(microseconds: 600),
           () => concreteUseCase(Params.number(number: tNumber)),
     );
      // assert
     expect(result, Left(failure));
     verify(concreteUseCase(Params.number(number: tNumber)));
     verifyNoMoreInteractions(mockNumberTriviaRepository);
    });
  });
}
