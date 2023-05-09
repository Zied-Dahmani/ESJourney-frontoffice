import 'dart:convert';
import 'package:http/http.dart';

class FirebaseCloudMessaging {
  static final Client client = Client();
  static const String serverKey =
      'AAAA_t5yEsI:APA91bGHdVyqwJcC1lSjcnhvphVy2SyFPztF0U1hJgKnlXN0tbcp5eHIDJUC8Fu8skM840gcKct_vv36gKJkOtEShwepHqvAaqLBJOu_4rX3pUNwKCpI1PcQRie1fIjXPt3FQEu3QJd9';

  static Future<Response> sendTo({
    String? title,
    String? body,
    String? fcmToken,
  }) =>
      client.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: json.encode({
          'notification': {
            'title': '$title',
            'body': '$body',
            'sound': 'assets/sound/scan_complete.mp3',
          },
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'sound': 'assets/sound/scan_complete.mp3',
          },
          'to': '$fcmToken'
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey'
        },
      );
}
