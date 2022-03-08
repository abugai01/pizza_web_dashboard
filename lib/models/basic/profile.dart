class Profile {
  static const NAME = 'name';
  static const SURNAME = 'surname';
  static const BIRTHDAY = 'birthday';
  static const EMAIL = 'email';
  static const PHONE = 'phone';
  static const AVATAR = 'avatar';

  String? name;
  String? surname;
  DateTime? birthday;
  String? email;
  String? phone;
  String? avatar;

  Profile(
      {this.name,
      this.surname,
      this.birthday,
      this.email,
      this.phone,
      this.avatar});

  static fromMap(Map<String, dynamic>? data) {
    final birthday = data?[BIRTHDAY] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            data![BIRTHDAY].millisecondsSinceEpoch);

    return Profile(
        birthday: birthday,
        name: data?[NAME],
        surname: data?[SURNAME],
        email: data?[EMAIL],
        phone: data?[PHONE],
        avatar: data?[AVATAR]);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      NAME: this.name,
      SURNAME: this.surname,
      BIRTHDAY: this.birthday,
      EMAIL: this.email,
      PHONE: this.phone,
      AVATAR: this.avatar,
    };
  }

  Profile copy(
      {String? name,
      String? surname,
      DateTime? birthday,
      String? phone,
      String? email,
      String? avatar}) {
    return Profile(
      name: (name == null || name == '') ? this.name : name,
      surname: (surname == null || surname == '') ? this.surname : surname,
      birthday: (birthday == null) ? this.birthday : birthday,
      email: (email == null || email == '') ? this.email : email,
      phone: (phone == null || phone == '') ? this.phone : phone,
      avatar: (avatar == null || avatar == '') ? this.avatar : avatar,
    );
  }

  String get fullName => ((name == null) ? '' : name!) + ((surname == null) ? '' : (' ' + surname!));
}
