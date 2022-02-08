import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';

class LoginSignUpTextField extends StatefulWidget {
  final ValueChanged<String> value;
  final String hint;
  final TextInputType inputType;
  final TextCapitalization textCapitalization;
  final IconData? iconData1;
  final IconData? iconData2;
  final bool? isObscure;
  const LoginSignUpTextField({
    Key? key,
    required this.inputType,
    required this.hint,
    required this.value,
    this.textCapitalization = TextCapitalization.none,
    @required this.iconData1,
    required,
    @required this.iconData2,
    this.isObscure = false,
  }) : super(key: key);

  @override
  _LoginSignUpTextFieldState createState() => _LoginSignUpTextFieldState();
}

class _LoginSignUpTextFieldState extends State<LoginSignUpTextField> {
  late TextEditingController _controller;
  bool isLock = false;
  @override
  void initState() {
    setState(() {
      isLock = widget.isObscure!;
    });
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        left: 0 * SizeConfig.widthMultiplier!,
        top: 1 * SizeConfig.widthMultiplier!,
        bottom: 1 * SizeConfig.widthMultiplier!,
        right: 5 * SizeConfig.widthMultiplier!,
      ),
      child: TextField(
        style: Theme.of(context).textTheme.bodyText2,
        textCapitalization: widget.textCapitalization,
        controller: _controller,
        keyboardType: widget.inputType,
        obscureText: isLock,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: Theme.of(context).textTheme.bodyText1,
          suffixIcon: widget.iconData1 != null
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isLock = !isLock;
                    });
                  },
                  child: Container(
                    width: 6 * SizeConfig.widthMultiplier!,
                    height: 6 * SizeConfig.heightMultiplier!,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15 * SizeConfig.widthMultiplier!),
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: isLock
                          ? Icon(
                              widget.iconData1,
                              color: Colors.black,
                            )
                          : Icon(
                              widget.iconData2,
                              color: Colors.blue,
                            ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          border: InputBorder.none,
        ),
        onChanged: widget.value,
      ),
    );
  }
}
