import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:untitled/Features/number_trivia/data/models/number_trivia_model.dart';
import 'package:untitled/Features/number_trivia/domain/entities/number_trivia_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tNumberTriviaModel = NumbersTriviaModel(
      found: true, number: 2, text: 'test model', type: 'model');

  test('tNumberTriviaModel should be a sub class of number trivia entity',
      () async {
    expect(tNumberTriviaModel, isA<NumbersTrivia>());
  });

  group('model fromJson', () {
    late NumbersTriviaModel modelMatcher;
    late NumbersTriviaModel modelMatcher2;
    setUp(() {
      modelMatcher = const NumbersTriviaModel(
          text:
          "748 is the number of 3×3 sliding puzzle positions that require exactly 12 moves to solve starting with the hole in a corner.",
          number: 748,
          type: "math",
          found: true);
      modelMatcher2 = const NumbersTriviaModel(
          text:
          "748 is the number of 3×3 sliding puzzle positions that require exactly 12 moves to solve starting with the hole in a corner.",
          number: 1,
          type: "math",
          found: true);

    });


    test('should return number trivia model when the number is int ', () async {
      // arrange
      final map = json.decode(fixtureReader('trivia_number.json'));

      // act
      final result = NumbersTriviaModel.fromJson(map);
      // assert
      expect(result, modelMatcher);
      expect(map,isA<Map<String,dynamic>>());
      });

    test('should return number trivia model when the number is a double ',
        () async {
          // arrange
          final map = json.decode(fixtureReader('trivia_number_double.json'));

          // act
          final result = NumbersTriviaModel.fromJson(map);
          // assert
          expect(result, modelMatcher2);
          expect(map,isA<Map<String,dynamic>>());
    });

    test('should return number trivia model when the number is a date ',
        () async {
          // arrange
          final map = json.decode(fixtureReader('trivia_date.json'));

          // act
          final result = NumbersTriviaModel.fromJson(map);
          // assert
          expect(result, isA<NumbersTriviaModel>());
          expect(map,isA<Map<String,dynamic>>());
    });
    test('should return number trivia model when the number is a year ',
            () async {
          // arrange
          final map = json.decode(fixtureReader('trivia_year.json'));

          // act
          final result = NumbersTriviaModel.fromJson(map);
          // assert
          expect(result, isA<NumbersTriviaModel>());
          expect(map,isA<Map<String,dynamic>>());
        });
  });


}
