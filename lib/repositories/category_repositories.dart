import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/category_model.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class CategoryRepository{
  CollectionReference<CategoryModel> categoryRef = FirebaseService.db.collection("categories")
      .withConverter<CategoryModel>(
    fromFirestore: (snapshot, _) {
      return CategoryModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );
    Future<List<QueryDocumentSnapshot<CategoryModel>>> getCategories() async {
    try {
      var data = await categoryRef.get();
      bool hasData = data.docs.isNotEmpty;
      if(!hasData){
        makeCategory().forEach((element) async {
          await categoryRef.add(element);
        });
      }
      final response = await categoryRef.get();
      var category = response.docs;
      return category;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<DocumentSnapshot<CategoryModel>>  getCategory(String categoryId) async {
      try{
        print(categoryId);
        final response = await categoryRef.doc(categoryId).get();
        return response;
      }catch(e){
        rethrow;
      }
  }

  List<CategoryModel> makeCategory(){
      return [
        CategoryModel(categoryName: "Brick Quality", status: "active", imageUrl: "https://www.lopochina.com/upload/image/20201028/1603861939406929.jpg"),
        CategoryModel(categoryName: "Brick Size", status: "active", imageUrl: "https://www.civilverse.org/wp-content/uploads/2020/09/brick.jpeg"),
        CategoryModel(categoryName: "worker", status: "active", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuCcvew6RWkA65T6bx-hU5mcYEJZcyH88bQw&usqp=CAU"),
        CategoryModel(categoryName: "Factory smoke outer", status: "active", imageUrl: "https://c8.alamy.com/comp/2BW1HP8/brickyard-brick-factory-near-archaeological-site-of-harappa-sahiwal-district-punjab-province-pakistan-south-asia-asia-2BW1HP8.jpg"),
        CategoryModel(categoryName: "Loader", status: "active", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQA9k768jx4KrJPQv-tpppZSmxJnF_V-MBoxg9QD7GN_vtJycRSFrju_IbyUqEnKBCzzQ&usqp=CAU"),
      ];
  }



}