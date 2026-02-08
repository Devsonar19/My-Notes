import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutDevView extends StatefulWidget {
  const AboutDevView({super.key});

  @override
  State<AboutDevView> createState() => _AboutDevViewState();
}

class _AboutDevViewState extends State<AboutDevView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('f2e9e4'),
        appBar: AppBar(
          backgroundColor: HexColor('f2e9e4'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 110,
                  child: Text(
                      'Dev Sonar',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Text(
                    "I am a Flutter developer focused on building clean, efficient, and user-friendly applications.This app is the result of over two months of continuous learning and hands-on development.As I continue to grow my skills, I will keep improving and expanding this application.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tech Stack Used:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Flutter • Dart • Firebase • Bloc • SQLite • REST APIs \n• UI/UX Basics",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ]
                  )
                ),
                //Github
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: (){
                      launchUrl(Uri.parse('https://github.com/Devsonar19'));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.github, color: Colors.black, size: 20),
                          const SizedBox(width: 10),
                          Text(
                              'Github',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )
                          ),
                        ]
                      ),
                    )
                ),
                ),
                //linkedin
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: (){
                        launchUrl(Uri.parse('https://www.linkedin.com/in/dev-sonar-656677281/'));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(FontAwesomeIcons.linkedin, color: Colors.black, size: 20),
                              const SizedBox(width: 10),
                              Text(
                                  'LinkedIn',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )
                              ),
                            ]
                        ),
                      )
                  ),
                ),
                //leetcode
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: (){
                        launchUrl(Uri.parse('https://leetcode.com/u/Dev_Sonar19/'));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(FontAwesomeIcons.code, color: Colors.black, size: 20),
                              const SizedBox(width: 10),
                              Text(
                                  'LeetCode',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )
                              ),
                            ]
                        ),
                      )
                  ),
                ),
          
              ],
            ),
          ),
        ),
    );
  }
}
