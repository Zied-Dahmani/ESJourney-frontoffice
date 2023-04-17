import 'package:http/http.dart' as http;
import 'dart:convert';

const _accessToken =
    "AQWWePoj7YwiHhwqIzMSFYiQ42vc6f06zFtot2fdJ4PnCM-bQyPYaE9wAD09ccFmwG7pokfJIv7DrGlQWdLpZmoceUN5JUEkGbilyYyRUXhivsxZvk0GDrZV9eWBkhZz4WnN_Wz9yNPjJKHxyCmoetIIBQo6ZAdDp8n-s5jOpHfmOF37ZNLqH8DG8zR2yf1j5SbF4RcH69QwJAH9ebBx9SbQUz6dmtXH94WNDh0rZkGsBDGHqNvBASv3iUNkF2xe41UyKIQRQ-5lMU8AVpPIhO87DiLm2WI7XfWb07UXqvnI3YPhlho2vsB1hqvUsAjnuGMR_wzXZr7ffqesI-nbW3gUD5xyJg";
const _linkedinId = "xiOiABYH2H";

Future<void> submitPost(String text) async {
  final headers = {
    'Authorization': 'Bearer $_accessToken',
    'Content-Type': 'application/json',
    'X-Restli-Protocol-Version': '2.0.0',
  };

  final payload = {
    "author": "urn:li:person:$_linkedinId",
    "lifecycleState": "PUBLISHED",
    "specificContent": {
      "com.linkedin.ugc.ShareContent": {
        "shareCommentary": {"text": text},
        "shareMediaCategory": "NONE"
      }
    },
    "visibility": {"com.linkedin.ugc.MemberNetworkVisibility": "PUBLIC"}
  };

  final response = await http.post(
      Uri.parse('https://api.linkedin.com/v2/ugcPosts'),
      headers: headers,
      body: json.encode(payload));

  if (response.statusCode == 201) {
    // Post created successfully
    print('Post submitted successfully');
  } else {
    // Handle error response
    print('Error submitting post: ${response.body}');
  }
}
