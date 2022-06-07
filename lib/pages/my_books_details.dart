import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page_firebase_flutter/constants.dart';
import 'package:login_page_firebase_flutter/pages/components/action_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_page_firebase_flutter/pages/my_books_details.dart';

class MyBooksDetail extends StatelessWidget {
    final id;
    MyBooksDetail(this.id);

    



  @override
  Widget build(BuildContext context) {
    final _firestore=FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;

    //final booksRef = _firestore.collection("books");
    final booksRef2 = _firestore.collection("books").doc(id);

    print(id);

  

    return Scaffold(
      appBar: AppBar(title: Text("Detaylar"),
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder(
              stream: booksRef2.snapshots(),
              builder: (context, AsyncSnapshot asyncSnapshot){
                return Flexible(
                  child: ListView.builder(
                      itemCount:1,
                      itemBuilder:(context,index){
                          if (!asyncSnapshot.hasData) {
                            return Text("Loading");
                          }
                          return Card(
                            color: Colors.grey,
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Text("Kitap Adı:" + "${asyncSnapshot.data["bookName"]}",
                                    style: TextStyle(fontSize: 24),
                                    ),
                                    Text("Kitap Yazarı:" + "${asyncSnapshot.data["bookAuthor"]}",
                                    style: TextStyle(fontSize: 24),
                                    ),
                                    Text("Notlar:" + "${asyncSnapshot.data["bookNote"]}",
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
    );
  }
}

