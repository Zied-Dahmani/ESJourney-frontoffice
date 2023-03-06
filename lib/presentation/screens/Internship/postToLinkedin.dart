import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostToLinkedinScreen extends StatefulWidget {
  const PostToLinkedinScreen({Key? key}) : super(key: key);

  @override
  State<PostToLinkedinScreen> createState() => _PostToLinkedinScreenState();
}

class _PostToLinkedinScreenState extends State<PostToLinkedinScreen> {
  final _textController = TextEditingController();
  final _AccessToken = "AQWWePoj7YwiHhwqIzMSFYiQ42vc6f06zFtot2fdJ4PnCM-bQyPYaE9wAD09ccFmwG7pokfJIv7DrGlQWdLpZmoceUN5JUEkGbilyYyRUXhivsxZvk0GDrZV9eWBkhZz4WnN_Wz9yNPjJKHxyCmoetIIBQo6ZAdDp8n-s5jOpHfmOF37ZNLqH8DG8zR2yf1j5SbF4RcH69QwJAH9ebBx9SbQUz6dmtXH94WNDh0rZkGsBDGHqNvBASv3iUNkF2xe41UyKIQRQ-5lMU8AVpPIhO87DiLm2WI7XfWb07UXqvnI3YPhlho2vsB1hqvUsAjnuGMR_wzXZr7ffqesI-nbW3gUD5xyJg";
  final _linkedinId = "xiOiABYH2H";
  Future<void> _submitPost() async {
    final text = _textController.text;

    final apiUrl = Uri.parse('https://api.linkedin.com/v2/ugcPosts');

    final headers = {
      'Authorization': 'Bearer $_AccessToken',
      'Content-Type': 'application/json',
      'X-Restli-Protocol-Version': '2.0.0',
    };

    final payload = {

      "author": "urn:li:person:$_linkedinId",
      "lifecycleState": "PUBLISHED",
      "specificContent": {
        "com.linkedin.ugc.ShareContent": {
          "shareCommentary": {
            "text":text
          },
          "shareMediaCategory": "NONE"
        }
      },
      "visibility": {
        "com.linkedin.ugc.MemberNetworkVisibility": "PUBLIC"
      }

    };

    final response = await http.post(Uri.parse('https://api.linkedin.com/v2/ugcPosts'), headers: headers, body: json.encode(payload) );


    if (response.statusCode == 201) {
      // Post created successfully
      print('Post submitted successfully');
    } else {
      // Handle error response
      print('Error submitting post: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post to LinkedIn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              style: TextStyle(color: Colors.black), //



              decoration: InputDecoration(
                hintText: 'Enter your post here',
                hintStyle: TextStyle(color: Colors.grey), //

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),

              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitPost,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}