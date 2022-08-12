import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_sliit/db/model/support_request.dart';
import 'package:crud_sliit/ui/widgets/textfield_ctrl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../bloc/root_page/root_bloc.dart';
import '../bloc/root_page/root_event.dart';
import '../db/api/auth.dart';
import '../db/api/user_api.dart';
import 'login_page_view.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  late RootBloc rootBloc;
  late DocumentSnapshot documentSnapshot;
  double teacherRating = 0.0;
  String email = "";
  UrgencyLevel _site = UrgencyLevel.today;

  final emailSCtrl = TextEditingController();
  final contactCtrl = TextEditingController();
  final subjectCtrl = TextEditingController();
  final problemCtrl = TextEditingController();

  Widget getSupportReq() {
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
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                    onPressed: () async {
                      await UserApi().addSupport(Support(
                        email: emailSCtrl.text,
                        contactNumber: contactCtrl.text,
                        problem: problemCtrl.text,
                        subject: subjectCtrl.text,
                        urgencyLevel: _site.name,
                        isAccepted: false,
                      ));
                      Navigator.pop(context);
                    },
                    child: const Text("Submit")),
              )
            ],
          ),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Student Panel",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: ListView(children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(Icons.support),
                const SizedBox(
                  width: 15.0,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blueGrey,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return getSupportReq();
                        });
                  },
                  child: const Text(
                    'Support request',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(Icons.request_page),
                const SizedBox(
                  width: 15.0,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blueGrey,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GetAllSupportView(
                                  isAdmin: false,
                                )));
                  },
                  child: const Text(
                    'Get all support requests',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
