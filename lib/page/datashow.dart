import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sul_crud/SQldata.dart';
import 'package:sul_crud/page/showdata.dart';
class datashow extends StatefulWidget {
  const datashow({super.key});

  @override
  State<datashow> createState() => _datashowState();
}

class _datashowState extends State<datashow> {

  List<Map> datas= [];

  get() async {
    datas = await sqldatas.instance.getdata();
    setState(() {});
  }

  @override
  void initState() {
    get();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: ListView.builder(
        itemCount: datas.length,
        itemBuilder: (context, index) {
          final fail = File(datas[index]['image']);

          return InkWell(
              onTap: (){
                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => Showdata(user: datas[index]),));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 130,
                            width: 100,
                            child: Image.file(fail,fit: BoxFit.cover),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name : ${datas[index]['name']}"),
                              Text("Email : ${datas[index]['email']}"),
                              Text("Contect ${datas[index]['contect']}"),
                              Text("Password ${datas[index]['password']}"),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
          );
        },),
      floatingActionButton: FloatingActionButton(
          child: Text("Creat"),
          onPressed: (){
            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => Showdata(),));
          }),
    );
  }
}
