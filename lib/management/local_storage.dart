import 'dart:convert';

import 'package:final_event/json/event_.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _preferences;
  static const _keyUserName = 'username';
  static const _keyUserUid = 'userUid';
  static const _keyUserEmail = 'userEmail';
  static const _keyUserPhoto = 'userPhoto';
  static const _keyUserAddress = 'userAddress';
  static const _keyUpcomingEvent = 'eventUpcomingEvent';
  static const _keyDefaultColor = 'defaultColor';
  static const _keyFollowingList = 'followingList';
  static const _keyDateOfBirth = 'userDateOfBirth';
  static const _keyUserPassword = 'userPassword';
  static const _keyUserPhone = 'userPhoneNo';

  ///initialize shared preference
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  ///clear storage
  static Future clearStorage() async => _preferences!.clear();

  ///store data
  static Future setUserName(String userName) async =>
      await _preferences!.setString(_keyUserName, userName);
  static Future setUserUid(String uid) async =>
      await _preferences!.setString(_keyUserUid, uid);
  static Future setUserEmail(String userEmail) async =>
      await _preferences!.setString(_keyUserEmail, userEmail);
  static Future setUserPhoto(String userPhoto) async =>
      await _preferences!.setString(_keyUserPhoto, userPhoto);
  static Future setUserAddress(String userAddress) async =>
      await _preferences!.setString(_keyUserAddress, userAddress);
  static Future setUserPhoneNo(String phoneNo) async =>
      await _preferences!.setString(_keyUserPhone, phoneNo);
  static Future setPassword(String password) async =>
      await _preferences!.setString(_keyUserPassword, password);
  static Future setDateOfBirth(String dateOfBirth) async =>
      await _preferences!.setString(_keyDateOfBirth, dateOfBirth);
  static Future setDefaultColor(int number) async =>
      await _preferences!.setInt(_keyDefaultColor, number);
  static Future setUserUpcomingEvent(List<String> upcomingEvent) async =>
      await _preferences!.setStringList(_keyUpcomingEvent, upcomingEvent);
  static Future setFollowingList(List<String> followingList) async =>
      await _preferences!.setStringList(_keyFollowingList, followingList);
  // static Future setNewEvent(List<NewEvent> event) async {
  //   _preferences!.remove(_keyNewEvent);
  //   await _preferences!.setString(_keyNewEvent, encode(event));
  // }

  static String encode(List<NewEvent> event) => json.encode(
      event.map<Map<String, dynamic>>((event) => event.toMap()).toList());

  ///get data
  static String getUserName() => _preferences!.getString(_keyUserName) ?? "";
  static String getUserUid() => _preferences!.getString(_keyUserUid) ?? "";
  static String getUserEmail() => _preferences!.getString(_keyUserEmail) ?? "";
  static String getUserPhoto() => _preferences!.getString(_keyUserPhoto) ?? "";
  static String getUserAddress() =>
      _preferences!.getString(_keyUserAddress) ?? "";
  static String getPassword() =>
      _preferences!.getString(_keyUserPassword) ?? "";
  static String getDateOfBirth() =>
      _preferences!.getString(_keyDateOfBirth) ?? "";
  static String getUserPhoneNo() =>
      _preferences!.getString(_keyUserPhone) ?? "";
  static int getDefaultColor() => _preferences!.getInt(_keyDefaultColor) ?? 0;
  static List<String> getUpcomingEvent() =>
      _preferences!.getStringList(_keyUpcomingEvent) ?? [];
  static List<String> getFollowingList() =>
      _preferences!.getStringList(_keyFollowingList) ?? [];
  // static List<NewEvent> getNewEvent() {
  //   String getStringEvent = _preferences!.getString(_keyNewEvent) ?? "";
  //   if (getStringEvent.isEmpty) {
  //     return [];
  //   }
  //   List<NewEvent> event = decode(getStringEvent);
  //   return event;
  // }

  static List<NewEvent> decode(String event) =>
      (json.decode(event) as List<dynamic>)
          .map<NewEvent>((event) => NewEvent.fromMap(event))
          .toList();
}
