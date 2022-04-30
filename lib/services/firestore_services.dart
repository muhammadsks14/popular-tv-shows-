import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_test/models/favourites_model.dart';

class FirestoreServices {
  static final FirestoreServices _firestoreServices =
      FirestoreServices._initialization();

  FirestoreServices._initialization() {
    print("firebase initialized");
  }

  factory FirestoreServices() {
    return _firestoreServices;
  }

  static FirestoreServices get firestoreServices => _firestoreServices;

  ////////////////
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String collectionName = "favourites";

  void addToFavourite(FavouriteModel favouriteModel) async {
    await firestore
        .collection(collectionName)
        .doc(favouriteModel.movieId)
        .set(favouriteModel.toMap());
  }

  void deleteFromFavourite(String docId) async {
    firestore.collection(collectionName).doc(docId).delete();
  }

  Future<List<QueryDocumentSnapshot>> getFavouriteList() async {
    var data = await firestore.collection(collectionName).get();
    return data.docs;
  }

  Future<bool> checkData(String docId) async {
    bool? checkData;
    try {
      await firestore
          .collection(collectionName)
          .doc(docId)
          .get()
          .then((value) => checkData = value.exists);
      return checkData!;
    } catch (e) {
      return false;
    }
  }
}
