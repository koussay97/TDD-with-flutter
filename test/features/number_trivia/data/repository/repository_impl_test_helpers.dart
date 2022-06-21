import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:untitled/Core/errors/failures/failures.dart';
import 'package:untitled/Features/number_trivia/data/models/number_trivia_model.dart';
import 'package:untitled/Features/number_trivia/domain/entities/number_trivia_entity.dart';
import '../../../../core/mocks/mocks_generator.mocks.dart';


void deviceOnlineGroup({required Function body,required MockNetworkInfo networkInfo}) {
  group('case device onLine', () {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
    });
    body();
  });
}

void deviceOfflineGroup(Function body, MockNetworkInfo networkInfo) {
  group('case device offLine', () {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
    });
    body();
  });
}

Future<void> testingModel({
  required String testDescription,
  required Future<NumbersTriviaModel> useCase,
  required NumbersTriviaModel model,
  required Future<Either<Failures,NumbersTrivia>> act,
  required List<dynamic> verifier,
   List<Map<dynamic, dynamic>>? expected,
}) async {
  test(testDescription, () async {
    print('test function been called');
    // arrange
    when(useCase).thenAnswer((_) async => model);
    print('arrange success');
    // act
    final result = await act;
    print('act success');

    // assert

    for (var asserter in verifier) {
      verify(verifier);
    }
    print('assert verify success');

    if(expected != null){
    for (var exp in expected) {
      expect(exp.keys.first, exp.values.first);
    }
    print('assert expect success');
    }
  });
}
