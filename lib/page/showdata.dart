
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sul_crud/SQldata.dart';

import '../component/mytext.dart';
import 'datashow.dart';

class Showdata extends StatefulWidget {
  Map? user;
  Showdata({super.key,this.user});

  @override
  State<Showdata> createState() => _ShowdataState();
}

class _ShowdataState extends State<Showdata> {

  TextEditingController Name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController contect = TextEditingController();
  TextEditingController  Password = TextEditingController();
  File? fainalimagepath;

  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    if(widget.user != null)
    {
      Name.text = widget.user!['name'];
      Email.text = widget.user!['email'];
      contect.text = widget.user!['contect'];
      Password.text = widget.user!['password'];
      fainalimagepath = File( widget.user!['image']);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          widget.user != null ?  IconButton(onPressed: () async {
            await sqldatas.instance.deletdata(id: widget.user!['id']);
            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => datashow(),));
          }, icon: Icon(Icons.delete)) : SizedBox(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formkey,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () async {
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Select",style: TextStyle(fontSize: 25)),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(onPressed: () async {
                                      ImagePicker image = ImagePicker();
                                      var imagepath = await image.pickImage(source: ImageSource.gallery);
                                      if(imagepath == null)
                                      {
                                        imagepath = await image.pickImage(source: ImageSource.gallery);
                                      }
                                      else
                                      {
                                        fainalimagepath = File(imagepath.path);
                                        Navigator.pop(context);
                                        debugPrint('$fainalimagepath');
                                        setState(() {});
                                      }
                                    }, icon: Icon(Icons.image,size: 30,)),
                                    Text("Gallry",style: TextStyle(fontSize: 20))
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(onPressed: () async {
                                      ImagePicker image = ImagePicker();
                                      XFile? camerapath = await image.pickImage(source: ImageSource.camera);
                                      if(camerapath == null)
                                      {
                                        camerapath = await image.pickImage(source: ImageSource.camera);
                                      }
                                      else
                                      {
                                        fainalimagepath = File("${camerapath.path}");
                                        Navigator.pop(context);
                                        debugPrint('$fainalimagepath');
                                        setState(() {});
                                      }
                                      print(camerapath);
                                    }, icon: Icon(Icons.camera,size: 30)),
                                    Text("Gallry",style: TextStyle(fontSize: 20))
                                  ],
                                )
                              ],
                            ),
                          );
                        },);
                      },
                      child: fainalimagepath != null ? Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: Image.file(fainalimagepath!) ,
                      ) :  Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,

                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    mttext(controller: Name,hinttext: "Name", validator: (namevalid) {
                      if(namevalid!.isEmpty)
                      {
                        return "Plase Enter Name";// return ;
                      }
                    },),
                    mttext(controller: Email,hinttext: "Email",
                      validator: (emailvali){
                        String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = new RegExp(p);

                        if(emailvali!.isEmpty)
                        {
                          return "Pless Enter email";
                        }else
                        {
                          if(regExp.hasMatch(emailvali))
                          {
                            return null;
                          }
                          else
                          {
                            return "Plase Enter Valid Email";
                          }
                        }
                      },
                    ),
                    mttext(controller: contect,
                      maxlenth: 10,
                      hinttext: "Contect",
                      validator: (contectvalid) {
                        if(contectvalid!.isEmpty)
                        {
                          return "Plase Enter contect";
                        }
                        else if(contectvalid.length < 10)
                        {
                          return "Plese Enter vallid Number";
                        }
                      },
                    ),
                    mttext(controller: Password,hinttext: "Password"),
                    SizedBox(height: 50,),
                    ElevatedButton(onPressed: () async {
                      if(formkey.currentState!.validate())
                      {
                        // Map userditels ={
                        //   "Name":"${Name.text}",
                        //   "Email":"${Email.text}",
                        //   "Contect":"${contect.text}",
                        //   "Pw":"${Password.text}",
                        //   "image":""
                        // };



                        if(fainalimagepath != null)
                        {

                          if(widget.user != null)
                          {
                            await sqldatas.instance.updatedata(name: Name.text, email: Email.text, password: Password.text, phone: contect.text, image: fainalimagepath!.path, id: widget.user!['id']);
                            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => datashow(),));
                          }else
                          {
                            await sqldatas.instance.savedata(name: Name.text, email: Email.text, contect: contect.text, pw: Password.text, image: fainalimagepath!.path );
                            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => datashow(),));

                          }
                        }
                        else
                        {
                          Fluttertoast.showToast(msg: "Plase Select Image");
                        }
                      }
                    }, child:  widget.user != null ? Text("Update"): Text("Save"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
