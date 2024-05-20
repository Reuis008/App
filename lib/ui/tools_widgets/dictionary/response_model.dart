class ResponseModel {
  final String word;
  final String wordsetId;
  final List<Meanings> meanings;

  ResponseModel({
    required this.word,
    required this.wordsetId,
    required this.meanings,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      word: json['word'],
      wordsetId: json['wordset_id'],
      meanings: json['meanings'] != null
          ? (json['meanings'] as List).map((e) => Meanings.fromJson(e)).toList()
          : [],
    );
  }
}

class Meanings {
  final String id;
  final String def;
  final String? example;
  final String speechPart;
  final List<String>? synonyms;

  Meanings({
    required this.id,
    required this.def,
    required this.example,
    required this.speechPart,
    required this.synonyms,
  });

  factory Meanings.fromJson(Map<String, dynamic> json) {
    return Meanings(
      id: json['id'],
      def: json['def'],
      example: json['example'] ?? 'No example provided',
      speechPart: json['speech_part'],
      synonyms: json['synonyms'] != null
          ? List<String>.from(json['synonyms'])
          : ['No synonyms provided'],
    );
  }
}
