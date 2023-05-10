import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/screens/Internship/profileScreen.dart';
import 'package:flutter/material.dart';
import 'profileScreen.dart';

class InternshipHomePage extends StatelessWidget {
  const InternshipHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildContainer(
                  context: context,
                  icon: Icons.person,
                  color: Color(0xFFEB4A5A),
                  text: "Add My Info",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ApplicationFormScreen()),
                    );
                  },
                ),
                _buildContainer(
                  context: context,
                  icon: Icons.add_a_photo,
                  color: Color(0xFFEB4A5A),
                  text: "Add Photo",
                  onTap: () {
                    // naviagte here
                    Navigator.pushNamed(
                        context, AppRoutes.postToLinkedinScreen);
                    print("object");
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildContainer(
                  context: context,
                  icon: Icons.add_a_photo,
                  color: Color(0xFFEB4A5A),
                  text: "Add Photo",
                  onTap: () {},
                ),
                _buildContainer(
                  context: context,
                  icon: Icons.add_a_photo,
                  color: Color(0xFFEB4A5A),
                  text: "Add Photo",
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(10.0, 10.0),
              blurRadius: 10.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80.0,
              color: color,
            ),
            SizedBox(height: 10.0),
            Text(text),
          ],
        ),
      ),
    );
  }
}
