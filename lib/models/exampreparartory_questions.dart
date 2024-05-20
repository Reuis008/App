import '../appDBFunctions.dart';

class ExampreparatoryQuestions {
  String? questionID;
  String? exampreparatoryID;
  String? questionNo;
  String? mark;
  String? question;
  String? optionA;
  String? optionAType;
  String? optionAImg;
  String? optionB;
  String? optionBType;
  String? optionBImg;
  String? optionC;
  String? optionCType;
  String? optionCImg;
  String? optionD;
  String? optionDType;
  String? optionDImg;
  String? answer;
  String? hint;
  String? solution;
  String? diagram;
  String? solutionType;
  String? diagramType;
  String? isExpanded;

  ExampreparatoryQuestions(
      {this.questionID,
      this.exampreparatoryID,
      this.questionNo,
      this.mark,
      this.question,
      this.optionA,
      this.optionAType,
      this.optionAImg,
      this.optionB,
      this.optionBType,
      this.optionBImg,
      this.optionC,
      this.optionCType,
      this.optionCImg,
      this.optionD,
      this.optionDType,
      this.optionDImg,
      this.answer,
      this.hint,
      this.solution,
      this.diagram,
      this.solutionType,
      this.diagramType,
      this.isExpanded});
  @override
  toString() =>
      '{questionID: $questionID, exampreparatoryID: $exampreparatoryID, questionNo: $questionNo, mark: $mark, question: $question, optionA: $optionA, optionAType: $optionAType, optionAImg: $optionAImg, optionB: $optionB, optionBType: $optionBType, optionBImg: $optionBImg, optionC: $optionC, optionCType: $optionCType, optionCImg: $optionCImg, optionD: $optionD, optionDType: $optionDType, optionDImg: $optionDImg, answer: $answer, hint: $hint, solution: $solution, diagram: $diagram, solutionType: $solutionType, diagramType: $diagramType, isExpanded: $isExpanded}';

  Map<String, dynamic> toJson() => {
        'questionID': '$questionID',
        'exampreparatoryID': '$exampreparatoryID',
        'questionNo': '$questionNo',
        'mark': '$mark',
        'question': '$question',
        'optionA': '$optionA',
        'optionAType': '$optionAType',
        'optionAImg': '$optionAImg',
        'optionB': '$optionB',
        'optionBType': '$optionBType',
        'optionBImg': '$optionBImg',
        'optionC': '$optionC',
        'optionCType': '$optionCType',
        'optionCImg': '$optionCImg',
        'optionD': '$optionD',
        'optionDType': '$optionDType',
        'optionDImg': '$optionDImg',
        'answer': '$answer',
        'hint': '$hint',
        'solution': '$solution',
        'diagram': '$diagram',
        'solutionType': '$solutionType',
        'diagramType': '$diagramType',
        'isExpanded': '$isExpanded'
      };

  ExampreparatoryQuestions.fromJson(Map<String, dynamic> json) {
    questionID = json[appDBFunctions.questionID];
    exampreparatoryID = json[appDBFunctions.exampreparatoryID];
    questionNo = json[appDBFunctions.questionNo];
    mark = json[appDBFunctions.mark];
    question = json[appDBFunctions.question];
    optionA = json[appDBFunctions.optionA];
    optionAType = json[appDBFunctions.optionAType];
    optionAImg = json[appDBFunctions.optionAImg];
    optionB = json[appDBFunctions.optionB];
    optionBType = json[appDBFunctions.optionBType];
    optionBImg = json[appDBFunctions.optionBImg];
    optionC = json[appDBFunctions.optionC];
    optionCType = json[appDBFunctions.optionCType];
    optionCImg = json[appDBFunctions.optionCImg];
    optionD = json[appDBFunctions.optionD];
    optionDType = json[appDBFunctions.optionDType];
    optionDImg = json[appDBFunctions.optionDImg];
    answer = json[appDBFunctions.answer];
    hint = json[appDBFunctions.hint];
    solution = json[appDBFunctions.solution];
    diagram = json[appDBFunctions.diagram];
    solutionType = json[appDBFunctions.solutionType];
    diagramType = json[appDBFunctions.diagramType];
    isExpanded = 'false';
  }
}
