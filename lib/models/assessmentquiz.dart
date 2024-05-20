import '../appDBFunctions.dart';

class Assessment {
  String? classTestID;
  String? courseID;
  String? subjectID;
  String? chapterName;
  String? quizName;
  String? quizSet;
  String? totalQuestions;
  String? totalMarks;
  String? level;

  Assessment(
      {this.classTestID,
      this.courseID,
      this.subjectID,
      this.chapterName,
      this.quizName,
      this.quizSet,
      this.totalQuestions,
      this.totalMarks,
      this.level});
  @override
  toString() =>
      '{classTestID: $classTestID, courseID: $courseID, subjectID: $subjectID, chapterName: $chapterName, quizName: $quizName, quizSet: $quizSet, totalQuestions: $totalQuestions, totalMarks: $totalMarks, level: $level}';

  Map<String, dynamic> toJson() => {
        'classTestID': '$classTestID',
        'courseID': '$courseID',
        'subjectID': '$subjectID',
        'chapterName': '$chapterName',
        'quizName': '$quizName',
        'quizSet': '$quizSet',
        'totalQuestions': '$totalQuestions',
        'totalMarks': '$totalMarks',
        'level': '$level'
      };

  Assessment.fromJson(Map<String, dynamic> json) {
    classTestID = json[appDBFunctions.classTestID];
    courseID = json[appDBFunctions.courseID];
    subjectID = json[appDBFunctions.subjectID];
    chapterName = json[appDBFunctions.chapterName];
    quizName = json[appDBFunctions.quizName];
    quizSet = json[appDBFunctions.quizSet];
    totalQuestions = json[appDBFunctions.totalQuestions];
    totalMarks = json[appDBFunctions.totalMarks];
    level = json[appDBFunctions.level];
  }
}
