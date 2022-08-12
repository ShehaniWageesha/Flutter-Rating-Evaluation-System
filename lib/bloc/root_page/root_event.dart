import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class RootEvent {}

class InitEvent extends RootEvent {
  InitEvent();
}

class GetAllTeacher extends RootEvent {
  GetAllTeacher();
}

class DeleteTeacher extends RootEvent {
  final DocumentSnapshot teacher;

  DeleteTeacher(this.teacher);
}
