import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:untitled/Core/errors/failures/exceptions.dart';
import 'package:untitled/Features/number_trivia/data/data_source/local/number_trivia_local_data_source.dart';
import 'package:untitled/Features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../core/mocks/mocks_generator.mocks.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDataSourceImpl localDataSourceImpl;
  setUpAll(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSourceImpl = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });
  group('testing local dataSource', () {

    group('when there is data in cache', () {
     final tNumberModel=NumbersTriviaModel.fromJson(json.decode(fixtureReader('trivia_number.json')));
      test(
          '${1}- when calling getLastNumberTrivia should get a numbers model',
              () async {
            // arrange
            when(mockSharedPreferences.getString(KeyStorage.numberKey.toString())).thenReturn(
                fixtureReader('trivia_number.json'));
            // act
            final result = await localDataSourceImpl.getLastNumberTrivia();
            // assert
            verify(mockSharedPreferences.getString(KeyStorage.numberKey.toString()));
            expect(result,equals(tNumberModel));
          });
    });

    group('when there is no data in cache', () {

      test(
          '${2}- when calling getLastNumberTrivia should throw a cache exception',
              () async {
            // arrange
            when(mockSharedPreferences.getString(KeyStorage.numberKey.toString())).thenReturn(
                null);
            // act
            final call = localDataSourceImpl.getLastNumberTrivia;
            // assert
            verify(mockSharedPreferences.getString(KeyStorage.numberKey.toString()));
            expect(()=> call(),throwsA(const TypeMatcher<CacheExceptions>()));
          });
    });
  });
}
