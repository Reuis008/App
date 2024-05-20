import '../appDBFunctions.dart';

class QuizTrivia {
  String? ID;
  String? questionNo;
  String? category;
  String? question;
  String? correctAnswer;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;

  QuizTrivia({
    required this.ID,
    required this.questionNo,
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
  });
  @override
  toString() =>
      '{ID: $ID, questionNo: $questionNo, category: $category, question: $question, correctAnswer: $correctAnswer, optionA: $optionA, optionB: $optionB, optionC: $optionC, optionD: $optionD}';

  Map<dynamic, dynamic> toJson() => {
        ID: ID,
        questionNo: questionNo,
        category: category,
        question: question,
        correctAnswer: correctAnswer,
        optionA: optionA,
        optionB: optionB,
        optionC: optionC,
        optionD: optionD
      };
  QuizTrivia.fromJson(Map<String, dynamic> json, String rowNum) {
    ID = json[appDBFunctions.ID];
    questionNo = rowNum;
    category = json[appDBFunctions.category];
    question = json[appDBFunctions.question];
    correctAnswer = json[appDBFunctions.correctAnswer];
    optionA = json[appDBFunctions.optionA];
    optionB = json[appDBFunctions.optionB];
    optionC = json[appDBFunctions.optionC];
    optionD = json[appDBFunctions.optionD];
  }
}
