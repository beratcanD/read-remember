import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page_firebase_flutter/constants.dart';
import 'package:login_page_firebase_flutter/pages/components/action_btn.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewBook extends StatefulWidget {
  const AddNewBook({Key? key}) : super(key: key);

  @override
  State<AddNewBook> createState() => _AddNewBookState();
}

class _AddNewBookState extends State<AddNewBook> {
  final user = FirebaseAuth.instance.currentUser!;
  final books = FirebaseFirestore.instance.collection('books');

  TextEditingController bookNameController = TextEditingController();
  TextEditingController bookAuthorController = TextEditingController();
  TextEditingController bookNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                child: Text(
                  'Yeni Kitap Ekle',
                  style: GoogleFonts.mako(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  )
                ),
                padding: EdgeInsets.only(bottom: 30, top: 60)
              ),
              TextFormField(
                controller: bookNameController,
                decoration: const InputDecoration(
                icon: Icon(Icons.book),
                hintText: 'Kitabınızın ismi?',
                labelText: 'Kitap ismini giriniz *',
                )
              ),
              TextFormField(
                controller: bookAuthorController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.book),
                  hintText: 'Kitabınızın Yazarı?',
                  labelText: 'Kitabınızın yazarını giriniz *',

                ),
              ),
              TextFormField(
                controller: bookNoteController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.book),
                  hintText: 'Aldınığınız notlar',
                  labelText: 'Notlarınızı girebilirsiniz *'
                ),
                minLines: 3,
                maxLines: 5,  // allow user to enter 5 line in textfield
                keyboardType: TextInputType.multiline
              ),
              const SizedBox(height: kDefaultPadding),
              ActionBtn(text: 'Kitabı Ekle', press: () => _showToast(context)),
            ],
          )),
          )
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    books.add({
            'userId': user.uid,
            'bookName': bookNameController.text,
            'bookAuthor': bookAuthorController.text,
            'bookNote': bookNoteController.text
          })
          .then((value) => {
            scaffold.showSnackBar(
              SnackBar(
                content: const Text('Kitap Eklendi.'),
                action: SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
              )
            ),
            bookNameController.text = "",
            bookAuthorController.text = "",
            bookNoteController.text = ""
          })
          .catchError((error) => print("Failed to add user: $error"));
  }
}
