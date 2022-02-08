// ignore_for_file: sized_box_for_whitespace

import 'package:final_event/size_config.dart';
import 'package:final_event/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ErrorHandler {
  //Error Dialogs
  Future errorDialog({
    required BuildContext context,
    required String title,
    required String message,
    required FaIcon faIcon,
  }) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              2 * SizeConfig.widthMultiplier!,
            ),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.blue,
                ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: faIcon,
              ),
              SizedBox(
                height: 1 * SizeConfig.heightMultiplier!,
              ),
              Container(
                height: 10 * SizeConfig.heightMultiplier!,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(2 * SizeConfig.widthMultiplier!),
                ),
                child: Center(
                  child: Text(
                    message.toString(),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier!,
              ),
              Container(
                height: 3 * SizeConfig.heightMultiplier!,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        Strings.errorOkButton,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
