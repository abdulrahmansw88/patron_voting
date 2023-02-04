import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class ReportsController extends GetxController{
  List<FlSpot> list = <FlSpot>[].obs;
  var today = DateTime.now();
  RxInt todayVotes = 0.obs;
  RxInt yesterdayVotes = 0.obs;
  RxInt twoDayAgoVotes = 0.obs;
  RxInt threeDayAgoVotes = 0.obs;
  RxInt fourDayAgoVotes = 0.obs;
  @override
  void onInit() {

    FirebaseFirestore.instance.collection('votes').get().then((value) {
      final allData = value.docs.map((doc) => doc.id).toList();
      List.generate(allData.length, (index) {
        if(today.difference(DateTime.fromMicrosecondsSinceEpoch(int.parse(allData[index]))).inDays == 0 ){
          todayVotes++;
        }else if(today.difference(DateTime.fromMicrosecondsSinceEpoch(int.parse(allData[index]))).inDays == 1){
          yesterdayVotes++;
        }else if(today.difference(DateTime.fromMicrosecondsSinceEpoch(int.parse(allData[index]))).inDays == 2){
          twoDayAgoVotes++;
        }else if(today.difference(DateTime.fromMicrosecondsSinceEpoch(int.parse(allData[index]))).inDays == 3){
          threeDayAgoVotes++;
        }else if(today.difference(DateTime.fromMicrosecondsSinceEpoch(int.parse(allData[index]))).inDays == 4){
          fourDayAgoVotes++;
        }
      });
    });
    super.onInit();
  }




  /// Creates a [TimeSeriesChart] with sample data and no transition.
  // factory TimeSeriesBar.withSampleData() {
  //   return TimeSeriesBar(
  //
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }
}
