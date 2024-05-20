import '../appDBFunctions.dart';

class ReferenceBooks {
  String? ID;
  String? category;
  String? courseID;
  String? subjectName;
  String? documentName;
  String? documentPath;

  ReferenceBooks({
    this.ID,
    this.category,
    this.courseID,
    this.subjectName,
    this.documentName,
    this.documentPath,
  });
  @override
  toString() =>
      '{ID: $ID, category: $category, courseID: $courseID, subjectName: $subjectName, documentName: $documentName, documentPath: $documentPath}';

  Map<String, dynamic> toJson() => {
        'ID': '$ID',
        'category': '$category',
        'courseID': '$courseID',
        'subjectName': '$subjectName',
        'documentName': '$documentName',
        'documentPath': '$documentPath'
      };

  ReferenceBooks.fromJson(Map<String, dynamic> json) {
    ID = json[appDBFunctions.ID];
    category = json[appDBFunctions.category];
    courseID = json[appDBFunctions.courseID];
    subjectName = json[appDBFunctions.subjectName];
    documentName = json[appDBFunctions.documentName];
    documentPath = json[appDBFunctions.documentPath];
  }
}
