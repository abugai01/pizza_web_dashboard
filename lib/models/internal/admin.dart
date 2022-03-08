class Admin {
  static const USER_ID = 'userId';
  static const EMAIL = 'email';

  String? userId;
  String? email;

  Admin({this.userId, this.email});

  static Admin fromMap(Map<String, dynamic>? data) =>
      Admin(userId: data?[USER_ID], email: data?[EMAIL]);
}
