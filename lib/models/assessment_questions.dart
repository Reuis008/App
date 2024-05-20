import '../appDBFunctions.dart';

class AssessmentQuestions {
  String? questionID;
  String? classTestID;
  String? questionNo;
  String? mark;
  String? question;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  String? answer;
  String? hint;
  String? solution;
  String? diagram;
  String? solutionType;
  String? diagramType;
  String? isExpanded;

  AssessmentQuestions(
      {this.questionID,
      this.classTestID,
      this.questionNo,
      this.mark,
      this.question,
      this.optionA,
      this.optionB,
      this.optionC,
      this.optionD,
      this.answer,
      this.hint,
      this.solution,
      this.diagram,
      this.solutionType,
      this.diagramType,
      this.isExpanded});
  @override
  toString() =>
      '{questionID: $questionID, classTestID: $classTestID, questionNo: $questionNo, mark: $mark, question: $question, optionA: $optionA, optionB: $optionB, optionC: $optionC, optionD: $optionD, answer: $answer, hint: $hint, solution: $solution, diagram: $diagram, solutionType: $solutionType, diagramType: $diagramType, isExpanded: $isExpanded}';

  Map<String, dynamic> toJson() => {
        'questionID': '$questionID',
        'classTestID': '$classTestID',
        'questionNo': '$questionNo',
        'mark': '$mark',
        'question': '$question',
        'optionA': '$optionA',
        'optionB': '$optionB',
        'optionC': '$optionC',
        'optionD': '$optionD',
        'answer': '$answer',
        'hint': '$hint',
        'solution': '$solution',
        'diagram': '$diagram',
        'solutionType': '$solutionType',
        'diagramType': '$diagramType',
        'isExpanded': '$isExpanded'
      };

  AssessmentQuestions.fromJson(Map<String, dynamic> json) {
    questionID = json[appDBFunctions.questionID];
    questionNo = json[appDBFunctions.questionNo];
    classTestID = json[appDBFunctions.classTestID];
    mark = json[appDBFunctions.mark];
    question = json[appDBFunctions.question];
    optionA = json[appDBFunctions.optionA];
    optionB = json[appDBFunctions.optionB];
    optionC = json[appDBFunctions.optionC];
    optionD = json[appDBFunctions.optionD];
    answer = json[appDBFunctions.answer];
    hint = json[appDBFunctions.hint];
    solution = json[appDBFunctions.solution];
    diagram = json[appDBFunctions.diagram];
    solutionType = json[appDBFunctions.solutionType];
    diagramType = json[appDBFunctions.diagramType];
    isExpanded = 'false';
  }
}
