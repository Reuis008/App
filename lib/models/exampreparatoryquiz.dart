import '../appDBFunctions.dart';

class Exampreparatory {
  String? exampreparatoryID;
  String? courseID;
  String? subjectID;
  String? subjectName;
  String? examType;
  String? quizName;
  String? quizSet;
  String? totalQuestions;
  String? totalMarks;
  String? level;
  String? timeLength;

  Exampreparatory(
      {this.exampreparatoryID,
      this.courseID,
      this.subjectID,
      this.subjectName,
      this.examType,
      this.quizName,
      this.quizSet,
      this.totalQuestions,
      this.totalMarks,
      this.level,
      this.timeLength});
  @override
  toString() =>
      '{exampreparatoryID: $exampreparatoryID, courseID: $courseID, subjectID: $subjectID, subjectName: $subjectName, examType: $examType, quizName: $quizName, quizSet: $quizSet, totalQuestions: $totalQuestions, totalMarks: $totalMarks, level: $level, timeLength: $timeLength}';

  Map<String, dynamic> toJson() => {
        'courseID': '$courseID',
        'subjectID': '$subjectID',
        'subjectName': '$subjectName',
        'examType': '$examType',
        'quizName': '$quizName',
        'quizSet': '$quizSet',
        'totalQuestions': '$totalQuestions',
        'totalMarks': '$totalMarks',
        'level': '$level',
        'timeLength': '$timeLength'
      };

  Exampreparatory.fromJson(Map<String, dynamic> json) {
    exampreparatoryID = json[appDBFunctions.exampreparatoryID];
    courseID = json[appDBFunctions.courseID];
    subjectID = json[appDBFunctions.subjectID];
    subjectName = json[appDBFunctions.subjectName];
    examType = json[appDBFunctions.examType];
    quizName = json[appDBFunctions.quizName];
    quizSet = json[appDBFunctions.quizSet];
    totalQuestions = json[appDBFunctions.totalQuestions];
    totalMarks = json[appDBFunctions.totalMarks];
    level = json[appDBFunctions.level];
    timeLength = json[appDBFunctions.timeLength];
  }
}
