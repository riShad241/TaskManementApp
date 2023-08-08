import 'package:flutter/material.dart';
import 'package:real_todo/data/models/Network_response.dart';
import 'package:real_todo/data/models/summary_count_model.dart';
import 'package:real_todo/data/services/network_caller.dart';
import 'package:real_todo/screen/add_newTask.dart';
import 'package:real_todo/utils/url-.dart';
import '../Widget/TaskListTile.dart';
import '../Widget/UserprofileBaner.dart';
import '../Widget/summary_card.dart';
class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  bool _getCountsummaryInprogress = false;
  SummaryCountModel summaryCountModel =SummaryCountModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCountSummary();
    });
  }

  Future<void> getCountSummary() async{
    _getCountsummaryInprogress = true;
    if(mounted){
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.taskStatusCount);
    if(response.issuccess){
      summaryCountModel = SummaryCountModel.fromJson(response.body!);
    }else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Summary data get failed")));
      }
    }
    _getCountsummaryInprogress = false;
    if(mounted){
      setState(() {});
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const userProfileBanare(),
            Padding(
             padding: const EdgeInsets.all(8.0),
             child: _getCountsummaryInprogress ? const LinearProgressIndicator() : const Row(
                children:  [
                  Expanded(child: sumarreay_card(title: 'New', number: '124',)),
                  Expanded(child: sumarreay_card(title: 'progress', number: '124',)),
                  Expanded(child: sumarreay_card(title: 'cancel', number: '124',)),
                  Expanded(child: sumarreay_card(title: 'Completed', number: '124',)),
                ],
              ),
           ),
            Expanded(
              child: ListView.separated(
                  itemCount: 20,
                  itemBuilder: (context,index){
                    return  TaskListTile(txt: 'New', color: Colors.blue.shade300,);
                  },
              separatorBuilder: (BuildContext context, int index){
                    return const Divider();
              },),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddNewTask()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}






