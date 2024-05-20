import '../appDBFunctions.dart';

class QuestionBankNEETJEE {
  String? ID;
  String? category;
  String? courseID;
  String? subjectName;
  String? chapterName;
  String? documentName;
  String? documentPath;

  QuestionBankNEETJEE({
    this.ID,
    this.category,
    this.courseID,
    this.subjectName,
    this.chapterName,
    this.documentName,
    this.documentPath,
  });

  @override
  toString() =>
      '{ID: $ID, category: $category, courseID: $courseID, subjectName: $subjectName, chapterName: $chapterName, documentName: $documentName, documentPath: $documentPath}';
  Map<String, dynamic> toJson() => {
        'ID': '$ID',
        'category': '$category',
        'courseID': '$courseID',
        'subjectName': '$subjectName',
        'chapterName': '$chapterName',
        'documentName': '$documentName',
        'documentPath': '$documentPath'
      };

  QuestionBankNEETJEE.fromJson(Map<String, dynamic> json) {
    ID = json[appDBFunctions.ID];
    category = json[appDBFunctions.category];
    courseID = json[appDBFunctions.courseID];
    subjectName = json[appDBFunctions.subjectName];
    chapterName = json[appDBFunctions.chapterName];
    documentName = json[appDBFunctions.documentName];
    documentPath = json[appDBFunctions.documentPath];
  }
}
