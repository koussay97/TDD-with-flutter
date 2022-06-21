import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable{
  final List properties = const <dynamic>[];
const Failures({required properties});
@override
List<Object?> get props => [
  properties
];
}
class ServerFailures extends Failures implements Equatable{

  const ServerFailures({required super.properties});

}
class CacheFailures extends Failures implements Equatable{

  const CacheFailures({required super.properties});

}