import 'package:firebase_database/firebase_database.dart';

class UserToDatabase {

  addNewStudent({user , context,status,fullname,schoolname,number,gender,department,department2,studentImage,TeacherName}) {
    FirebaseDatabase.instance.reference().child('Students')
        .push().set({
      'email' : user.email,
      'uid' : user.uid,
      'status':status,
      'fullname':fullname,
      'schoolname':schoolname,
      'number':number,
      'gender':gender,
     'department':department,
      'department2':department2,
      'studentImage':studentImage,
       'TeacherName':TeacherName,
    }).catchError((e){
      print(e);
    });
  }

  addNewTeacher({user , context,status,fullname,academicqualify,number,address,gender,subject,experience,age,details,teacherImage,fee,firstFee}) {
    FirebaseDatabase.instance.reference().child('teachers')
        .push().set({
      'email' : user.email,
      'uid' : user.uid,
     'status' : status,
      'fullname':fullname,
      'academicqualify':academicqualify,
      'number':number,
      'gender':gender,
      'address':address,
      'subject':subject,
      'experience':experience,
      'age':age,
      'details':details,
      'teacherImage' :teacherImage,
       'fee':fee,
      'firstFee':firstFee

    }).catchError((e){
      print(e);
    });
  }

}