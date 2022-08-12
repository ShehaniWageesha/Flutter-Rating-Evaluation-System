import 'dart:convert';

Support supportFromJson(String str) => Support.fromJson(json.decode(str));

String supportToJson(Support data) => json.encode(data.toJson());

class Support {
  Support({
    this.contactNumber,
    this.email,
    this.problem,
    this.subject,
    this.urgencyLevel,
    this.isAccepted,
  });

  String? contactNumber;
  String? email;
  String? problem;
  String? subject;
  String? urgencyLevel;
  bool? isAccepted;

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        contactNumber: json["contactNumber"],
        email: json["email"],
        problem: json["problem"],
        subject: json["subject"],
        urgencyLevel: json["urgencyLevel"],
        isAccepted: json["isAccepted"],
      );

  Map<String, dynamic> toJson() => {
        "contactNumber": contactNumber,
        "email": email,
        "problem": problem,
        "subject": subject,
        "urgencyLevel": urgencyLevel,
        "isAccepted": isAccepted,
      };
}
