import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lms_v_2_0_0/ui/tools_widgets/dictionary/response_model.dart';

class API {
  static Future<ResponseModel> fetchMeaning(String word) async {
    // Determine the first letter of the word to identify the correct JSON file
    String firstLetter = word.toLowerCase()[0];
    String myWord = word.toLowerCase();
    String fileName =
        "$firstLetter.json"; // Construct the file name based on the first letter

    // Load the JSON file from the assets
    final String fileContents =
        await rootBundle.loadString('assets/json/$fileName');
    final data = json.decode(fileContents);
    // Check if the word exists as a key in the data

    if (data.containsKey(myWord)) {
      return ResponseModel.fromJson(data[myWord]);
    } else {
      // If the word is not found, handle the case accordingly
      // For example, throw an exception or return a default ResponseModel
      throw Exception('Word not found in the data');
    }
    // return ResponseModel.fromJson(data[word]);
  }
}
