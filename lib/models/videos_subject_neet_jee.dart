import '../appDBFunctions.dart';
import 'videos_category_neet_jee.dart';

class VideosSubjectNEETJEE {
  String? subjectName;
  List<VideosCategoryNEETJEE>? unitNames;

  VideosSubjectNEETJEE({
    required this.subjectName,
    required this.unitNames,
  });
  @override
  toString() => '{subjectName: $subjectName, unitNames: $unitNames}';
  Map<dynamic, dynamic> toJson() =>
      {'subjectName': '$subjectName', 'unitNames': '$unitNames'};

  VideosSubjectNEETJEE.fromJson(
      Map<String, dynamic> json, List<VideosCategoryNEETJEE> json2) {
    subjectName = json[appDBFunctions.subjectName];
    unitNames = json2;
  }
}
