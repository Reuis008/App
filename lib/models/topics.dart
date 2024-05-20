import '../appDBFunctions.dart';

class Topic {
  String? topicID;
  String? courseID;
  String? subjectID;
  String? subjectName;
  String? unitNo;
  String? chapterNo;
  String? chapterName;
  String? topicNo;
  String? topicName;
  String? type;
  String? path;
  String? metaData;

  Topic({
    this.topicID,
    this.courseID,
    this.subjectID,
    this.subjectName,
    this.unitNo,
    this.chapterNo,
    this.chapterName,
    this.topicNo,
    this.topicName,
    this.type,
    this.path,
    this.metaData,
  });

  @override
  toString() =>
      '{topicID: $topicID, courseID: $courseID, subjectID: $subjectID, subjectName: $subjectName, unitNo: $unitNo, chapterNo: $chapterNo, chapterName: $chapterName, topicNo: $topicNo, topicName: $topicName, type: $type, path: $path, metaData: $metaData}';

  Map<String, dynamic> toJson() => {
        'topicID': '$topicID',
        'courseID': '$courseID',
        'subjectID': '$subjectID',
        'subjectName': '$subjectName',
        'unitNo': '$unitNo',
        'chapterNo': '$chapterNo',
        'chapterName': '$chapterName',
        'topicNo': '$topicNo',
        'topicName': '$topicName',
        'type': '$type',
        'path': '$path',
        'metaData': '$metaData'
      };

  Topic.fromJson(Map<String, dynamic> json) {
    topicID = json[appDBFunctions.topicID];
    courseID = json[appDBFunctions.courseID];
    subjectID = json[appDBFunctions.subjectID];
    subjectName = json[appDBFunctions.subjectName];
    unitNo = json[appDBFunctions.unitNo];
    chapterNo = json[appDBFunctions.chapterNo];
    chapterName = json[appDBFunctions.chapterName];
    topicNo = json[appDBFunctions.topicNo];
    topicName = json[appDBFunctions.topicName];
    type = json[appDBFunctions.type];
    path = json[appDBFunctions.path];
    metaData = json[appDBFunctions.metaData];
  }
}
