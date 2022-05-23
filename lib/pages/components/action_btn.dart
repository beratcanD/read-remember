import 'package:flutter/material.dart';

import '../../constants.dart';

class ActionBtn extends StatelessWidget {
  const ActionBtn({
    Key? key, required this.text, this.press,
  }) : super(key: key);

  final String text;
  final void Function()? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        height: 84,
        width: double.infinity,
        child: TextButton(
          onPressed: press,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
      ),
    );
  }
}
