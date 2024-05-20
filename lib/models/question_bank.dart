import '../appDBFunctions.dart';

class QuestionBank {
  String? ID;
  String? category;
  String? year;
  String? courseID;
  String? subjectName;
  String? documentName;
  String? documentPath;

  QuestionBank({
    this.ID,
    this.category,
    this.year,
    this.courseID,
    this.documentName,
    this.documentPath,
  });
  @override
  toString() =>
      '{ID: $ID, category: $category, year: $year, courseID: $courseID, documentName: $documentName, documentPath: $documentPath}';

  Map<String, dynamic> toJson() => {
        'ID': '$ID',
        'category': '$category',
        'year': '$year',
        'courseID': '$courseID',
        'documentName': '$documentName',
        'documentPath': '$documentPath'
      };

  QuestionBank.fromJson(Map<String, dynamic> json) {
    ID = json[appDBFunctions.ID];
    category = json[appDBFunctions.category];
    year = json[appDBFunctions.year];
    courseID = json[appDBFunctions.courseID];
    documentName = json[appDBFunctions.documentName];
    documentPath = json[appDBFunctions.documentPath];
  }
}
