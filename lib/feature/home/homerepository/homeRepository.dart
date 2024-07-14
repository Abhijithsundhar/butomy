import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:techbutomy/core/constants/firebaseConstants/firebaseConstants.dart';
import 'package:techbutomy/core/failure.dart';
import 'package:techbutomy/core/typedef.dart';
import 'dart:convert';
import 'package:techbutomy/model/categoryModel.dart';
import 'package:techbutomy/model/userModel.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository();
});

class CategoryRepository {
  ///api
  FutureEither<CategoryModel> fetchCategories() async {
    final response = await http.get(Uri.parse('https://yip-dev.techbutomy.com/api/category-list'));

    try{
      if (response.statusCode == 200) {
        CategoryModel categories =CategoryModel.fromJson(jsonDecode(response.body));

        return right(categories);
      } else {
        throw Exception('Failed to load categories');

      }
    }catch (e){
      return left(Failure(failure: e.toString()));
    }
  }

  ///user stream
  Stream<UserModel> currentUser() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return Stream.error('No user logged in');
    }
    final String currentUserId = currentUser.uid;
    return FirebaseFirestore.instance
        .collection(FirebaseCollections.usersCollection)
        .doc(currentUserId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) {
        throw Exception('User not found');
      }
      return UserModel.fromMap(doc.data()!);
    });
  }

  /// logout
  Future<Either<Failure, void>> deleteUserOnLogout() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        // Handle the case when the user is not logged in
        throw 'No user logged in';
      }

      final String currentUserId = currentUser.uid;

      await FirebaseFirestore.instance
          .collection(FirebaseCollections.usersCollection)
          .doc(currentUserId)
          .delete();

      await currentUser.delete();

      await FirebaseAuth.instance.signOut();

      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(Failure(failure: e.message ?? 'An error occurred'));
    } on FirebaseException catch (e) {
      return left(Failure(failure: e.message ?? 'An error occurred'));
    } catch (e) {
      return left(Failure(failure: e.toString()));
    }
  }}