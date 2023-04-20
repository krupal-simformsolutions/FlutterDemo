import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutterdemo/values/styles.dart';
import 'package:flutterdemo/views/my_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> list = ['Name', 'email', 'mobile'];
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 0,
        titleTextStyle: const TextStyle(color: Colors.black),
        title: Center(
          child: Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "assets/images/profile_bg.png",
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                bottom: 0,
                child: Image.asset("assets/images/sample_profile.png"),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Alex Nikitov',
            style: AppStyles.titleTextBig,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'alex@msn.com',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Text(list[index]);
            },
          ),
          Text('Title here'),
        ],
      ),
    );
  }
}
