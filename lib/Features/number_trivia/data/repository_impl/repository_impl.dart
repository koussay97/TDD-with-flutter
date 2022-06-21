import 'package:dartz/dartz.dart';
import 'package:untitled/Core/errors/failures/exceptions.dart';
import 'package:untitled/Core/errors/failures/failures.dart';
import 'package:untitled/Core/utils/networking/network_info.dart';
import 'package:untitled/Features/number_trivia/data/data_source/local/number_trivia_local_data_source.dart';
import 'package:untitled/Features/number_trivia/data/data_source/remote/number_trivia_remote_data_source.dart';
import 'package:untitled/Features/number_trivia/data/models/number_trivia_model.dart';
import 'package:untitled/Features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:untitled/Features/number_trivia/domain/repository/numbers_trivia_repository.dart';

typedef TriviaHigherOrder = Future<NumbersTrivia> Function();

class NumberTriviaRepositoryImplementation implements NumbersTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImplementation(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failures, NumbersTrivia>> getConcreteNumberTrivia(
      int number) async {
    return _getTrivia(
        () async => await remoteDataSource.getConcreteNumberTrivia(number),
        KeyStorage.numberKey);
  }

  @override
  Future<Either<Failures, NumbersTrivia>> getConcreteNumberTriviaByDate(
      DateTime date) {
    return _getTrivia(
        () async => await remoteDataSource.getConcreteNumberTriviaByDate(date),
        KeyStorage.dateKey);
  }

  @override
  Future<Either<Failures, NumbersTrivia>> getConcreteNumberTriviaByYear(
      int year) {
    return _getTrivia(
        () async => await remoteDataSource.getConcreteNumberTriviaByYear(year),
        KeyStorage.yearKey);
  }

  @override
  Future<Either<Failures, NumbersTrivia>> getRandomNumberTrivia() {
    return _getTrivia(
        () async => await remoteDataSource.getRandomNumberTrivia(),
        KeyStorage.numberKey);
  }

  @override
  Future<Either<Failures, NumbersTrivia>> getRandomNumberTriviaDate() {
    return _getTrivia(
        () async => await remoteDataSource.getRandomNumberTriviaDate(),
        KeyStorage.dateKey);
  }

  @override
  Future<Either<Failures, NumbersTrivia>> getRandomNumberTriviaYear() {
    return _getTrivia(
        () async => await remoteDataSource.getRandomNumberTriviaYear(),
        KeyStorage.yearKey);
  }

  Future<Either<Failures, NumbersTrivia>> _getTrivia(
      TriviaHigherOrder function, KeyStorage key) async {
    bool connection = await networkInfo.isConnected;
    if (connection) {
      try {
        final result = await function();
        if(!KeyStorage.values.contains(key)){
          throw CacheExceptions('wrong Key', 'stackTrace');
        }
        localDataSource.cacheNumberTrivia(key, result as NumbersTriviaModel);
        return Right(result);
      } on ServerExceptions {
        return await Future.value(const Left(ServerFailures(properties: [])));
      } on CacheExceptions {
        return await Future.value(const Left(CacheFailures(properties: [])));
      }
    }
    try {
      switch(key){
        case KeyStorage.numberKey:{
          return Right(await localDataSource.getLastNumberTrivia());
        }
        case KeyStorage.dateKey:{
          return Right(await localDataSource.getLastNumberTriviaByDate());
        }
        case KeyStorage.yearKey:{
          return Right(await localDataSource.getLastNumberTriviaByYear());
        }
        default :{throw CacheExceptions('no data', 'stackTrace');}
      }
    } on CacheExceptions {
      return await Future.value(const Left(CacheFailures(properties: [])));
    }
  }
}
