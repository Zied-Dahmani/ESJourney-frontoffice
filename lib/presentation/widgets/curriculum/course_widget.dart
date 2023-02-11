import 'package:flutter/material.dart';

class CourseItem extends StatelessWidget {
  const CourseItem({
    super.key,
    required this.height,
    required this.width,
    required this.imagePath,
    required this.courseTitle,
    required this.onTap,
  });

  final double height;
  final double width;
  final String imagePath;
  final String courseTitle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 0.01 * height,
        right: 0.01 * width,
        left: 0.01 * width,
        bottom: 0.01 * height,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 20,
            offset: const Offset(10, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              imagePath,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 0.04 * width,
              right: 0.02 * width,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  courseTitle,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                IconButton(
                  onPressed: onTap,
                  icon: const Icon(Icons.keyboard_arrow_right),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
