import 'package:untitled/Features/number_trivia/domain/entities/number_trivia_entity.dart';

class NumbersTriviaModel extends NumbersTrivia {
  const NumbersTriviaModel(
      {required super.text,
      required super.number,
      required super.type,
      required super.found});

  factory NumbersTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumbersTriviaModel(
        type: json['type'],
        text: json['text'],
        number: (json['number'] as num).toInt(),
        found: json['found']);
  }

  static toJson(NumbersTriviaModel model) {
    return {
      'number': model.number,
      'text': model.text,
      'type': model.type,
      'found': model.found
    };
  }
}
