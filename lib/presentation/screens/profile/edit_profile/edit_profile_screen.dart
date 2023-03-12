import 'package:flutter/material.dart';

import '../../../../utils/screen_size.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            // Write the code to navigate back to the previous screen
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  height: width * 0.3,
                  width: width * 0.3,

                  decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    border:  Border.all(
                      color: Colors.white,
                      width: 4,
                    ),

                  ),
                  child: const CircleAvatar(
                    backgroundImage:
                    AssetImage('assets/images/challenges/cvpic.jpg'),
                    radius: 50,
                    backgroundColor: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: width * 0.09,
                    width: width * 0.09,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      )
                      ,
                      shape: BoxShape.circle,
                      color: theme.colorScheme.outline,
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Text("Account information",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'VisbyRoundCF',
            ),
          ),

        ],
      ),
    );
  }
}
