import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Define the function for building the glass container without shadow
Widget _buildGlassContainer({required Widget child, double width = 320}) {
  return Container(
    width: width,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFffffff).withOpacity(0.1),
          Color.fromRGBO(255, 255, 255, 1).withOpacity(0.05),
        ],
      ),
    ),
    child: Center(child: child), // Center the child vertically
  );
}

// Define the function for building glassy-styled buttons
Widget _buildGlassButton({
  required String label,
  required VoidCallback onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFffffff).withOpacity(0.3),
          Color.fromRGBO(255, 255, 255, 1).withOpacity(0.2),
        ],
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 8, horizontal: 16), // Adjust button padding
          child: Text(
            label,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 14, // Adjust button font size
            ),
          ),
        ),
      ),
    ),
  );
}

// Widget to display profile details with large photo and fixed information
class ProfileDetails extends StatelessWidget {
  final String name;
  final String description;
  final String githubLink;
  final String linkedInLink;
  final String photoUrl;

  ProfileDetails({
    required this.name,
    required this.description,
    required this.githubLink,
    required this.linkedInLink,
    required this.photoUrl,
  });

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.8;

    return _buildGlassContainer(
      width: containerWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _launchUrl(githubLink),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                photoUrl,
                width: containerWidth * 0.4,
                height: containerWidth * 0.4,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          _buildGlassButton(
            label: 'GitHub',
            onPressed: () => _launchUrl(githubLink),
          ),
          SizedBox(height: 4), // Reduced SizedBox height between buttons
          _buildGlassButton(
            label: 'LinkedIn',
            onPressed: () => _launchUrl(linkedInLink),
          ),
        ],
      ),
    );
  }
}

// Widget to display static profiles with photos
class ProfilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('The Creator')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileDetails(
                name: 'Onuh Oche',
                description: 'Flutter Developer/Creative Technologies',
                githubLink: 'https://github.com/OnuhOche',
                linkedInLink:
                    'www.linkedin.com/in/onuh-oche-232551142',
                photoUrl:
                    '',
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
