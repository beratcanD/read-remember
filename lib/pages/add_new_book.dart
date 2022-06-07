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
  void dispose() {
    bookNameController.dispose();
    bookAuthorController.dispose();
    bookNoteController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Add new book"),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: kDefaultPadding,),
             Text(
              'Add new book',
              style: GoogleFonts.mako(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              )
            ),
          const SizedBox(height: kDefaultPadding * 3,),
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: kPrimaryColor),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: bookNameController,
                decoration:  InputDecoration(
                icon: Icon(Icons.book),
                hintText: 'What is your book name?',
                labelText: 'Enter a book name *',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                  horizontal: kDefaultPadding,
                ),
                ),
              ),
            ),
          ),
          const SizedBox(height: kDefaultPadding * 3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: kPrimaryColor),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: bookAuthorController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.book),
                  hintText: 'Enter a book author',
                  labelText: 'What is your book autohor? *',

                ),
              ),
            ),
          ),
          const SizedBox(height: kDefaultPadding * 3,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: kPrimaryColor),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: bookNoteController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.book),
                  hintText: 'Your notes',
                  labelText: 'Enter your notes *'
                ),
                minLines: 3,
                maxLines: 5,  // allow user to enter 5 line in textfield
                keyboardType: TextInputType.multiline
              ),
            ),
          ),
          const SizedBox(height: 50),
          ActionBtn(text: 'Add Book', press: () => _showToast(context)),
        ],
      ),
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
                content: const Text('Book has been added.'),
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
