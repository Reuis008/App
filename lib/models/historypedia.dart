import '../appDBFunctions.dart';

class SearchHistorypedia {
  String? date;
  String? description;

  SearchHistorypedia({
    required this.date,
    required this.description,
  });
  @override
  toString() => '{date: $date, description: $description, ';

  Map<String, dynamic> toJson() => {
        'date': '$date',
        'description': '$description',
      };

  SearchHistorypedia.fromJson(Map<String, dynamic> json) {
    date = json[appDBFunctions.date];
    description = json[appDBFunctions.description];
  }
}
