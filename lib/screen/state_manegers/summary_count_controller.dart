import 'package:get/get.dart';

import '../../data/models/Network_response.dart';
import '../../data/services/network_caller.dart';
import '../../utils/url-.dart';
import '../../data/models/summary_count_model.dart';

class SummaryCountController extends GetxController{
   bool _getCountsummaryInprogress = false;
   SummaryCountModel _summarycountmodel = SummaryCountModel();

   bool get getCountsummaryInprogress => _getCountsummaryInprogress;
   SummaryCountModel get summarycountmodel => _summarycountmodel;

  Future<bool> getCountSummary() async {
    _getCountsummaryInprogress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.taskStatusCount);
    _getCountsummaryInprogress = false;
    if (response.issuccess) {
      _summarycountmodel = SummaryCountModel.fromJson(response.body!);
      update();
      return true;
    } else {
      return false;
    }
  }
}