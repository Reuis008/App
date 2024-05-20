import '../appDBFunctions.dart';

class StudyMaterialsNeetJee {
  String? ID;
  String? category;
  String? subjectName;
  String? documentName;
  String? documentPath;

  StudyMaterialsNeetJee({
    required this.ID,
    required this.category,
    required this.subjectName,
    required this.documentName,
    required this.documentPath,
  });
  @override
  toString() =>
      '{ID: $ID, category: $category, subjectName: $subjectName, documentName: $documentName, documentPath: $documentPath}';

  Map<String, dynamic> toJson() => {
        'ID': '$ID',
        'category': '$category',
        'subjectName': '$subjectName',
        'documentName': '$documentName',
        'documentPath': '$documentPath'
      };

  StudyMaterialsNeetJee.fromJson(Map<String, dynamic> json) {
    ID = json[appDBFunctions.ID];
    category = json[appDBFunctions.category];
    subjectName = json[appDBFunctions.subjectName];
    documentName = json[appDBFunctions.documentName];
    documentPath = json[appDBFunctions.documentPath];
  }
}
