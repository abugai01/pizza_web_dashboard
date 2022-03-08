import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    //print('$path: $data');
    await reference.set(data);
  }

  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    //print('$path: $data');
    await reference.update(data);
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('delete: $path');
    await reference.delete();
  }

  Future<T> getDocument<T>(
      {required String path,
      required T builder(
          Map<String, dynamic>? data, String documentID)}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = await reference.get();
    //final data = snapshots.data() as Map<String, dynamic>;
    return builder(snapshots.data(), snapshots.id);
  }

  // Future<List<T>> getCollection<T>(
  //     {required String path,
  //     required T builder(Map<String, dynamic>? data, String documentID)}) async {
  //   final reference = FirebaseFirestore.instance.collection(path);
  //   final snapshots = await reference.get();
  //   return snapshots.docs.map((doc) => builder(doc.data(), doc.id)).toList();
  // }

  Future<List<T>> getCollection<T>(
      {required String path,
      required T builder(Map<String, dynamic>? data, String documentID),
      Query Function(Query query)? queryBuilder,
      int Function(T lhs, T rhs)? sort}) async {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    final snapshots = await query.get();

    final result = snapshots.docs
        .map((doc) => builder(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    if (sort != null) {
      result.sort(sort);
    }
    return result;
  }

  Stream<T> documentStream<T>({
    required String path,
    required T builder(Map<String, dynamic>? data, String documentID),
  }) {
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Future<String> uploadImageToStorage(
      {required File image,
      required String path,
      required String fileName}) async {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(path + fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(image);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    return taskSnapshot.ref.getDownloadURL().then((value) => value);
  }
}
