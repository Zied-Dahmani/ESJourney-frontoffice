import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/screens/Events/calendar_screen.dart';
import 'package:esjourney/presentation/screens/Internship/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../profile/profile_screen.dart';
import 'profileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

List<Internship> internships = [

  const Internship(
    title: "Software Development",
    description: "Collaborate with the development..",
    image: "https://media.istockphoto.com/id/1442974347/photo/computer-coding-software-development-and-programmer-man-writing-code-for-cybersecurity.jpg?b=1&s=170667a&w=0&k=20&c=P8zPegwGUlXoDoZFjcB0k4zhttvsmf0t_jjqWbSEn2g=",
  ),
  const Internship(
    title: "Social Media Intern",
    description: "Create and manage social media..",
    image: "https://images.unsplash.com/photo-1579869847557-1f67382cc158?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8c29jaWFsJTIwbWVkaWF8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  ),
  const Internship(
    title: "Graphic Design",
    description: "Design graphics for marketing..",
    image: "https://images.unsplash.com/photo-1572044162444-ad60f128bdea?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Z3JhcGhpYyUyMGRlc2lnbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"
  ),
  const Internship(
    title: "Business Development",
    description: "Identify potential business deals..",
    image: "https://images.unsplash.com/photo-1444653614773-995cb1ef9efa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NjZ8fGJ1c2luZXNzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
  ),
];


class InternshipHomePage extends StatelessWidget {
  const InternshipHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Internships"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: internships.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CalendarScreen(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                internships[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  internships[index].title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  internships[index].description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildContainer(
                  context: context,
                  icon: FontAwesomeIcons.pen,
                  color: const Color(0xFFEB4A5A),
                  text: "Add My Info",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ApplicationFormScreen()),
                    );
                  },
                ),
                _buildContainer(
                  context: context,
                  icon: FontAwesomeIcons.linkedin,
                  color: Colors.blue,
                  text: "Linkedin post",
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRoutes.postToLinkedinScreen);
                  },
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
          boxShadow: const [
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
              size: 60.0,
              color: color,
            ),
            const SizedBox(height: 10.0),
            Text(text),
          ],
        ),
      ),
    );
  }
}
class Internship {
  final String title;
  final String description;
  final String image;
   const Internship({required this.title, required this.description, required this.image});


}