import 'package:get/get.dart';
import 'package:quotes_app/controller/quote_Controller.dart';
import 'package:quotes_app/helper/favourite_helper.dart';


class FavouriteController extends GetxController {
  RxList categoriesList = [].obs;
  RxList folderList = [].obs;
  RxList idList = [].obs;
  QuoteController quoteController = Get.put(QuoteController());

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> initDb() async {
    await FavouriteHelper.favouriteHelper.database;
  }


  void favourite(int like, int id) {
    FavouriteHelper.favouriteHelper.updateData(like, id);
    getData();
  }

  void folderData() {
    folderList = [].obs;
    categoriesList = [].obs;
    for (int i = 0; i < quoteController.dataList.length; i++) {
      if (quoteController.dataList[i]['like'] == 1) {
        folderList.add(quoteController.dataList[i]['category']);
      }
    }
    showFolderLikeCategory();

    print('$folderList======================================');
    print('$idList======================================');
    print('$categoriesList======================================');
  }

  Future<RxList> getData() async {
    idList.value = await FavouriteHelper.favouriteHelper.readData();
    return idList;
  }

  Future<RxList> showCategoryLikeData(String category) async {
    idList.value =
        await FavouriteHelper.favouriteHelper.showCategoryWiseData(category);
    return idList;
  }

  Future<void> insertData(String category, String quote, String author,
      String description, int like) async {
    FavouriteHelper.favouriteHelper
        .insertData(category, quote, author, description, like);
    await getData();
  }

  void showFolderLikeCategory() {
    bool isvalue = false;
    for (int i = 0; i < folderList.length; i++) {
      for (int j = 0; j < categoriesList.length; j++) {
        if (folderList[i] == categoriesList[j]) {
          isvalue = true;
        }
      }
      if (isvalue == false) {
        categoriesList.add(folderList[i]);
      }
      isvalue = false;
    }
  }

  Future<void> removeFavouriteData(int index) async {
    folderList.removeAt(index);
    folderData();
  }

  Future<void> updateFavouriteData(int like, int id) async {
    FavouriteHelper.favouriteHelper.updateData(like, id);
    await getData();
  }

  void removeData(int id)
  {
    FavouriteHelper.favouriteHelper.deleteData(id);
    getData();
    showFolderLikeCategory();
  }
}
