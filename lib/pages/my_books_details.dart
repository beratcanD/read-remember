import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page_firebase_flutter/constants.dart';
import 'package:login_page_firebase_flutter/pages/components/action_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_page_firebase_flutter/pages/my_books_details.dart';

class MyBooksDetail extends StatelessWidget {
    final int index;
    MyBooksDetail(this.index);


  @override
  Widget build(BuildContext context) {
    final _firestore=FirebaseFirestore.instance;
    CollectionReference booksRef=_firestore.collection("books");
    return Scaffold(
      appBar: AppBar(title: Text("Detaylar"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: booksRef.snapshots(),
                builder: (BuildContext context, AsyncSnapshot asyncSnapshot){
                  List<DocumentSnapshot>listOfDocumentSnap = asyncSnapshot.data.docs;
                  return Flexible(
                    child: ListView.builder(
                        itemCount:listOfDocumentSnap.length,
                        itemBuilder:(context,index){
                            return Card(
                              color: Colors.grey,
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Text("Kitap Adı:" + "${listOfDocumentSnap[index]["bookName"]}",
                                      style: TextStyle(fontSize: 24),
                                      ),
                                      Text("Kitap Yazarı:" + "${listOfDocumentSnap[index]["bookAuthor"]}",
                                      style: TextStyle(fontSize: 24),
                                      ),
                                      Text("Notlar:" + "${listOfDocumentSnap[index]["bookNote"]}",
                                      style: TextStyle(fontSize: 18),
                                    )
                                    ]
                                  ),
                                ],
                              ),
                            );
                        } ,
                    ),
                  );
              } ,
              )
            ],
          ),
        ),
      ),
    );
  }
}

