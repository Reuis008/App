import '../appDBFunctions.dart';

class Unit {
  String? courseID;
  String? subjectID;
  String? unitNo;
  String? unitName;

  Unit({
    this.courseID,
    this.subjectID,
    this.unitNo,
    this.unitName,
  });
  @override
  toString() =>
      '{courseID: $courseID, subjectID: $subjectID, unitNo: $unitNo, unitName: $unitName}';

  Map<String, dynamic> toJson() => {
        'courseID': '$courseID',
        'subjectID': '$subjectID',
        'unitNo': '$unitNo',
        'unitName': '$unitName'
      };

  Unit.fromJson(Map<String, dynamic> json) {
    courseID = json[appDBFunctions.courseID];
    subjectID = json[appDBFunctions.subjectID];
    unitNo = json[appDBFunctions.chapterNo];
    unitName = json[appDBFunctions.chapterName];
  }
}
