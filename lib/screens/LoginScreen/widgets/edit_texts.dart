import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email",
                  enabledBorder:
                      Theme.of(context).inputDecorationTheme.disabledBorder,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)))),
          SizedBox(
            height: 35,
          ),
          TextField(
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                  enabledBorder:
                      Theme.of(context).inputDecorationTheme.disabledBorder,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)))),
          SizedBox(
            height: 25,
          ),
          Text(
            "Forget Password?",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
