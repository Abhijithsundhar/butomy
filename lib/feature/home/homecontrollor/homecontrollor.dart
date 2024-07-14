import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbutomy/core/common/snackbar.dart';
import 'package:techbutomy/feature/home/homerepository/homeRepository.dart';
import 'package:techbutomy/model/categoryModel.dart';
import 'package:techbutomy/model/userModel.dart';

final categoryControllerProvider = Provider<CategoryController>((ref) {
  return CategoryController(repository: ref.read(categoryRepositoryProvider));
});

final userStreamProvider = StreamProvider((ref)=> ref.read(categoryControllerProvider).user());

class CategoryController {
  final CategoryRepository _repository;

  CategoryController({required CategoryRepository repository}) : _repository = repository;

  Future<CategoryModel?> fetchCategories() async {
    CategoryModel? data;
    final res = await _repository.fetchCategories();
    res.fold((l) {
      print(l.failure);
    }, (r) {
      data = r;
    });
    return data;
  }

  ///stream to get user
  Stream<UserModel>user(){
    return _repository.currentUser();
  }

  ///logout
  deleteUser(UserModel userModel,BuildContext context) async {
    // FirebaseFirestore.instance.collection('users')
    //          .doc(data?[index].id).delete();

    const snackBar = SnackBar(
      content: Text('user deleted'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // Model= data?[index];
    var deleteUser =await _repository.deleteUserOnLogout();
    deleteUser.fold((l) => showSnackBar(context,l.failure.toString()),
            (r) => showSnackBar(context,''));
  }

}

final dataProvider = FutureProvider<CategoryModel?>(
    (ref) => ref.watch(categoryControllerProvider).fetchCategories());
