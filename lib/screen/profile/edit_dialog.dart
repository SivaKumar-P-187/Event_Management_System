// ignore_for_file: sized_box_for_whitespace

import 'package:final_event/size_config.dart';
import 'package:final_event/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfile {
  Future editProfile({
    required BuildContext context,
    required String label,
    required String value,
    required TextInputType textInputType,
    required ValueChanged<String> onChanged,
    required VoidCallback onSaved,
    required VoidCallback onCancel,
    required int maxLine,
  }) {
    TextEditingController controller = TextEditingController(text: value);
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
            '${Strings.editTitle} $label',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.blue,
                ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller,
                keyboardType: textInputType,
                maxLines: maxLine,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 2 * SizeConfig.textMultiplier!,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(2 * SizeConfig.widthMultiplier!),
                  ),
                ),
                onChanged: onChanged,
              ),
            ],
          ),
          actions: [
            MaterialButton(
              onPressed: onCancel,
              color: Colors.blue,
              child: Text(
                Strings.editCancelButton,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 2 * SizeConfig.textMultiplier!),
              ),
            ),
            MaterialButton(
              onPressed: onSaved,
              color: Colors.blue,
              child: Text(
                Strings.editUpdateButton,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 2 * SizeConfig.textMultiplier!),
              ),
            ),
          ],
        );
      },
    );
  }
}
