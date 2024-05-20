import '../appDBFunctions.dart';

class Course {
  String? courseID;
  String? board;
  String? courseName;
  String? standard;
  String? stream;
  String? selected;

  Course(
      {this.courseID,
      this.board,
      this.courseName,
      this.standard,
      this.stream,
      this.selected});
  @override
  toString() =>
      '{courseID: $courseID, courseName: $courseName, standard: $standard, stream: $stream, selected: $selected}';

  Map<String, dynamic> toJson() => {
        'courseID': '$courseID',
        'courseName': '$courseName',
        'standard': '$standard',
        'stream': '$stream',
        'selected': '$selected'
      };

  Course.fromJson(Map<String, dynamic> json) {
    courseID = json[appDBFunctions.courseID];
    courseName = json[appDBFunctions.courseName];
    standard = json[appDBFunctions.standard];
    stream = json[appDBFunctions.stream];
    selected = json[appDBFunctions.selected];
  }
}
