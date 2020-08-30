import 'package:flutter/material.dart';
import 'alarm.dart';

List <Alarm> getFilteredList({List<Alarm> alarms, List<String> downtimeKeywords}) {


  List<Alarm> _filteredAlarmList = [];

  for (int i = 0; i < alarms.length; i++){

    bool addToArray = false;

    List <String> alarmsKeywords = [];
    alarmsKeywords.addAll(alarms[i].fullDescription.split(' '));
    alarmsKeywords.addAll(alarms[i].smallDescription.split(' '));

    for (int j = 0; j < alarmsKeywords.length; j++) {
      if (downtimeKeywords.contains(alarmsKeywords[j].toUpperCase())) {
        addToArray = true;
      }
    }

    for (int k = 0; k < downtimeKeywords.length; k++ ){
      if (alarms[i].tag.startsWith(downtimeKeywords[k])){
        addToArray = true;
      }
    }


    if (addToArray) {
      _filteredAlarmList.add(alarms[i]);
    }
  }

  return _filteredAlarmList;

}


List <Alarm> getAllocatedAlarmsList({List<Alarm> alarms}) {

  List <Alarm> _allocatedAlarmsList;

  _allocatedAlarmsList = alarms;

  _allocatedAlarmsList =
      alarms.where((alarm) =>
      (alarm.selected)
      ).toList();

  return _allocatedAlarmsList;
}


