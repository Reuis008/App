import '../appDBFunctions.dart';

class Chapter {
  String? courseID;
  String? subjectID;
  String? unitNo;
  String? unitName;
  String? chapterNo;
  String? chapterName;
  String? chapterVideos;

  Chapter(
      {this.courseID,
      this.subjectID,
      this.unitNo,
      this.unitName,
      this.chapterNo,
      this.chapterName,
      this.chapterVideos});
  @override
  toString() =>
      '{courseID: $courseID, subjectID: $subjectID, unitNo: $unitNo, unitName: $unitName, chapterNo: $chapterNo, chapterName: $chapterName, chapterVideos: $chapterVideos}';

  Map<String, dynamic> toJson() => {
        'courseID': '$courseID',
        'subjectID': '$subjectID',
        'unitNo': '$unitNo',
        'unitName': '$unitName',
        'chapterNo': '$chapterNo',
        'chapterName': '$chapterName',
        'chapterVideos': '$chapterVideos'
      };

  Chapter.fromJson(Map<String, dynamic> json) {
    courseID = json[appDBFunctions.courseID];
    subjectID = json[appDBFunctions.subjectID];
    unitNo = json[appDBFunctions.unitNo];
    unitName = json[appDBFunctions.unitName];
    chapterNo = json[appDBFunctions.chapterNo];
    chapterName = json[appDBFunctions.chapterName];
    chapterVideos = json[appDBFunctions.chapterVideos];
  }
}
