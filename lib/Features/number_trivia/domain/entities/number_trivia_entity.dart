import 'package:equatable/equatable.dart';

class NumbersTrivia extends Equatable{
  final String text;
  final int number;
  final String type;
  final bool found;

  const NumbersTrivia({required this.text, required this.number,required this.type,required this.found});

  @override
  List<Object?> get props => [
    text,
    number,
    type
  ];
}











/*
* {
 "text": "42 is the answer to the Ultimate Question of Life, the Universe, and Everything.",
 "number": 42,
 "found": true,
 "type": "trivia"
}
*
* */
