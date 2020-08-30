import 'package:downtimealarmmobile/database/firestorefunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'downtime.dart';
import 'alarm.dart';
import 'filteralarmlist.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';



import 'package:flutter/foundation.dart';



void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Define the default font family.
        fontFamily: 'Verdana',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 16.0,  fontWeight: FontWeight.bold),
          bodyText2: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.normal),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  Downtime currentDowntime;
  List <Alarm> _filteredAlarmList;



  @override
  Widget build(BuildContext context) {


//    final realTimeAlarms = fb.FirebaseDatabase.instance
//        .reference().child('downtimealarm')
//

    var _firebaseRef = FirebaseDatabase().reference().child('Sheet1').limitToFirst(10);


    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    DateTime now = DateTime.now();
    DateTime fourMonthsAgo = now.subtract(Duration(days: 90));

    return Scaffold(
      appBar: AppBar(
        title: Text('Downtime Allocator'),
      ),
      body: Center(child: StreamBuilder(
          stream: Firestore.instance
              .collection('downtimes')
              .limit(50)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {

              List<Downtime> _downtimeList = snapshot.data.documents.map<Downtime>((item) {
                return Downtime.fromSnapshot(item);
              }).toList();

              //currentDowntime = _downtimeList.firstWhere((downtime) => downtime.assigned == false, orElse: () => null);
              currentDowntime = _downtimeList[0];

              DateTime currentDowntimeStartDate = currentDowntime.startTime.toDate();
              DateTime currentDowntimeEndDate = currentDowntime.endTime.toDate();

              String currentDowntimeStartString = DateFormat('dd/MM/yyyy hh:mm:ss').format(currentDowntimeStartDate);
              String currentDowntimeEndString = DateFormat('dd/MM/yyyy hh:mm:ss').format(currentDowntimeEndDate);

              var causeLocationArray = currentDowntime.causeLocation.split('.');
              var causeArray = currentDowntime.cause.split(' ');
              var equipmentTypeArray = currentDowntime.equipmentType.split(' ');
              var effectArray = currentDowntime.effect.split(' ');
              var eplanation1Array = currentDowntime.explanation.split(' ');
              var eplanation2Array = currentDowntime.explanation2.split(' ');
              var commentArray = currentDowntime.comments.split(' ');
              List <String> keywords = [];
              keywords.addAll(causeLocationArray);
              keywords.addAll(causeArray);
              keywords.addAll(equipmentTypeArray);
              keywords.addAll(effectArray);
              keywords.addAll(eplanation1Array);
              keywords.addAll(eplanation2Array);
              keywords.addAll(commentArray);
              keywords.removeWhere((item) =>
              item.toUpperCase() == '' ||
                  item.toUpperCase() == ' ' ||
                  item.toUpperCase() == ' -' ||
                  item.toUpperCase() == '- ' ||
                  item.toUpperCase() == '#' ||
                  item.toUpperCase() == '1' ||
                  item.toUpperCase() == '2' ||
                  item.toUpperCase() == '#' ||
                  item.toUpperCase() == 'of'.toUpperCase()  ||
                  item.toUpperCase() == 'and'.toUpperCase() ||
                  item.toUpperCase() == 'shift'.toUpperCase()  ||
                  item.toUpperCase() == 'Low'.toUpperCase() ||
                  item.toUpperCase() == 'low'.toUpperCase() ||
                  item.toUpperCase() == 'Pilbara Iron'.toUpperCase() ||
                  item.toUpperCase() == 'Marandoo'.toUpperCase() ||
                  item.toUpperCase() == '-' ||
                  item.toUpperCase() == 'Trip'.toUpperCase() ||
                  item.toUpperCase() == 'Plant'.toUpperCase() ||
                  item.toUpperCase() == 'Not'.toUpperCase() ||
                  item.toUpperCase() == 'Defined'.toUpperCase() ||
                  item.toUpperCase() == 'Circuit'.toUpperCase() ||
                  item.toUpperCase() == 'A' ||
                  item.toUpperCase() == 'B' ||
                  item.toUpperCase() == 'Plant - Module 1'.toUpperCase() ||
                  item.toUpperCase() == 'Plant - Module 2'.toUpperCase() ||
                  item.toUpperCase() == 'Product'.toUpperCase() ||
                  item.toUpperCase() == 'For'.toUpperCase() ||
                  item.toUpperCase() == 'In'.toUpperCase() ||
                  item.toUpperCase() == 'Truck'.toUpperCase() ||
                  item.toUpperCase() == 'Wait'.toUpperCase() ||
                  item.toUpperCase() == 'trucks'.toUpperCase() ||
                  item.toUpperCase() == 'Gaps'.toUpperCase() ||
                  item.toUpperCase() == 'Gap'.toUpperCase() ||
                  item.toUpperCase() == 'to'.toUpperCase() ||
                  item.toUpperCase() == 'Fault'.toUpperCase() ||
                  item.toUpperCase() == 'Pit'.toUpperCase() ||
                  item.toUpperCase() == 'change'.toUpperCase() ||
                  item.toUpperCase() == 'area'.toUpperCase() ||
                  item.toUpperCase() == 'high'.toUpperCase() ||
                  item.toUpperCase() == '&' ||
                  item.toUpperCase() == 'loss'.toUpperCase() ||
                  item.toUpperCase() == 'control'.toUpperCase() ||
                  item.toUpperCase() == 'system'.toUpperCase() ||
                  item.toUpperCase() == 'faults'.toUpperCase() ||
                  item.toUpperCase() == 'process'.toUpperCase() ||
                  item.toUpperCase() == 'delay'.toUpperCase() ||
                  item.toUpperCase() == 'appropriate'.toUpperCase() ||
                  item.toUpperCase() == 'cause'.toUpperCase() ||
                  item.toUpperCase() == 'code'.toUpperCase() ||
                  item.toUpperCase() == 'available'.toUpperCase() ||
                  item.toUpperCase() == 'from'.toUpperCase() ||
                  item.toUpperCase() == 'up'.toUpperCase() ||
                  item.toUpperCase() == 'reduced'.toUpperCase() ||
                  item.toUpperCase() == 'rates'.toUpperCase() ||
                  item.toUpperCase() == 'trips'.toUpperCase() ||
                  item.toUpperCase() == 'operational'.toUpperCase() ||
                  item.toUpperCase() == 'type'.toUpperCase() ||
                  item.toUpperCase() == 'low'.toUpperCase()

              );


              List<String> keywordEdited =  keywords.map(
                      (String e) => e.toUpperCase()
                      .replaceAll(',', '')
                      .replaceAll('-', '')
                      .replaceAll('#', '')
                      .replaceAll('.', '')
                      .replaceAll('(', '')
                      .replaceAll(')', '')
                      .replaceAll(':', '')

              ).toList();

              keywordEdited.toSet().toList();

              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: width/3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 150, child: Text('Effect: ', style: Theme.of(context).textTheme.headline6,)),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text(currentDowntime.effect.toString(), style: Theme.of(context).textTheme.bodyText2,)),
                                  ],
                                ),

                                Row(
                                  children: [
                                    SizedBox(width: 150, child: Text('Cause: ', style: Theme.of(context).textTheme.headline6,)),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text(currentDowntime.cause.toString(), style: Theme.of(context).textTheme.bodyText2,)),
                                  ],
                                ),

                                Row(
                                  children: [
                                    SizedBox(width: 150,child: Text('Cause Location: ', style: Theme.of(context).textTheme.headline6,)),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text(currentDowntime.causeLocation.toString(), style: Theme.of(context).textTheme.bodyText2,)),
                                  ],
                                ),

                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    SizedBox(width: 150, child: Text('Classification: ', style: Theme.of(context).textTheme.headline6,)),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text(currentDowntime.classification.toString(), style: Theme.of(context).textTheme.bodyText2,)),
                                  ],
                                ),
                                SizedBox(height: 10,),

                                Row(
                                  children: [
                                    SizedBox(width: 150, child: Text('Comments: ', style: Theme.of(context).textTheme.headline6,)),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text(currentDowntime.comments.toString(), style: Theme.of(context).textTheme.bodyText2,)),
                                  ],
                                ),

                                SizedBox(height: 10,),

                                Row(
                                  children: [
                                    SizedBox(width: 150, child: Text('Equipment Type: ', style: Theme.of(context).textTheme.headline6,)),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text(currentDowntime.equipmentType.toString(), style: Theme.of(context).textTheme.bodyText2,)),
                                  ],
                                ),

                                SizedBox(height: 10,),

                                Row(
                                  children: [
                                    SizedBox(width: 150,child: Text('Explanation 1: ', style: Theme.of(context).textTheme.headline6,)),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text(currentDowntime.explanation.toString(), style: Theme.of(context).textTheme.bodyText2,)),
                                  ],
                                ),

                                SizedBox(height: 10,),

                                Row(
                                  children: [
                                    SizedBox(width: 150, child: Text('Explanation 2: ', style: Theme.of(context).textTheme.headline6,)),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text(currentDowntime.explanation2.toString(), style: Theme.of(context).textTheme.bodyText2,)),
                                  ],
                                ),

                                SizedBox(height: 10,),

                                Row(
                                  children: [
                                    SizedBox(width: 150,child: Text('Start Time: ', style: Theme.of(context).textTheme.headline6,)),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text(currentDowntimeStartString, style: Theme.of(context).textTheme.bodyText2,)),
                                  ],
                                ),

                                SizedBox(height: 10,),

                                Row(
                                  children: [
                                    SizedBox(width: 150, child: Text('End Time: ', style: Theme.of(context).textTheme.headline6,)),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text(currentDowntimeEndString, style: Theme.of(context).textTheme.bodyText2,)),
                                  ],
                                ),

                                SizedBox(height: 20,),

                                Row(
                                  children: [
                                    SizedBox(width: 150, child: Text('Keywords: ', style: Theme.of(context).textTheme.headline6,)),
                                    SizedBox(width: 10,),
                                    Expanded(child: Container(width: 400,child: Text(keywordEdited.toString(), style: Theme.of(context).textTheme.bodyText2,))),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Center(
                              child: RaisedButton(
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    'Assign Downtime to Alarms',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                color: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
//                              side: BorderSide(color: Colors.red)
                                ),
                                onPressed: () {



//                                  List<Alarm> selectedAlarms = getAllocatedAlarmsList(alarms: _filteredAlarmList);
//
//                                  selectedAlarms.forEach((alarm) {
//
//                                    Map<String, dynamic> data = {
//                                      'id' : alarm.tag,
//                                      'description' : alarm.description,
//                                      'task' : alarm.task,
//                                      'timestamp' : alarm.timestamp,
//                                      'priority' : alarm.priority,
//                                    };
//
//
//
//                                    updateFirestoreDocument(data, 'allocatedalarms', alarm.tag);
//
//                                  });

                                  setState(() {

                                    updateFirestoreDocument({'assigned': true}, 'downtimes', currentDowntime.id);

                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          StreamBuilder(
                              stream: _firebaseRef.onValue,
                              builder: (context, snap) {
                                if (snap.hasData) {


                               List <Alarm> item = [];
                                var data = snap.data.snapshot.value;


                                for(var i = 0; i < data.length; i++) {
                                print(data[i]);
                                print(data[i]['timestamp']);

                                item.add(Alarm(
                                      priority: data[i]['priority'],
                                      selected: data[i]['selected'],
                                      tag: data[i]['tag'],
                                      smallDescription:  data[i]['smallDescription'],
                                      fullDescription:  data[i]['fullDescription'],
                                      //timestamp:  data[i]['timestamp'],
                                  ));


                                }


                                //_filteredAlarmList = getFilteredList(alarms: item, downtimeKeywords: keywordEdited);
                                _filteredAlarmList = item;

                                  return

                                    Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: _filteredAlarmList.length,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {

//                                          DateTime alarmDate = _filteredAlarmList[index].timestamp.toDate();
//                                          String alarmDateString = DateFormat('dd/MM/yyyy hh:mm:ss').format(alarmDate);

                                          return Card(
                                              //color: _filteredAlarmList[index].selected ? Colors.yellow : Colors.white ,
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 50,),
//                                                  Checkbox(value: _filteredAlarmList[index].selected, onChanged: (value){
//
//                                                    setState(() {
//                                                      _filteredAlarmList[index].selected = !value;
//                                                    });
//                                                  },),
                                                  SizedBox(width: 50,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      Row(
                                                        children: [
                                                          Text('Tag Name: ', style: Theme.of(context).textTheme.headline6,),
                                                          SizedBox(width: 10,),
                                                          Text(_filteredAlarmList[index].tag, style: Theme.of(context).textTheme.bodyText2,),
                                                        ],
                                                      ),

                                                      Row(
                                                        children: [
                                                          Text('Task : ', style: Theme.of(context).textTheme.headline6,),
                                                          SizedBox(width: 10,),
                                                          Text(_filteredAlarmList[index].smallDescription, style: Theme.of(context).textTheme.bodyText2,),
                                                        ],
                                                      ),

                                                      Row(
                                                        children: [
                                                          Text('Description: ', style: Theme.of(context).textTheme.headline6,),
                                                          SizedBox(width: 10,),
                                                          Text(_filteredAlarmList[index].fullDescription, style: Theme.of(context).textTheme.bodyText2,),
                                                        ],
                                                      ),

//                                                      Row(
//                                                        children: [
//                                                          Text('Timestamp: ', style: Theme.of(context).textTheme.headline6,),
//                                                          SizedBox(width: 10,),
//                                                          Text(alarmDateString, style: Theme.of(context).textTheme.bodyText2,),
//                                                        ],
//                                                      ),

                                                    ],
                                                  ),
                                                ],
                                              ));
                                        }),
                                  );
                                  } else {
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(child: SizedBox(height: 100, width:100,child: CircularProgressIndicator())),
                                    ],
                                  );
                                }
                              })

                        ],
                      ),
                    ),
                  ),


                ],);




            } else {
              return Container(child: Center(child: SizedBox(height: 100, width:100,child: CircularProgressIndicator())),);
            }
          }),),

    );
  }
}
