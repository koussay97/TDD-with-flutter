import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:untitled/Core/utils/networking/network_info.dart';

import 'mocks/mocks_generator.mocks.dart';

void main() {

  late MockInternetConnectionChecker internetConnectionChecker;
  late NetworkInfoImpl networkInfoImpl;
  setUp(() {
    internetConnectionChecker = MockInternetConnectionChecker();

    networkInfoImpl =
        NetworkInfoImpl(internetConnectionChecker: internetConnectionChecker);
  });

  group('testing network info class', () {
    test('should forwarded to getter', () async {

      // arrange

      final tHasConnectionFuture= Future.value(true);
      // referential equality
      when(internetConnectionChecker.hasConnection)
          .thenAnswer((realInvocation)  => tHasConnectionFuture);

      // act
      final result = networkInfoImpl.isConnected;

      // assert
      verify(internetConnectionChecker.hasConnection);
      // referential equality
      //::: comparing the result with the same instance of the arranged instance
      expect(result, tHasConnectionFuture);
    });
  });
}
