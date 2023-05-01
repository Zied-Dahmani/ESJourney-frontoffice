import 'dart:io';

import 'package:esjourney/logic/cubits/challenges/posts/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key? key}) : super(key: key);


  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  late final TextEditingController _controller =
      TextEditingController();

  final ImagePicker picker = ImagePicker();
  XFile? _imageFile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text("cancel",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'VisbyRoundCF',
                )),
            const Spacer(),
            TextButton(
              onPressed: () {
                BlocProvider.of<PostCubit>(context).createPost(_controller.text, media: _imageFile);
              },
              child: Text(
                "post",
                style: TextStyle(
                  fontSize: 15,
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'VisbyRoundCF',
                ),
              ),
            ),

          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 20,
                  backgroundImage:
                      const AssetImage('assets/images/challenges/avatar.png'),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("aaaa"),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            TextFormField(
              controller: _controller,
              cursorColor: theme.colorScheme.secondary,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                labelStyle: TextStyle(decoration: TextDecoration.none),
                hintText: "What's on your next journey?",
                hintStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'VisbyRoundCF',
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async {
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      _imageFile = image;
                    });
                  },
                  icon: const Icon(Icons.image),
                ),
              ],
            ),
            if (_imageFile != null)
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(_imageFile!.path)),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
