// To parse this JSON data, do
//
//     final contactResponceModel = contactResponceModelFromJson(jsonString);

import 'dart:convert';

ContactResponceModel contactResponceModelFromJson(String str) =>
    ContactResponceModel.fromJson(json.decode(str));

String contactResponceModelToJson(ContactResponceModel data) =>
    json.encode(data.toJson());

class ContactResponceModel {
  String? firstname;
  String? lastname;
  String? docid;
  String? email;
  String? mobile;

  ContactResponceModel({
    this.firstname,
    this.lastname,
    this.docid,
    this.email,
    this.mobile,
  });

  factory ContactResponceModel.fromJson(Map<String, dynamic> json) =>
      ContactResponceModel(
        firstname: json["firstname"],
        lastname: json["lastname"],
        docid: json["docid"],
        email: json["email"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "docid": docid,
        "email": email,
        "mobile": mobile,
      };
}
