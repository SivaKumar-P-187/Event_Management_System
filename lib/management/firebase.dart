import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_event/handler/error_handler.dart';
import 'package:final_event/animation/loading.dart';
import 'package:final_event/json/event_.dart';
import 'package:final_event/json/notification.dart';
import 'package:final_event/json/users_.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/user_event/user_event_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:final_event/string.dart';
import 'package:final_event/size_config.dart';

class UserManagement {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FaIcon alterFaIcon = FaIcon(
    FontAwesomeIcons.exclamationTriangle,
    size: 10 * SizeConfig.imageSizeMultiplier!,
    color: Colors.red,
  );
  FaIcon successFaIcon = FaIcon(
    FontAwesomeIcons.checkCircle,
    size: 15 * SizeConfig.imageSizeMultiplier!,
    color: Colors.green,
  );

  ///to create user with email and password and store details in firestore and navigate user to home screen
  createUser({
    required String email,
    required String password,
    required String name,
    required int number,
    required BuildContext context,
  }) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      final userInfo = UsersInfo(
        name: name,
        email: email,
        password: password,
        uid: value.user!.uid,
        colorNumber: number,
        registeredEvents: [],
        followersList: [],
        followingList: [],
        unPublishedEvent: [],
        publishedEvent: [],
        photo: "",
        phoneNo: "",
        address: "",
        dateOfBirth: "",
      ).toMap();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(value.user?.uid)
          .set(userInfo);
      await SharedPreferencesHelper.setUserName(name);
      await SharedPreferencesHelper.setDefaultColor(number);
      await SharedPreferencesHelper.setUserEmail(email);
      await SharedPreferencesHelper.setUserUid(userInfo["uid"]);
      await SharedPreferencesHelper.setPassword(password);
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      Navigator.of(context).pushReplacementNamed('/home');
    }).catchError((e) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e.toString());
    });
  }

  ///to login user with email and password and navigate user to home screen
  signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await SharedPreferencesHelper.setUserUid(value.user!.uid);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(value.user!.uid)
          .get()
          .then((value) async {
        UsersInfo userData = UsersInfo.fromMap(value.data()!);
        await storeInLocalStorage(userData: userData).then((value) {});
      }).catchError((e) {});
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      Navigator.of(context).pushReplacementNamed('/home');
    }).catchError((e) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
    });
  }

  Future storeInLocalStorage({required UsersInfo userData}) async {
    await SharedPreferencesHelper.setUserName(userData.name);
    await SharedPreferencesHelper.setUserPhoneNo(userData.phoneNo);
    await SharedPreferencesHelper.setUserUid(userData.uid);
    await SharedPreferencesHelper.setUserEmail(userData.email);
    await SharedPreferencesHelper.setPassword(userData.password);
    await SharedPreferencesHelper.setDefaultColor(userData.colorNumber);
    await SharedPreferencesHelper.setUserPhoto(userData.photo);
    await SharedPreferencesHelper.setUserAddress(userData.address);
    await SharedPreferencesHelper.setDateOfBirth(userData.dateOfBirth);
    await SharedPreferencesHelper.setUserUpcomingEvent(
        userData.registeredEvents);
  }

  ///to find find user already login or not
  currentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  ///sign out current user
  signOut({
    required BuildContext context,
  }) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await _auth.signOut().then((value) async {
      await SharedPreferencesHelper.clearStorage();
      DefaultCacheManager().emptyCache();
      imageCache!.clear();
      imageCache!.clearLiveImages();
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      Navigator.of(context).pushReplacementNamed('/login');
    }).catchError((e) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
    });
  }

  ///update user data
  updateUserData({
    required String key,
    required String uid,
    required String field,
    required BuildContext context,
  }) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({field: key}).then((value) async {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }).catchError((e) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
    });
  }

  ///update local Storage
  updateLocalName({
    required String name,
    required BuildContext context,
  }) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader);
      await SharedPreferencesHelper.setUserName(name);
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    } catch (e) {
      Navigator.pop(context);
    }
  }

  updateLocalDateOfBirth({
    required String date,
    required BuildContext context,
  }) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader);
      await SharedPreferencesHelper.setDateOfBirth(date);
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    } catch (e) {
      Navigator.pop(context);
    }
  }

  updateLocalPhoneNo({
    required String phoneNo,
    required BuildContext context,
  }) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader);
      await SharedPreferencesHelper.setUserPhoneNo(phoneNo);
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    } catch (e) {
      Navigator.pop(context);
    }
  }

  updateLocalAddress({
    required String address,
    required BuildContext context,
  }) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader);
      await SharedPreferencesHelper.setUserAddress(address);
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    } catch (e) {
      Navigator.pop(context);
    }
  }

  ///pickImage
  pickProfileImage({
    required ImageSource source,
    required BuildContext context,
    required String name,
    required String uid,
  }) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 100);
      if (image == null) return;
      final imageTemporary = File(image.path);
      await uploadProfileImage(
        image: imageTemporary.path.toString(),
        name: name,
        uid: uid,
        context: context,
      );
    } on PlatformException catch (e) {
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e.message.toString());
    }
  }

  ///upload image to fire storage
  uploadProfileImage({
    required String image,
    required String name,
    required String uid,
    required BuildContext context,
  }) async {
    UploadTask? task;
    final destination = '$uid/Profile/${image.split('/').last}';
    Dialogs.showLoadingDialog(context, _keyLoader);
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      task = ref.putFile(File(image));
    } on FirebaseException catch (e) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e.message.toString());
      return;
    }
    final snapshot = await task.whenComplete(() {});
    String imageUrl = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"photo": imageUrl}).catchError((e) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
      return;
    });
    await SharedPreferencesHelper.setUserPhoto(imageUrl);
    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
  }

  ///upload event image to fire storage
  uploadEventImage({
    required String image,
    required String uid,
    required String eventId,
    required BuildContext context,
  }) async {
    UploadTask? task;
    final destination = '$uid/My Event/$eventId';
    Dialogs.showLoadingDialog(context, _keyLoader);
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      task = ref.putFile(File(image));
    } on FirebaseException catch (e) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e.message.toString());
      return;
    }
    final snapshot = await task.whenComplete(() {});
    String imageUrl = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection("unpublished Event")
        .doc(eventId)
        .update({"event_image": imageUrl}).catchError((e) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
      return;
    });
    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
  }

  updateEventToUser(
      {required BuildContext context,
      required String userUid,
      required String eventId}) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await FirebaseFirestore.instance.collection("users").doc(userUid).update({
      "unPublishedEvent": FieldValue.arrayUnion([eventId])
    }).then((value) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }).catchError((e) async {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
      return;
    });
  }

  updateNewEvent({
    required BuildContext context,
    required Map<String, dynamic> eventDetails,
  }) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await FirebaseFirestore.instance
        // .collection("Event")
        .collection("unpublished Event")
        .doc(eventDetails["eventId"])
        .set(eventDetails)
        .catchError((e) async {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
      return;
    });
    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
  }

  Stream<List<NewEvent>> getAllEvent() {
    return FirebaseFirestore.instance
        .collection("Event")
        .where("eventDateTime",
            isGreaterThanOrEqualTo: DateTime.now().toIso8601String())
        .orderBy("eventDateTime")
        .snapshots()
        .map((event) => event.docs
            .map((newEvent) => NewEvent.fromMap(newEvent.data()))
            .toList());
  }

  Stream<NewEvent> getEvent({
    required String eventUid,
    required String collectionName,
  }) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(eventUid)
        .snapshots()
        .map(
          (event) => NewEvent.fromMap(event.data()!),
        );
  }

  Stream<List<NewEvent>> getUserEventPublished({required String userUid}) {
    return FirebaseFirestore.instance
        .collection("Event")
        .where("create_user_uid", isEqualTo: userUid)
        .where("isPublished", isEqualTo: true)
        .snapshots()
        .map((event) => event.docs
            .map((newEvent) => NewEvent.fromMap(newEvent.data()))
            .toList());
  }

  Stream<List<NewEvent>> getUserEventNotPublished({required String userUid}) {
    return FirebaseFirestore.instance
        .collection("unpublished Event")
        .where("create_user_uid", isEqualTo: userUid)
        .where("isPublished", isEqualTo: false)
        .snapshots()
        .map((event) => event.docs
            .map((newEvent) => NewEvent.fromMap(newEvent.data()))
            .toList());
  }

  updatePublishedEvent(
      {required String eventUid,
      required BuildContext context,
      required String collectionName}) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(eventUid)
        .update({"isPublished": true}).then((value) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }).catchError((e) async {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
    });
  }

  deletePublishedInUnPublished({
    required String eventUid,
    required BuildContext context,
  }) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await FirebaseFirestore.instance
        .collection("unpublished Event")
        .doc(eventUid)
        .delete()
        .then((value) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const UserEventHome()));
      ErrorHandler().errorDialog(
          title: "",
          context: context,
          faIcon: successFaIcon,
          message: Strings.eventPublishedMessage);
    }).catchError((e) async {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
    });
  }

  updateToEvent({
    required String eventUid,
    required BuildContext context,
    required NewEvent event,
  }) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await FirebaseFirestore.instance
        .collection("Event")
        .doc(eventUid)
        .set(event.toMap())
        .then((value) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }).catchError((e) async {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
    });
  }

  updatePublishedEventToUser(
      {required String eventUid,
      required BuildContext context,
      required String userUid,
      required NewEvent event}) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    FirebaseFirestore.instance.collection("users").doc(userUid).update({
      "publishedEvent": FieldValue.arrayUnion([eventUid]),
      "unPublishedEvent": FieldValue.arrayRemove([eventUid]),
    }).then((value) async {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }).catchError((e) async {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
    });
  }

  Stream<UsersInfo> getParticularUserInfo({required String uid}) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((user) => UsersInfo.fromMap(user.data()!));
  }

  Future addUserToEvent({
    required String uid,
    required String eventId,
    required BuildContext context,
  }) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await FirebaseFirestore.instance.collection("Event").doc(eventId).update(
      {
        "participants": FieldValue.arrayUnion(
          [uid],
        ),
      },
    ).then((value) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
        title: Strings.eventRegistrationTitle,
        context: context,
        faIcon: successFaIcon,
        message: Strings.eventRegistrationComplete,
      );
    }).catchError((e) async {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
      return;
    });
  }

  addEventTOUser({
    required String uid,
    required String eventId,
    required BuildContext context,
  }) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await FirebaseFirestore.instance.collection("users").doc(uid).update(
      {
        "registeredEvents": FieldValue.arrayUnion([eventId]),
      },
    ).then((value) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }).catchError((e) async {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
      return;
    });
  }

  Future removeUserToEvent({
    required String uid,
    required String eventId,
    required BuildContext context,
  }) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await FirebaseFirestore.instance.collection("Event").doc(eventId).update(
      {
        "participants": FieldValue.arrayRemove(
          [uid],
        ),
      },
    ).then((value) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }).catchError((e) async {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
      return;
    });
  }

  removeEventTOUser({
    required String uid,
    required String eventId,
    required BuildContext context,
  }) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await FirebaseFirestore.instance.collection("users").doc(uid).update(
      {
        "registeredEvents": FieldValue.arrayRemove([eventId]),
      },
    ).then((value) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }).catchError((e) async {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
      return;
    });
  }

  Stream<List<NewEvent>> getUserRegisteredEvents({
    required List<String> eventId,
    required BuildContext context,
  }) {
    return FirebaseFirestore.instance
        .collection("Event")
        .where("eventId", whereIn: eventId)
        .snapshots()
        .map((event) => event.docs
            .map((newEvent) => NewEvent.fromMap(newEvent.data()))
            .toList());
  }

  addUserFollowingList({required String userUid, required String uid}) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      "followingList": FieldValue.arrayUnion([userUid]),
    });
  }

  addUserFollowersList({required String userUid, required String uid}) async {
    await FirebaseFirestore.instance.collection("users").doc(userUid).update({
      "followersList": FieldValue.arrayUnion([uid]),
    });
  }

  removeUserFollowingList(
      {required String userUid, required String uid}) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      "followingList": FieldValue.arrayRemove([userUid]),
    });
  }

  removeUserFollowerList({required String userUid, required String uid}) async {
    await FirebaseFirestore.instance.collection("users").doc(userUid).update({
      "followersList": FieldValue.arrayRemove([uid]),
    });
  }

  Stream<List<UsersInfo>> getAllFollowingUsers(
      {required List<String> userUid}) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("uid", whereIn: userUid)
        .snapshots()
        .map((users) =>
            users.docs.map((user) => UsersInfo.fromMap(user.data())).toList());
  }

  addNotificationToUser({
    required String userUid,
    required String notificationId,
    required BuildContext context,
    required Map<String, dynamic> notificationMap,
  }) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userUid)
        .collection("notifications")
        .doc(notificationId)
        .set(notificationMap)
        .then((value) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      createSnackBar(
          message: "Invitation successfully send...", context: context);
    }).catchError((e) async {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
      return;
    });
  }

  Stream<List<NotificationJson>> getUserNotification({
    required String userUid,
  }) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userUid)
        .collection("notifications")
        .orderBy("dateTime")
        .snapshots()
        .map(
          (notification) => notification.docs
              .map(
                (notify) => NotificationJson.fromMap(notify.data()),
              )
              .toList(),
        );
  }

  deleteParticularNotification({
    required String userUid,
    required String notificationId,
    required BuildContext context,
  }) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userUid)
        .collection("notifications")
        .doc(notificationId)
        .delete()
        .then((value) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }).catchError((e) async {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: alterFaIcon,
          message: e);
      return;
    });
  }

  Future<QuerySnapshot> getFollowersList({required String userUid}) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where('uid', isEqualTo: userUid)
        .get();
  }

  void createSnackBar({
    required String message,
    required BuildContext context,
  }) {
    final snackBar = SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: 2 * SizeConfig.textMultiplier!,
              ),
        ),
        backgroundColor: Colors.black);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
