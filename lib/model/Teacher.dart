import 'package:firebase_database/firebase_database.dart';

class Teacher {
  String _id ;
  String _fullname;
  String _gender;
  String _academicqualification;
  String _experience;
  String _subject;
  String _number;
  String _email;
  String _address;
  String _status;
  String _age;
  String _details;
  String _teacherImage;
  String _fee;
  String _firstFee;

// from list
  Teacher.map(dynamic obj){

    this._email = obj['email'];
    this._fullname = obj['fullname'];
    this._gender =  obj['gender'];
    this._academicqualification = obj['academicqualify'];
    this._experience =  obj['experience'];
    this._subject =  obj['subject'];
    this._number =  obj['number'];
    this._address =  obj['address'];
    this._teacherImage =  obj['teacherImage'];
    this._age =  obj['age'];
    this._details = obj['details'];
    this._status =  obj['status'];
    this._fee =  obj['fee'];
    this._firstFee =  obj['firstFee'];
  }

//getters

  String get id => _id;
  String get fullname => _fullname;
  String get gender => _gender;
  String get academicqualification => _academicqualification;
  String get experience => _experience;
  String get subject => _subject;
  String get number => _number;
  String get email => _email;
  String get address => _address;
  String get status => _status;
  String get age => _age;
  String get details => _details;
  String get teacherImage => _teacherImage;
  String get fee => _fee;
  String get firstFee => _firstFee;

//from database

  Teacher.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _email = snapshot.value['email'];
    _fullname =  snapshot.value['fullname'];
    _gender =  snapshot.value['gender'];
    _academicqualification =  snapshot.value['academicqualify'];
    _experience =  snapshot.value['experience'];
    _subject =  snapshot.value['subject'];
    _number =  snapshot.value['number'];
    _address =  snapshot.value['address'];
    _teacherImage =  snapshot.value['teacherImage'];
    _age =  snapshot.value['age'];
    _details =  snapshot.value['details'];
    _status =  snapshot.value['status'];
    _fee =  snapshot.value['fee'];
   _firstFee = snapshot.value['firstFee'];
  }
}