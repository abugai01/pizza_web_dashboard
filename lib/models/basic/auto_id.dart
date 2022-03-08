import 'package:uuid/uuid.dart';

abstract class AutoId {
  String? id;
  bool isLoading = false;
  bool submitted = false;

  AutoId(String? id) {
    this.id = id ?? Uuid().v1();
  }

  Map<String, dynamic> toMap();
}
