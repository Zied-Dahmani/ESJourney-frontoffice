import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../utils/constants.dart';

String MEETING_API_URL = '$kmeetingUrl/meeting';

var client = http.Client();

Future<http.Response> joinMeeting(String meetingId) async {
  var response = await client.get(
    Uri.parse('$MEETING_API_URL/join?meetingId=$meetingId'),

  );
  print('meetingId11: $meetingId');
  if (response.statusCode >= 200 && response.statusCode < 400) {
    return response;
  }

  throw UnsupportedError('Not a valid Meeting');
}

