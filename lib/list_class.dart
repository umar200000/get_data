import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_tugma/network_server/internet_data.dart';
import 'package:internet_tugma/network_server/model_posts.dart';
import 'package:internet_tugma/network_server/onle_one_post.dart';

import 'main.dart';

class ListClass extends StatefulWidget {
  const ListClass({super.key});

  @override
  State<ListClass> createState() => _ListClassState();
}

class _ListClassState extends State<ListClass> {
  List<ModelPosts> modelPostList = [];
  InternetData internetData = InternetData();
  String errorMessage = "";
  bool t = false;
  int controller = 0;

  @override
  void initState() {
    // getDataFromInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        controller = 1;
                        getDataFromInternet();
                      });
                    },
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    height: 60,
                    minWidth: 150,
                    child: Text("get error"),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        controller = 2;
                        errorMessage = "";
                        getDataFromInternet();
                        print("222");
                      });
                    },
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    height: 60,
                    minWidth: 150,
                    child: Text("get data"),
                  ),
                ],
              ),
              Expanded(
                  child: controller != 0
                      ? t
                          ? errorMessage.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: ListView.builder(
                                      itemCount: modelPostList.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            id = modelPostList[index].id;
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        OnleOnePost()));
                                          },
                                          title:
                                              Text(modelPostList[index].title),
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.greenAccent),
                                            child: Center(
                                              child: Text(
                                                  "${modelPostList[index].id}"),
                                            ),
                                          ),
                                          trailing: Icon(Icons.navigate_next),
                                        );
                                      }),
                                )
                              : Center(child: Text(errorMessage))
                          : Center(child: CircularProgressIndicator())
                      : Container())
            ],
          ),
        ),
      ),
    ));
  }

  getDataFromInternet() async {
    print("111");
    String data = controller == 1
        ? await internetData.getError()
        : controller == 2
            ? await internetData.getPosts()
            : "";
    try {
      t = false;

      modelPostList = (jsonDecode(data) as List)
          .map((e) => ModelPosts.fromJosn(e))
          .toList();
    } catch (e) {
      errorMessage = data;
    }
    t = true;
    setState(() {});
  }
}
