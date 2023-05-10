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


class PostToLinkedinScreenState extends State<PostToLinkedinScreen> {


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
              style: TextStyle(color: Colors.black),
              //

              decoration: InputDecoration(
                hintText: 'Enter your post here',
                hintStyle: TextStyle(color: Colors.grey),
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
            ElevatedButton(
              onPressed: () {
                submitPost(_textController.text);
              },

              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
