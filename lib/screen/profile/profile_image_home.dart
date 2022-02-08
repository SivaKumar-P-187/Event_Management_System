import 'package:final_event/management/firebase.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/images.dart';
import 'package:final_event/string.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_event/screen/profile/empty_profile_image.dart';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({Key? key}) : super(key: key);

  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  int defaultColor = 0;
  String name = "";
  String uid = "";
  String photo = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    defaultColor = SharedPreferencesHelper.getDefaultColor();
    name = SharedPreferencesHelper.getUserName();
    uid = SharedPreferencesHelper.getUserUid();
    photo = SharedPreferencesHelper.getUserPhoto();
    email = SharedPreferencesHelper.getUserEmail();
    setState(() {});
  }

  UploadTask? task;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            CustomPaint(
              child: SizedBox(
                width: 100 * SizeConfig.widthMultiplier!,
                height: 35 * SizeConfig.heightMultiplier!,
              ),
              painter: HeaderCurvedContainer(),
            ),
          ],
        ),
        Positioned(
          top: 4 * SizeConfig.heightMultiplier!,
          left: 1.5 * SizeConfig.widthMultiplier!,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: Icon(
              Icons.arrow_back_sharp,
              size: 4 * SizeConfig.textMultiplier!,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 4 * SizeConfig.heightMultiplier!,
          right: 1.5 * SizeConfig.widthMultiplier!,
          child: Tooltip(
            message: Strings.editHintMessage,
            textStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: 2 * SizeConfig.textMultiplier!,
                ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                2 * SizeConfig.widthMultiplier!,
              ),
              color: Colors.red,
            ),
            height: 2 * SizeConfig.heightMultiplier!,
            showDuration: const Duration(seconds: 5),
            padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier!),
            preferBelow: true,
            verticalOffset: 40,
            child: Icon(
              Icons.help_outline,
              size: 4 * SizeConfig.textMultiplier!,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          // top: 12 * SizeConfig.heightMultiplier!,
          bottom: 0,
          child: GestureDetector(
            onTap: () async {
              await UserManagement().pickProfileImage(
                  source: ImageSource.gallery,
                  context: context,
                  name: name,
                  uid: uid);
              photo = SharedPreferencesHelper.getUserPhoto();
              setState(() {});
            },
            child: photo.isNotEmpty
                ? imageWidget(
                    image: photo,
                    width: 16 * SizeConfig.heightMultiplier!,
                    height: 27 * SizeConfig.widthMultiplier!,
                  )
                : Stack(
                    children: [
                      EmptyProfilePhoto(
                        height: 6 * SizeConfig.heightMultiplier!,
                        email: email,
                        colorNumber: defaultColor,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: buildEditIcon(context),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  imageWidget({String? image, double? height, double? width}) {
    return Stack(
      children: [
        ClipOval(
          child: ImagesWidget(image: photo, width: width, height: height),
        ),
        Positioned(
          bottom: 1 * SizeConfig.heightMultiplier!,
          right: 2 * SizeConfig.widthMultiplier!,
          child: buildEditIcon(context),
        ),
      ],
    );
  }

  Widget buildEditIcon(BuildContext context) {
    return buildCircle(
        child: buildCircle(
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            all: 4,
            color: Colors.blue),
        all: 2,
        color: Theme.of(context).scaffoldBackgroundColor);
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
        center: Offset.zero, radius: 3 * SizeConfig.widthMultiplier!);
    Paint paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.deepPurple,
          Colors.deepPurpleAccent,
          Colors.deepPurple,
        ],
      ).createShader(rect);
    Path path = Path()
      ..relativeLineTo(
          0, 20 * SizeConfig.heightMultiplier!) //to define x and y axis
      ..quadraticBezierTo(size.width / 2, 37 * SizeConfig.heightMultiplier!,
          size.width, 20 * SizeConfig.heightMultiplier!)
      ..relativeLineTo(
          0, -20 * SizeConfig.heightMultiplier!) //to complete the circle
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
