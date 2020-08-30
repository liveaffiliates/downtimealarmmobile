
import 'package:cloud_firestore/cloud_firestore.dart';

class Downtime {


  String id;
  bool assigned;
  String cause;
  String causeLocation;
  String classification;
  String comments;
  String effect;
  String explanation;
  String explanation2;
  String equipmentType;
  String effectiveDuration;
  String duration;
  Timestamp startTime;
  Timestamp endTime;

  Downtime({this.assigned, this.cause, this.causeLocation, this.classification, this.comments, this.effect, this.explanation, this.explanation2, this.effectiveDuration, this.equipmentType, this.duration, this.startTime, this.endTime})
      : id = null;


  Downtime.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        assigned = snapshot['assigned'],
        cause = snapshot['cause'].toString(),
        causeLocation = snapshot['causeLocation'].toString(),
        classification = snapshot['classification'].toString(),
        comments = snapshot['comments'].toString(),
        effect = snapshot['effect'].toString(),
        explanation = snapshot['explanation'].toString(),
        explanation2 = snapshot['explanation2'].toString(),
        effectiveDuration = snapshot['effectiveDuration'],
        equipmentType = snapshot['equipmentType'].toString(),
        duration = snapshot['duration'].toString(),
        startTime = snapshot['startTime'],
        endTime = snapshot['endTime'],
        id = snapshot.documentID;


//
//
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



