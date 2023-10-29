import 'dart:convert';

import 'package:dojonotes/configurations/app_secrets.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  Future<String> generateSchedule({kataList, numberOfKatas, days}) async {
    try {
      final response = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-type': 'application/json',
            'Authorization': 'Bearer $openAIAPIKey'
          },
          body: jsonEncode({
            'model': 'gpt-3.5-turbo',
            'messages': [
              {
                'role': 'user',
                'content':
                    'I know the following Shotokan Karate katas $kataList. I would like to practice at least $numberOfKatas katas in a day on the following days $days for the coming month starting the day that comes first from today basing on the list of days provided. Generate for me an appropriate schedule'
              }
            ]
          }));
      print(jsonDecode(response.body));
      return 'NICE';
    } catch (e) {
      return e.toString();
    }
  }
}
