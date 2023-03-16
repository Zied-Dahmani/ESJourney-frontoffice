import 'package:flutter/material.dart';

import 'InternshipDetailsScreen.dart';

class InternshipOpp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internship Listings'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: [
            _buildInternshipCard(
              context,
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
              'Internship Title 1',
              '2023-03-01',
              '2023-06-01',
              '\$500 - \$1000',
            ),
            _buildInternshipCard(
              context,
              'https://picsum.photos/200',
              'Internship Title 2',
              '2023-03-15',
              '2023-08-15',
              '\$800 - \$1200',
            ),
            _buildInternshipCard(
              context,
              'https://picsum.photos/200',
              'Internship Title 3',
              '2023-04-01',
              '2023-07-01',
              '\$1000 - \$1500',
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildInternshipCard(
      BuildContext context,
      String image,
      String title,
      String startDate,
      String endDate,
      String salary,
      ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image container
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 5.0, bottom: 5.0),
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          // Internship details container
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Start Date: $startDate',
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  'End Date: $endDate',
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      salary,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => InternshipDetailsScreen(
                                title: title,
                                startDate: startDate,
                                endDate: endDate,
                                salary: salary,
                                description: 'Internship description goes here...',
                                imageUrl: image, stipend: '', // pass image URL here
                              ),
                            ),
                          );
                        },
                        child: Text('Details'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
