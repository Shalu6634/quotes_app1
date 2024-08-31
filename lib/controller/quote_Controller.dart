import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quotes_app/helper/quote_helper.dart';
import 'package:quotes_app/modal/quote_modal.dart';

class QuoteController extends GetxController {
  // ApiHelper apiHelper = ApiHelper();
  // Rx<QuotesModal?> quotesModal = Rx<QuotesModal?>(null);
  //
  // Future<void> fetchData()
  // async {
  //   final data = await apiHelper.apiHelper();
  //   quotesModal.value = QuotesModal.fromMap(data);
  // }

  late QuotesModal quotesModal;
  RxList dataList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getData();
    initDb();
  }

  Future<void> initDb() async {
    await QuotesHelper.quotesHelper.database;
  }
  void favourite(int like,int id)
  {
    QuotesHelper.quotesHelper.updateData(like, id);
    getData();
  }
  Future<RxList> getData() async {
    fromAllData();
    dataList.value = await QuotesHelper.quotesHelper.readData();
    return dataList;
  }





  void fromAllData() async {
    final  data =
        await QuotesHelper.quotesHelper.fetchData();
    quotesModal = QuotesModal.fromMap(data!);

    for (int i = 0; i < quotesModal.quotes.length; i++) {
      QuotesHelper.quotesHelper.insertData(
          quotesModal.quotes[i].category,
          quotesModal.quotes[i].quote,
          quotesModal.quotes[i].author,
          quotesModal.quotes[i].description,0);
    }
  }

}
