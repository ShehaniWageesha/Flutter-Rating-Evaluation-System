import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../db/api/auth.dart';
import '../../db/api/user_api.dart';
import '../../db/model/support_request.dart';
import '../login_page_view.dart';

class GetAllSupportView extends StatefulWidget {
  final bool isAdmin;
  const GetAllSupportView({Key? key, required this.isAdmin}) : super(key: key);

  @override
  State<GetAllSupportView> createState() => _GetallSupportViewState();
}

class _GetallSupportViewState extends State<GetAllSupportView> {
  List list = [];
  final emailSCtrl = TextEditingController();
  final contactCtrl = TextEditingController();
  final subjectCtrl = TextEditingController();
  final problemCtrl = TextEditingController();
  UrgencyLevel _site = UrgencyLevel.today;
  late DocumentSnapshot documentSnapshot;
  String email = "";

  @override
  void initState() {
    getAllSupportReqests();
    super.initState();
  }

  Widget getSupportReq() {
    if (email != "" && emailSCtrl.text == "") {
      emailSCtrl.text = documentSnapshot['email'];
      contactCtrl.text = documentSnapshot['contactNumber'];
      subjectCtrl.text = documentSnapshot['subject'];
      problemCtrl.text = documentSnapshot['problem'];
      _site = UrgencyLevel.values.byName(documentSnapshot['urgencyLevel']);
    }

    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text('Support request'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: emailSCtrl,
                decoration: const InputDecoration(hintText: "Email"),
              ),
              TextField(
                controller: contactCtrl,
                decoration: const InputDecoration(hintText: "Contact number"),
              ),
              TextField(
                controller: subjectCtrl,
                decoration: const InputDecoration(hintText: "Subject"),
              ),
              TextField(
                controller: problemCtrl,
                decoration: const InputDecoration(hintText: "Problem"),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text('Urgency level: '),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text('Today'),
                    leading: Radio(
                      value: UrgencyLevel.today,
                      groupValue: _site,
                      onChanged: (UrgencyLevel? value) {
                        setState(() {
                          _site = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('In the next 48 hours'),
                    leading: Radio(
                      value: UrgencyLevel.inTheNext48hours,
                      groupValue: _site,
                      onChanged: (UrgencyLevel? value) {
                        setState(() {
                          _site = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('This week'),
                    leading: Radio(
                      value: UrgencyLevel.thisWeek,
                      groupValue: _site,
                      onChanged: (UrgencyLevel? value) {
                        setState(() {
                          _site = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Not urgent'),
                    leading: Radio(
                      value: UrgencyLevel.notUrgent,
                      groupValue: _site,
                      onChanged: (UrgencyLevel? value) {
                        setState(() {
                          _site = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                        onPressed: () async {
                          await UserApi().updateSupport(documentSnapshot,Support(
                            email: emailSCtrl.text,
                            contactNumber: contactCtrl.text,
                            problem: problemCtrl.text,
                            subject: subjectCtrl.text,
                            urgencyLevel: _site.name,
                              isAccepted: false
                          ));
                          Navigator.pop(context);
                          getAllSupportReqests();
                        },
                        child: const Text("Submit")),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                        onPressed: () async {
                          await UserApi().deleteSupport(documentSnapshot);
                          Navigator.pop(context);
                          getAllSupportReqests();
                        },
                        child: const Text("Delete")),
                  ),
                  SizedBox(width: 10,),
                  widget.isAdmin ?  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                        onPressed: () async {
                          await UserApi().updateSupport(documentSnapshot,Support(
                            email: emailSCtrl.text,
                            contactNumber: contactCtrl.text,
                            problem: problemCtrl.text,
                            subject: subjectCtrl.text,
                            urgencyLevel: _site.name,
                            isAccepted: true
                          ));
                          Navigator.pop(context);
                          getAllSupportReqests();
                        },
                        child: const Text("Accept")),
                  ) : Container(),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Future<void> getAllSupportReqests() async {
    list = await UserApi().getAllSupportReq();
    setState(() {
      list = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Student panel",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () async {
              await Auth().logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPageView()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          for (int i = 0; i < list.length; i++)
            InkWell(
              onTap: () {
                emailSCtrl.text = "";
                contactCtrl.text = "";
                subjectCtrl.text = "";
                problemCtrl.text = "";
                setState(() {
                  email = list[i]['email'];
                  documentSnapshot = list[i];
                });
              },
              child: Card(
                elevation: 4,
                child: Container(
                  color: email == list[i]['email']
                      ? Color(0xff0c84a3)
                      : Colors.white,
                  height: MediaQuery.of(context).size.height * 0.11,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${i + 1}",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: email == list[i]['email']
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              list[i]['subject'],
                              style: TextStyle(
                                fontSize: 18.0,
                                color: email == list[i]['email']
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {
                              problemCtrl.text = "";
                              subjectCtrl.text = "";
                              contactCtrl.text = "";
                              emailSCtrl.text = "";
                              setState(() {
                                email = list[i]['email'];
                                documentSnapshot = list[i];
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return getSupportReq();
                                  });
                            },
                            child: Icon(Icons.edit),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
        ]),
      ),
    );
  }
}

enum UrgencyLevel { today, inTheNext48hours, thisWeek, notUrgent }
