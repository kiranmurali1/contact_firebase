import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_contact/home_page.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final formKey = GlobalKey<FormState>();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("object");
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        title: Container(
          color: Colors.white12,
          child: Text(
            "Create Contact",
            style: TextStyle(fontSize: 18),
          ),
        ),
        actions: [
          SizedBox(
            width: 80,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Background color
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  CollectionReference contact =
                      FirebaseFirestore.instance.collection('contact');
                  contact.add({
                    'firstname': firstname.text,
                    'lastname': lastname.text,
                    'mobile': mobile.text,
                    'email': email.text,
                  }).then((value) => {
                        contact.doc(value.id).update({"docid": value.id})
                      });
                  // print("User added successfully!"))
                  // .catchError((error) => print("Failed to add user: $error"));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));

                  print("hhhhhhh");
                }
              },
              child: Text("Save",
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              maxRadius: 60,
              child: Icon(Icons.add_photo_alternate),
            ),
            TextButton(onPressed: () {}, child: Text("Add Picture")),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.account_box),
                SizedBox(
                  width: 30,
                ),
                Container(
                  width: 210,
                  height: 98,
                  child: Column(
                    children: [
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: firstname,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "First Name Required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          labelText: "First Name",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 210,
              height: 98,
              child: Column(
                children: [
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: lastname,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Last Name Required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      labelText: "Last Name",
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.call),
                SizedBox(
                  width: 30,
                ),
                SizedBox(
                  width: 210,
                  height: 98,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: mobile,
                        keyboardType: const TextInputType.numberWithOptions(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone number Required";
                          } else if (value.length != 10) {
                            return " mobile number must have 10 digit";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          labelText: "Phone",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.email),
                SizedBox(
                  width: 30,
                ),
                SizedBox(
                  width: 210,
                  height: 100,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required email address";
                          } else if (!value.contains(RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'))) {
                            return " email id is not in proper format";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        )),
      ),
    );
  }
}

// showAlertDialog(BuildContext context, String title, String message) {
//   AlertDialog alert = AlertDialog(
//     title: Text(title),
//     content: Text(message),
//     actions: [
//       TextButton(
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//         child: Text('OK'),
//       ),
//     ],
//   );
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }
