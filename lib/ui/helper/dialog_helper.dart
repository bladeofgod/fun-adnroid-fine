import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app_funandroid/generated/i18n.dart';


class DialogHelper{
  static showLoginDialog(context)async{
    return await showCupertinoDialog(context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(S.of(context).needLoginTitle),
          content: Text(S.of(context).needLogin),
          actions: <Widget>[
            CupertinoButton(
              onPressed: (){
                Navigator.of(context).pop(false);
              },
              child: new Text(
                S.of(context).cancel,
                style: TextStyle(color: Colors.black),
              ),
            ),
            CupertinoButton(
              onPressed: ()async{
                Navigator.of(context).pop();
              },
              child: Text(
                S.of(context).confirm,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ));
  }
}