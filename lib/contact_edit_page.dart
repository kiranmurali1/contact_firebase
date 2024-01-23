import 'package:flutter/material.dart';
import 'contact_model.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactEditPage extends StatefulWidget {
  final ContactResponceModel contact;
  final String docId;

  const ContactEditPage({
    Key? key,
    required this.contact,
    required this.docId,
  }) : super(key: key);

  @override
  State<ContactEditPage> createState() => _ContactEditPageState();
}

class _ContactEditPageState extends State<ContactEditPage> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial values in the text controllers
    firstname.text = widget.contact.firstname ?? '';
    lastname.text = widget.contact.lastname ?? '';
    mobile.text = widget.contact.mobile ?? '';
    email.text = widget.contact.email ?? '';
  }

  void updateContact() async {
    try {
      await FirebaseFirestore.instance
          .collection('contact')
          .doc(widget.docId)
          .update({
        'firstname': firstname.text,
        'lastname': lastname.text,
        'mobile': mobile.text,
        'email': email.text,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("Failed to update contact: $error"),
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
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        title: Container(
          color: Colors.white12,
          child: const Text(
            "Edit Contact",
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
                updateContact();
              },
              child: const Text("Save",
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
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
              const SizedBox(
                height: 20,
              ),
              const CircleAvatar(
                maxRadius: 60,
                child: Icon(Icons.add_photo_alternate),
              ),
              TextButton(onPressed: () {}, child: const Text("Add Picture")),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(Icons.account_box),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    width: 210,
                    height: 60,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: firstname,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
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
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 210,
                height: 60,
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: lastname,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
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
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(Icons.call),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    width: 210,
                    height: 60,
                    child: TextFormField(
                      controller: mobile,
                      keyboardType: const TextInputType.numberWithOptions(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
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
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(Icons.email),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    width: 210,
                    height: 60,
                    child: TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
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
