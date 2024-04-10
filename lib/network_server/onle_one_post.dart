import 'dart:convert';

import 'package:flutter/material.dart';

import '../main.dart';
import 'internet_data.dart';
import 'model_posts.dart';

class OnleOnePost extends StatefulWidget {
  const OnleOnePost({super.key});

  @override
  State<OnleOnePost> createState() => _OnleOnePostState();
}

class _OnleOnePostState extends State<OnleOnePost> {
  late ModelPosts modelPostList;
  bool t = false;
  InternetData internetData = InternetData();

  @override
  void initState() {
    getOnePost();
    super.initState();
  }

  getOnePost() async {
    t = false;
    modelPostList = await internetData.getOnePost(id);
    t = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Center(
          child: t
              ? Text("userId: ${modelPostList.userId}\n"
                  "id: ${modelPostList.id}\n"
                  "title: ${modelPostList.title}\n"
                  "body: ${modelPostList.body}")
              : CircularProgressIndicator()),
    ));
  }
}
