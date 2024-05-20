import '../appDBFunctions.dart';

class Subject {
  String? subjectID;
  String? courseID;
  String? subjectName;
  String? totalChapters;
  String? totalContents;
  String? totalVideos;
  String? totalBooks;

  Subject({
    this.subjectID,
    this.courseID,
    this.subjectName,
    this.totalChapters,
    this.totalContents,
    this.totalVideos,
    this.totalBooks,
  });
  @override
  toString() =>
      '{subjectID: $subjectID, courseID: $courseID, subjectName: $subjectName, totalChapters: $totalChapters, totalContents: $totalContents, totalVideos: $totalVideos, totalBooks: $totalBooks}';

  Map<String, dynamic> toJson() => {
        'subjectID': '$subjectID',
        'courseID': '$courseID',
        'subjectName': '$subjectName',
        'totalChapters': '$totalChapters',
        'totalContents': '$totalContents',
        'totalVideos': '$totalVideos',
        'totalBooks': '$totalBooks'
      };

  Subject.fromJson(Map<String, dynamic> json) {
    subjectID = json[appDBFunctions.subjectID];
    courseID = json[appDBFunctions.courseID];
    subjectName = json[appDBFunctions.subjectName];
    totalChapters = json[appDBFunctions.totalChapters];
    totalContents = json[appDBFunctions.totalContents];
    totalVideos = json[appDBFunctions.totalVideos];
    totalBooks = json[appDBFunctions.totalBooks];
  }
}
