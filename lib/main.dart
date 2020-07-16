import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          accentColor: Colors.cyan),
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String studentName, studentID, studySpecialtyID;
  double studentMark;

  getStudentName(name) {
    this.studentName = name;
  }

  getStudentID(id) {
    this.studentID = id;
  }

  getStudySpecialtyID(studySpecialtyID) {
    this.studySpecialtyID = studySpecialtyID;
  }

  getStudentMark(mark) {
    this.studentMark = double.parse(mark);
  }

  createData() {
    print("created");
    DocumentReference documentReference =
        Firestore.instance.collection("Students").document(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studySpecialtyID": studySpecialtyID,
      "studentMark": studentMark
    };
    documentReference.setData(students).whenComplete(() {
      print("$studentName created!");
    });
  }

  readData() {
    print("read");
    DocumentReference documentReference =
        Firestore.instance.collection("Students").document(studentName);

    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data["studentName"]);
      print(datasnapshot.data["studentID"]);
      print(datasnapshot.data["studySpecialtyID"]);
      print(datasnapshot.data["studentMark"]);
    });
  }

  updateData() {
    print("updated");
    print("created");
    DocumentReference documentReference =
        Firestore.instance.collection("Students").document(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studySpecialtyID": studySpecialtyID,
      "studentMark": studentMark
    };
    documentReference.setData(students).whenComplete(() {
      print("$studentName updated!");
    });
  }

  deleteData() {
    print("deleted");
    DocumentReference documentReference =
        Firestore.instance.collection("Students").document(studentName);
    documentReference.delete().whenComplete(() {
      print("$studentName deleted!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Students"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Name",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String name) {
                  getStudentName(name);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Student ID",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String id) {
                  getStudentID(id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Specialty ID",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String sID) {
                  getStudySpecialtyID(sID);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Mark",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String mark) {
                  getStudentMark(mark);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Create"),
                    textColor: Colors.white,
                    onPressed: () {
                      createData();
                    },
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Read"),
                    textColor: Colors.white,
                    onPressed: () {
                      readData();
                    },
                  ),
                  RaisedButton(
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Update"),
                    textColor: Colors.white,
                    onPressed: () {
                      updateData();
                    },
                  ),
                  RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Delete"),
                    textColor: Colors.white,
                    onPressed: () {
                      deleteData();
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text("ID")),
                  Expanded(child: Text("Name")),
                  Expanded(child: Text("Specialty ID")),
                  Expanded(child: Text("Mark")),
                ],
              ),
            ),
            StreamBuilder(
                stream: Firestore.instance.collection("Students").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data.documents[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Text(documentSnapshot["studentID"])),
                                Expanded(
                                    child: Text(documentSnapshot["studentName"])),
                                Expanded(
                                    child: Text(
                                        documentSnapshot["studySpecialtyID"])),
                                Expanded(
                                    child: Text(documentSnapshot["studentMark"]
                                        .toString())),
                              ],
                            ),
                          );
                        });
                  } else {
                      return Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: CircularProgressIndicator(),
                      );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
