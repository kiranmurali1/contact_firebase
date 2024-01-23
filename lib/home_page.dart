import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_contact.dart';
import 'contact_model.dart';
import 'contact_profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ContactResponceModel>> futureContacts;

  @override
  void initState() {
    super.initState();
    futureContacts = fetchContactsSorted();
  }

  Future<List<ContactResponceModel>> fetchContactsSorted() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('contact')
          .orderBy('firstname') // Specify the field to sort by
          .get();

      List<ContactResponceModel> contacts = querySnapshot.docs
          .map((doc) =>
              ContactResponceModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return contacts;
    } catch (error) {
      throw Exception("Failed to fetch contacts: $error");
    }
  }

  Stream<QuerySnapshot> getContactsStream() {
    // Use orderBy('firstname') to sort by first name
    return FirebaseFirestore.instance
        .collection('contact')
        .orderBy('firstname')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddContact(),
            )),
        child: Icon(Icons.add, size: 25),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SizedBox(
          width: 320,
          height: 50,
          child: TextFormField(
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: Colors.blueGrey.shade50,
              prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min, // added line
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.account_circle)),
                  // IconButton(
                  //     onPressed: clearContacts, icon: Icon(Icons.delete)),
                ],
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: "Search Contacts",
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: StreamBuilder<QuerySnapshot>(
          stream: getContactsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Convert each document to a ContactResponceModel
              List<ContactResponceModel> contacts = snapshot.data!.docs
                  .map((doc) => ContactResponceModel.fromJson(
                      doc.data() as Map<String, dynamic>))
                  .toList();

              // Build the ListView using the contacts
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  ContactResponceModel contact = contacts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactProfilePage(
                            contact: contact,
                            docId: contact.docid.toString(),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      // child: ListTile(
                      //   title: Text("${contact.firstname} ${contact.lastname}"),
                      //   subtitle: Text(contact.mobile ?? ""),
                      //   // Add more details as needed
                      // ),
                      child: SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                              child: Text(
                                "${contact.firstname?[0]}",
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // CircleAvatar(
                            //   // backgroundColor: Colors.primaries[
                            //   //     Random().nextInt(Colors.primaries.length)],
                            //   // backgroundColor: Colors.redAccent,
                            //   child: Text(
                            //     contact.firstname?[0].toUpperCase() ?? " ",
                            //     style: const TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: 20,
                            //       color: Colors.black,
                            //     ),
                            //   ), // Use a default color or customize as needed
                            // ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("${contact.firstname} ${contact.lastname}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),

//
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(color: Colors.cyan),
        unselectedFontSize: 8,
        selectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.account_circle,
              ),
              label: "Contact"),
          BottomNavigationBarItem(
            icon: Icon(Icons.highlight),
            label: "Highlights",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_fix_high),
            label: "Fix & Manage",
          ),
        ],
        selectedItemColor: Colors.blue[800],
      ),
    );
  }
}
