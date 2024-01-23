import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'contact_edit_page.dart';
import 'contact_model.dart';
import 'home_page.dart';

class ContactProfilePage extends StatefulWidget {
  final ContactResponceModel contact;
  final String docId;

  const ContactProfilePage(
      {Key? key, required this.contact, required this.docId})
      : super(key: key);

  @override
  State<ContactProfilePage> createState() => _ContactProfilePageState();
}

class _ContactProfilePageState extends State<ContactProfilePage> {
  late Future<ContactResponceModel> futureContact;

  @override
  void initState() {
    super.initState();
    futureContact = fetchContact();
  }

  Future<ContactResponceModel> fetchContact() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('contact')
          .doc(widget.docId)
          .get();

      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        return ContactResponceModel.fromJson(data);
      } else {
        throw Exception("Contact data not found");
      }
    } catch (error) {
      throw Exception("Failed to fetch contact: $error");
    }
  }

  void deleteContact() async {
    try {
      await FirebaseFirestore.instance
          .collection('contact')
          .doc(widget.docId)
          .delete();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false,
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("Failed to delete contact: $error"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactEditPage(
                    contact: widget.contact,
                    docId: widget.docId.toString(),
                  ),
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm Deletion"),
                    content: const Text(
                        "Are you sure you want to delete this contact?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          // Call the deleteContact function when confirmed
                          deleteContact();
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                maxRadius: 100,
                backgroundColor:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                child: Text(
                  widget.contact.firstname?[0].toUpperCase() ?? ' ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 120,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "${widget.contact.firstname} ${widget.contact.lastname}",
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        maxRadius: 30,
                        child: Icon(Icons.call),
                      ),
                      Text("Call"),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        maxRadius: 30,
                        child: Icon(Icons.message),
                      ),
                      Text("Message"),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        maxRadius: 30,
                        child: Icon(Icons.video_camera_back_sharp),
                      ),
                      Text("Video"),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                  ),
                  Text(
                    "Contact info",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                  ),
                  Icon(Icons.call),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "${widget.contact.mobile.toString()}",
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                  ),
                  Icon(Icons.email_rounded),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "${widget.contact.email}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
