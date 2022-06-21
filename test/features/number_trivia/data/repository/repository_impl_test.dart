import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:untitled/Core/errors/failures/exceptions.dart';
import 'package:untitled/Core/errors/failures/failures.dart';
import 'package:untitled/Features/number_trivia/data/data_source/local/number_trivia_local_data_source.dart';

import 'package:untitled/Features/number_trivia/data/models/number_trivia_model.dart';
import 'package:untitled/Features/number_trivia/data/repository_impl/repository_impl.dart';
import 'package:untitled/Features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'repository_impl_test_helpers.dart';
import '../../../../core/mocks/mocks_generator.mocks.dart';

void main() {
  late NumberTriviaRepositoryImplementation repository;
  late MockNumberTriviaRemoteDataSource remoteDataSource;
  late MockNumberTriviaLocalDataSource localDataSource;
  late MockNetworkInfo networkInfo;
  late int tNumber;
  late DateTime tDate;
  late NumbersTriviaModel tNumberTriviaModel;

  setUp(() {
    tDate=DateTime(2022,12,10);
    tNumber = 1;
    remoteDataSource = MockNumberTriviaRemoteDataSource();
    localDataSource = MockNumberTriviaLocalDataSource();
    networkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImplementation(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: networkInfo,
    );
    tNumberTriviaModel = NumbersTriviaModel(
        found: true, number: tNumber, text: 'testModel', type: 'testConcrete');
  });

  group('testing repository Impl', () {

    test('should check if network connection is called', () async {
      // arrange
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
      when(remoteDataSource.getConcreteNumberTrivia(tNumber))
          .thenAnswer((realInvocation) async => tNumberTriviaModel);

      // act
      repository.getConcreteNumberTrivia(tNumber);
      // assert
      verify(networkInfo.isConnected);
    });

    // refactored tests

    group('case device onLine', () {
      setUp(() {
        when(networkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });

      test(
          '${1.1}- when called remote data source with get concrete number success should return remote NumberTrivia object',
          () async {
        // arrange
        when(remoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenAnswer((realInvocation) async => tNumberTriviaModel);


        // act
        final result = await repository.getConcreteNumberTrivia(tNumber);

        // assert
        verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
        expect(result, Right(tNumberTriviaModel));
        expect(result.isRight(),true);
        expect(tNumberTriviaModel, isA<NumbersTrivia>());
        });

      test('${1.2}- when called remote data source with get concrete number success should cache the data locally ', () async {
        // arrange
        when(remoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenAnswer((realInvocation) async => tNumberTriviaModel);


        // act
        final result = await repository.getConcreteNumberTrivia(tNumber);

        // assert
        verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(localDataSource.cacheNumberTrivia(KeyStorage.numberKey,tNumberTriviaModel));
      });

      test('${1.3}- when calling remoteDataSource fails! should return a failure object', () async {

        // arrange
        when(remoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenThrow(ServerExceptions());

        // act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        // assert

        verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
        verifyZeroInteractions(localDataSource);
        expect(result,  Left(ServerFailures(properties: [])));
        expect(result.isLeft(),true);
      });

      /// numberTrivia by year
      test(
          '${1.4}- when called remote data source with get concrete number by date success should return remote NumberTrivia object',
              () async {
            // arrange
            when(remoteDataSource.getConcreteNumberTriviaByDate(tDate))
                .thenAnswer((realInvocation) async => tNumberTriviaModel);


            // act
            final result = await repository.getConcreteNumberTriviaByDate(tDate);

            // assert
            verify(remoteDataSource.getConcreteNumberTriviaByDate(tDate));
            expect(result, Right(tNumberTriviaModel));
            expect(result.isRight(),true);
            expect(tNumberTriviaModel, isA<NumbersTrivia>());
          });

      test('${1.5}- when called remote data source with get concrete date success should cache the data locally ', () async {
        // arrange
        when(remoteDataSource.getConcreteNumberTriviaByDate(tDate))
            .thenAnswer((realInvocation) async => tNumberTriviaModel);


        // act
        final result = await repository.getConcreteNumberTriviaByDate(tDate);

        // assert
        verify(remoteDataSource.getConcreteNumberTriviaByDate(tDate));
        verify(localDataSource.cacheNumberTrivia( KeyStorage.dateKey,tNumberTriviaModel));
      });

      test('${1.6}- when calling remoteDataSource fails! should return a failure object', () async {

        // arrange
        when(remoteDataSource.getConcreteNumberTriviaByDate(tDate))
            .thenThrow(ServerExceptions());

        // act
        final result = await repository.getConcreteNumberTriviaByDate(tDate);
        // assert

        verify(remoteDataSource.getConcreteNumberTriviaByDate(tDate));
        verifyZeroInteractions(localDataSource);
        expect(result,  Left(ServerFailures(properties: [])));
        expect(result.isLeft(),true);
      });

      test(
          '${1.7}- should return cache failure when supplied an unregistered key',
              () async {
                // arrange
                when(remoteDataSource.getConcreteNumberTriviaByDate(tDate))
                    .thenThrow(CacheExceptions('wrong key', 'stackTrace'));

                // act
                final result = await repository.getConcreteNumberTriviaByDate(tDate);
                // assert

                verify(remoteDataSource.getConcreteNumberTriviaByDate(tDate));
                verifyZeroInteractions(localDataSource);
                expect(result,  Left(CacheFailures(properties: [])));
                expect(result.isLeft(),true);
          });
    });


    group('case device offLine', () {
      setUp(() {
        when(networkInfo.isConnected)
            .thenAnswer((realInvocation) async => false);
      });
      test(
          '${2.1}- when called remote data source with get concrete number offline should return last cached number trivia',
              () async {
            // arrange
            when(localDataSource.getLastNumberTrivia())
                .thenAnswer((realInvocation) async => tNumberTriviaModel);

            // act
            final result = await repository.getConcreteNumberTrivia(tNumber);

            // assert
            verify(localDataSource.getLastNumberTrivia());
            verifyZeroInteractions(remoteDataSource);
            expect(result, Right(tNumberTriviaModel));
            expect(result.isRight(),true);
            expect(tNumberTriviaModel, isA<NumbersTrivia>());
          });

      test(
          '${2.2}- when called remote data source with get concrete number offline and no cached data is present return cache Exception',
              () async {
            // arrange
            when(localDataSource.getLastNumberTrivia())
                .thenThrow(CacheExceptions('message', 'stackTrace'));

            // act
            final result = await repository.getConcreteNumberTrivia(tNumber);

            // assert
            verifyZeroInteractions(remoteDataSource);
            verify(localDataSource.getLastNumberTrivia());
            expect(result, left(CacheFailures(properties: [])));
            expect(result.isLeft(),true);
          });
      /// testing date
      test(
          '${2.3}- when called remote data source with get concrete date offline should return last cached number trivia',
              () async {
            // arrange
            when(localDataSource.getLastNumberTriviaByDate())
                .thenAnswer((realInvocation) async => tNumberTriviaModel);

            // act
            final result = await repository.getConcreteNumberTriviaByDate(tDate);

            // assert
            verify(localDataSource.getLastNumberTriviaByDate());
            verifyZeroInteractions(remoteDataSource);
            expect(result, Right(tNumberTriviaModel));
            expect(result.isRight(),true);
            expect(tNumberTriviaModel, isA<NumbersTrivia>());
          });

      test(
          '${2.4}- when called remote data source with get concrete date offline and no cached data is present return cache Exception',
              () async {
            // arrange
            when(localDataSource.getLastNumberTriviaByDate())
                .thenThrow(CacheExceptions('message', 'stackTrace'));

            // act
            final result = await repository.getConcreteNumberTriviaByDate(tDate);

            // assert
            verifyZeroInteractions(remoteDataSource);
            verify(localDataSource.getLastNumberTriviaByDate());
            expect(result, left(CacheFailures(properties: [])));
            expect(result.isLeft(),true);
          });

    });
  });
}
