import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Core/errors/failures/exceptions.dart';

import '../../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /*-----------------cached trivia-------------------*/

  /// on any [Exception] throws a [CacheExceptions]
  Future<NumbersTriviaModel> getLastNumberTrivia();

  /// on any [Exception] throws a [CacheExceptions]
  Future<NumbersTriviaModel> getLastNumberTriviaByDate();

  /// on any [Exception] throws a [CacheExceptions]
  Future<NumbersTriviaModel> getLastNumberTriviaByYear();

  Future<void> cacheNumberTrivia(
      KeyStorage collectionName, NumbersTriviaModel model);
}

enum KeyStorage {
  numberKey,
  dateKey,
  yearKey,
}
class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource{
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(KeyStorage collectionName, NumbersTriviaModel model) {
throw UnimplementedError();
  }

  @override
  Future<NumbersTriviaModel> getLastNumberTrivia() {
    final result= sharedPreferences.getString(KeyStorage.numberKey.toString());
    if(result != null) {
      return Future.value(NumbersTriviaModel.fromJson(json.decode(result)));
    }
  throw CacheExceptions('no data found', 'localStorageImpl');
  }

  @override
  Future<NumbersTriviaModel> getLastNumberTriviaByDate() {
    // TODO: implement getLastNumberTriviaByDate
    throw UnimplementedError();
  }

  @override
  Future<NumbersTriviaModel> getLastNumberTriviaByYear() {
    // TODO: implement getLastNumberTriviaByYear
    throw UnimplementedError();
  }
}