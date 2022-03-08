import 'package:equatable/equatable.dart';

class Simple extends Equatable {
  static const ID = 'id';
  static const NAME = 'name';

  final String? id;
  final String? name;

  Simple({this.id, this.name});

  @override
  List<Object?> get props => [id, name];

  factory Simple.fromMap(Map<String, dynamic>? data, String? documentId) {
    final name = data?[NAME];
    final id = data?[ID] ?? documentId;

    return Simple(id: id, name: name);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{ID: this.id, NAME: this.name};
  }

  @override
  String toString() {
    return 'id: $id, name: $name';
  }
}
