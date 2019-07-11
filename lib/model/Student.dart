import 'package:firebase_database/firebase_database.dart';

class Student {
  String _id ;
  String _fullName;
  String _gender;
  String _schoolName;
  String _department;
  String _department2;
  String _number;
  String _email;
  String _status;
  String _studentImage;
  String _TeacherName;



  Student.map(dynamic obj){
    this._email = obj['email'];
    this._status  = obj['status'];
  }

  String get id => _id;
  String get fullName => _fullName;
  String get gender => _gender;
  String get schoolName => _schoolName;
  String get department => _department;
  String get department2 => _department2;
  String get number => _number;
  String get email => _email;
  String get status => _status;
  String get studentImage =>  _studentImage;
  String get TeacherName => _TeacherName;

  Student.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _email = snapshot.value['email'];
    _fullName =  snapshot.value['fullname'];
    _gender =  snapshot.value['gender'];
    _schoolName =  snapshot.value['schoolName'];
    _department =  snapshot.value['department'];
    _department2 =  snapshot.value['department2'];
    _number =  snapshot.value['number'];
    _email =  snapshot.value['email'];
    _status =  snapshot.value['status'];
    _studentImage =  snapshot.value['studentImage'];
    _TeacherName = snapshot.value['TeacherName'];
  }
}