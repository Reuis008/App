import '../appDBFunctions.dart';

class VideosNEETJEE {
  String? topicName;
  String? path;
  String? metaData;

  VideosNEETJEE({
    required this.topicName,
    required this.path,
    required this.metaData,
  });
  @override
  toString() => '{topicName: $topicName, path: $path, metaData: $metaData}';

  Map<String, dynamic> toJson() =>
      {'topicName': '$topicName', 'path': '$path', 'metaData': '$metaData'};

  VideosNEETJEE.fromJson(Map<String, dynamic> json) {
    topicName = json[appDBFunctions.topicName];
    path = json[appDBFunctions.path];
    metaData = json[appDBFunctions.metaData];
  }
}
