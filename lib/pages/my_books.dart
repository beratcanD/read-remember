import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page_firebase_flutter/constants.dart';
import 'package:login_page_firebase_flutter/pages/components/action_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_page_firebase_flutter/pages/my_books_details.dart';

class MyBooks extends StatefulWidget {
  const MyBooks({Key? key}) : super(key: key);

  @override
  State<MyBooks> createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  get booksNames => null;
  final _firestore=FirebaseFirestore.instance;


  Widget build(BuildContext context) {
    CollectionReference booksRef=_firestore.collection("books");

    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: booksRef.snapshots(),
                builder:(BuildContext context, AsyncSnapshot asyncSnapshot){
                  if (asyncSnapshot.hasError){
                    return Center(
                      child: Text("Bir hata oluştu tekrar deneyiniz."),
                    );
                  }
                  else{
                    if(asyncSnapshot.hasData){
                      List<DocumentSnapshot> listOfDocumentSnap =
                          asyncSnapshot.data.docs;
                      return Flexible(
                        child: ListView.builder(
                            itemCount: listOfDocumentSnap.length,
                            itemBuilder:(context, index){
                              return Card(
                                color: Colors.grey,
                                child: ListTile(
                                  title:Text(
                                      "${listOfDocumentSnap[index]["bookName"]}",
                                      style: TextStyle(fontSize: 24) ),
                                  subtitle: Text(
                                    "${listOfDocumentSnap[index]["bookAuthor"]}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  trailing:IconButton(icon: Icon(Icons.delete),
                                  onPressed: () async{

                                   await listOfDocumentSnap[index].reference.delete();

                                  },
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute (builder: (context) => MyBooksDetail(index)));
                                  },
                                ),
                              );
                            }
                        ),
                      );
                    }else{
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                },
              )
            ],
          )
          ),
        ),
      );
  }
}
