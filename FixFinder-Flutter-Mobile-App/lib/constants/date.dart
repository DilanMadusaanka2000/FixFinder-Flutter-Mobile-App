import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DateFormat formetter = DateFormat('EEEE ,MMMM');
final DateFormat dayFormate = DateFormat('dd');


DateTime now = DateTime.now();
String formattedDate = formetter.format(now);
String formatterDay = dayFormate.format(now);


