import 'dart:convert';

import 'package:esjourney/presentation/screens/Internship/shareToLinkedin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class PostToLinkedinScreen extends StatefulWidget {
  const PostToLinkedinScreen({Key? key}) : super(key: key);

  @override
  State<PostToLinkedinScreen> createState() => PostToLinkedinScreenState();
}
final _textController = TextEditingController();
ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

class PostToLinkedinScreenState extends State<PostToLinkedinScreen> {


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              style: const TextStyle(color: Colors.black),
              //

              decoration: InputDecoration(
                hintText: 'Enter your post here',
                hintStyle: const TextStyle(color: Colors.grey),
                //

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
    ValueListenableBuilder(
    valueListenable: _isLoading,
    builder: (BuildContext context, bool isLoading, _) {
    return ElevatedButton(
              style: ElevatedButton.styleFrom(
               backgroundColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                print("is loading $isLoading");
                submitPost(_textController.text);
              },

              child: _isLoading.value
                  ? SizedBox(
                height: 20,
                width: 20,
                    child: const CircularProgressIndicator(

                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
                  )
                  :  Text('Post',

              style: TextStyle(color: theme.colorScheme.onPrimary),

      ),
            );
    }
    ),
          ],
        ),
      ),
    );
  }
  Future<void> submitPost(String text ) async {
    _isLoading.value = true;
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
      _isLoading.value = false;
      print('Post submitted successfully');

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      const SnackBar(content: Text('Post submitted successfully'));

    } else {
      _isLoading.value = false;
      // Handle error response
      SnackBar(content: Text('Error submitting post'));
      print('Error submitting post: ${response.body}');
    }
  }

}

const _accessToken =
    "AQVIcbOUcEEu0nB9Q40Ew0opfzXJ1wsinxe5ldJUgoEBIZhPjzytUy1CY5_iGiz46sFCvYkOXRNHEp95XZnnVcRWiDXgGCEmXlzwmgRHmYFHmvWt5QZSlOrzR8AyLSIMl6JNDUWK02kJcspRplpxyYaSjnFHX9JTJfsVC_7VHK1rwvY26QnuqzK7lMnlE6ts5kJnI8DbYcQbpUMWEgP0iyFJxNzoVvhL5HWAoMbAva2bxC5YoLpzILtgAl4YyLRid7jsqC9L0jCzkk-NJie0LA7nmilKA6Lv5GoyrJSIFG3JpJ48DcHY4Ii1KskkV0668iduKQmvpGseG4PCTjfY3BwW9TC93w";
const _linkedinId = "xiOiABYH2H";

