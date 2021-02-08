import 'package:flutter/material.dart';

class LoginOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Container()),
          CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Container())
        ],
      ),
    );
  }
}
