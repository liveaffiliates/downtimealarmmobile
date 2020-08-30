
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'downtime.dart';

class Alarm {



  String id;
  String priority;
  String tag;
  String smallDescription;
  String fullDescription;
  bool selected;
  Timestamp timestamp;





  Alarm({this.priority, this.tag, this.smallDescription, this.fullDescription, this.selected = false, this.timestamp})
      : id = null;




  Alarm.fromSnapshot(DataSnapshot snapshot, Downtime downtime)
      : assert(snapshot != null),
        priority = snapshot.value['priority'],
        tag = snapshot.value['tag'].toString(),
        smallDescription = snapshot.value['task'].toString(),
        fullDescription = snapshot.value['description'].toString(),
        selected = snapshot.value['tag'].toString().startsWith(downtime.causeLocation.split('.')[downtime.causeLocation.split('.').length-1]) || snapshot.value['tag'].toString().startsWith(downtime.causeLocation.split('.')[downtime.causeLocation.split('.').length-2]),
        timestamp = snapshot.value['timestamp'],
        id = snapshot.key;




//  void setId(String value){
//    id = value;
//
//  }
//
//  String get getId => id;
//
//  void setAssigned(bool value){
//    assigned = value;
//  }
//
//  bool get getAssigned => assigned;
//
//  void setCause(String value){
//    cause = value;
//
//  }
//
//  String get getCause => cause;
//
//  void setCauseLocation(String value){
//    causeLocation = value;
//
//  }
//
//  String get getCauseLocation => causeLocation;
//
//
//  void setClassification(String value){
//    classification = value;
//
//  }
//
//  String get getClassification => classification;
//
//  void setComments(String value){
//    comments = value;
//
//  }
//
//  String get getComments => comments;
//
//  void setEffect(String value){
//    effect = value;
//
//  }
//
//  String get getEffect => effect;
//
//  void setExplanation(String value){
//    explanation = value;
//
//  }
//
//  String get getExplanation => explanation;
//
//  void setExplanation2(String value){
//    explanation2 = value;
//
//  }
//
//  String get getExplanation2 => explanation2;
//
//  void setEquipmentType(String value){
//    equipmentType = value;
//
//  }
//
//  String get getEquipmentType => equipmentType;
//
//  void setEffectiveDuration(String value){
//    effectiveDuration = value;
//
//  }
//
//  String get getEffectiveDuration => effectiveDuration;
//
//  void setDuration(String value){
//    duration = value;
//
//  }
//
//  String get getDuration => duration;
//
//  void setStartTime(Timestamp value){
//    startTime = value;
//
//  }
//
//  Timestamp get getStartTime => startTime;
//
//  void setEndTime(Timestamp value){
//    endTime = value;
//
//  }
//
//  Timestamp get getEndTime => endTime;
//
//


}



