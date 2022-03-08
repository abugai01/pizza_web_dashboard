import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza_web_dashboard/helpers/functions.dart';
import 'package:pizza_web_dashboard/models/basic/profile.dart';

class User {
  static const ID = 'id';
  static const NAME = 'name';
  static const SURNAME = 'surname';
  static const PHONE = 'phone';
  static const EMAIL = 'email';
  static const BIRTHDAY = 'birthday';
  //static const PROFILE = 'profile';

  late String id;
  String? name;
  String? surname;
  String? email;
  String? phone;
  DateTime? birthday;
  //Profile profile;

  //Для отметки пустых значений из Firestore
  bool isNull;

  User({
    required this.id,
    this.name,
    this.surname,
    this.email,
    this.phone,
    this.birthday,
    //required this.profile,
    this.isNull = false,
  });

  static fromMap(Map<String, dynamic>? data, String documentId) {
    if (data == null) return User(id: documentId, isNull: true);

    //final profile = Profile.fromMap(data?[PROFILE]);
    final DateTime? birthday = data[BIRTHDAY] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            (data[BIRTHDAY].millisecondsSinceEpoch));

    return User(
      id: documentId,
      name: data[NAME],
      surname: data[SURNAME],
      email: data[EMAIL],
      phone: data[PHONE],
      birthday: birthday,
      //profile: profile,
    );
  }

  String get fullName =>
      ((name == null) ? '' : name!) +
      ((surname == null) ? '' : (' ' + surname!));
}
