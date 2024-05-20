class ExampreparatoryAnswers {
  String? questionID;
  String? questionNo;
  String? question;
  String? submittedAnswer;
  String? submittedAnswerImg;
  String? correctAnswer;
  String? solutionImg;
  String? explanation;
  String? result;

  @override
  toString() =>
      '{questionID: $questionID, questionNo: $questionNo, question: $question, submittedAnswer: $submittedAnswer, submittedAnswerImg: $submittedAnswerImg, correctAnswer: $correctAnswer, solutionImg: $solutionImg, explanation: $explanation, result: $result}';
  Map<String, dynamic> toJson() => {
        'questionID': '$questionID',
        'questionNo': '$questionNo',
        'question': '$question',
        'submittedAnswer': '$submittedAnswer',
        'submittedAnswerImg': '$submittedAnswerImg',
        'correctAnswer': '$correctAnswer',
        'solutionImg': '$solutionImg',
        'explanation': '$explanation',
        'result': '$result'
      };
  ExampreparatoryAnswers(
      {this.questionID,
      this.questionNo,
      this.question,
      this.submittedAnswer,
      this.submittedAnswerImg,
      this.correctAnswer,
      this.solutionImg,
      this.explanation,
      this.result});
}
