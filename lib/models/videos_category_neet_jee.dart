import '../appDBFunctions.dart';

class VideosCategoryNEETJEE {
  String? unitName;
  List<String>? chapterNames;
  String? isExpanded;

  VideosCategoryNEETJEE({
    required this.unitName,
    required this.chapterNames,
    required this.isExpanded,
  });
  @override
  toString() =>
      '{unitName: $unitName, chapterNames: $chapterNames, isExpanded: $isExpanded}';

  Map<dynamic, dynamic> toJson() => {
        'unitName': '$unitName',
        'chapterNames': '$chapterNames',
        'isExpanded': '$isExpanded'
      };

  VideosCategoryNEETJEE.fromJson(
      Map<String, dynamic> json, List<String> json2) {
    unitName = json[appDBFunctions.unitName];
    chapterNames = json2;
    isExpanded = 'false';
  }
}
