import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/Core/errors/failures/failures.dart';

abstract class BaseUseCase<Type,Params>{
  Future<Either<Failures,Type>>call(Params params);
}

class Params extends Equatable{
   int? number;
   DateTime? dateTime;
   int? year;
   Params.number({required this.number});
   Params.date({required this.dateTime});
   Params.year({required this.year});
   Params.nullParams();

  @override
  List<Object?> get props => [number, year, dateTime];
}