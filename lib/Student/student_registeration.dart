import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hire_itc/Student/student_screen_page.dart';
import 'package:hire_itc/home/direct_to_login.dart';
import 'package:hire_itc/model/Teacher.dart';
import 'package:hire_itc/model/user_to_database.dart';
import 'package:flushbar/flushbar.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class StudentRegister extends StatefulWidget {
  const StudentRegister({this.onSignedOut,this.teacher});
  final VoidCallback onSignedOut;
  final Teacher teacher;

  @override
  State createState() => new StudentRegisterState();
}

class StudentRegisterState extends State<StudentRegister> {

//  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//  new FlutterLocalNotificationsPlugin();


  TextEditingController _fullname;
  TextEditingController _schoolname;
  TextEditingController _number;
  TextEditingController _email;
  TextEditingController _pass1;
  TextEditingController _pass2;
  TextEditingController _TeacherName;

  bool _isLoading = true;
  bool _validate = false;

  final notifications = FlutterLocalNotificationsPlugin();

  File image;
  picker() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    // File img2 = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() {
        image = img;
      });
    }
    else {
      _snack(title: "يرجى الأنتضار ",
        message: "  تم ارسال رسالة التأكيد الى بريدك الاكتروني",
        duration1: 12,);
    }
  }

String url;
  initState() {
    super.initState();
    _fullname = new TextEditingController();
    _schoolname = new TextEditingController();
    _number = new TextEditingController();
    _email = new TextEditingController();
    _pass1 = new TextEditingController();
    _pass2 = new TextEditingController();
    _TeacherName = new TextEditingController(text: widget.teacher.fullname);

    url = "";

//    final settingsAndroid = AndroidInitializationSettings('app_icon');
//    final settingsIOS = IOSInitializationSettings(
//        onDidReceiveLocalNotification: (id, title, body, payload) =>
//            onSelectNotification(payload));

//    notifications.initialize(
//        InitializationSettings(settingsAndroid, settingsIOS),
//        onSelectNotification: onSelectNotification);
//  }

//  Future onSelectNotification(String payload) async =>
//      await Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => LoginPage(payload: payload)),
//
//      );

  }

  List<String> _locations = ['ذكر', 'انثى']; // Option 2
  String _gender;

  List<String> _locations2 = ['علمي', 'ادبي']; // Option 2
  String _department;

  List<String> _locations3 = ['احيائي', 'تطبيقي']; // Option 2
  String _secondepartment;



  void  _snack({String title,String message,int duration1}) {

  Flushbar(
    title: title,
    message: message,
    icon: Icon(Icons.warning,color: Colors.orange[500],),
    duration: Duration(seconds: duration1 ),
    backgroundColor:Colors.blueGrey[700],

    flushbarPosition: FlushbarPosition.TOP,
  )
  ..show(context);


}



  @override
  Widget build(BuildContext context) {

    var fullImagePath;

    var now = formatDate(new DateTime.now(), [yyyy, '-', mm, '-', dd]);
    var fullImageName = 'images/${_fullname.text}-$now' + '.jpg';
    return new Scaffold(

        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.orange[500], //change your color here
          ),
          title: Text('تسجيل الطلاب', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          backgroundColor: Colors.blueGrey[700],
          centerTitle: true,
        ),

        backgroundColor: Colors.white,
        body: Scrollbar(
    child: new SingleChildScrollView(
    scrollDirection: Axis.vertical,
    reverse: true,
    child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            new DropdownButton(

              icon: Icon(Icons.arrow_drop_down,color: Colors.orange[500],),
              style: TextStyle(color: Colors.orange[500]),
              isExpanded: true,
              hint: Text(' رجاءا اختر الجنس',style: TextStyle(color: Colors.blueGrey[700],),), // Not necessary for Option 1
              value: _gender,
              onChanged: (newValue) {
                setState(() {
                  _gender = newValue;
                });
              },
              items: _locations.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),

            new DropdownButton(

              icon: Icon(Icons.arrow_drop_down,color: Colors.orange[500],),

              style: TextStyle(color: Colors.orange[500]),
              isExpanded: true,
              hint: Text(' رجاءا اختر القسم',style: TextStyle(color: Colors.blueGrey[800],),), // Not necessary for Option 1
              value: _department,
              onChanged: (newValue) {
                setState(() {
                  _department = newValue;
                });
              },
              items: _locations2.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),

            new DropdownButton(

              icon: Icon(Icons.arrow_drop_down,color: Colors.orange[500],),
              isExpanded: true,
              style: TextStyle(color: Colors.orange[500]),

              hint: Text('رجاءا اختر احد اقسام العلمي',style: TextStyle(color: Colors.blueGrey[700],),), // Not necessary for Option 1
              value: _secondepartment,
              onChanged: (newValue) {
                setState(() {
                  _secondepartment = newValue;
                });
              },
              items: _locations3.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),

            new TextFormField(

              decoration: new InputDecoration(

                errorText: _validate ? 'الحقل لا يمكن ان يكون خالي ' : null,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500]),
                ),
                labelText: "الاسم الرباعي",
                labelStyle: TextStyle(color: Colors.orange[500]),
                fillColor: Colors.grey,

                icon: Icon(FontAwesomeIcons.user, color: Colors.orange[500],),
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                ),
              ),

              controller: _fullname,
              keyboardType: TextInputType.text,
            ),

            new TextFormField(
              decoration: new InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500]),
                ),
                errorText: _validate ? 'الحقل لا يمكن ان يكون خالي ' : null,
                labelText: "اسم المدرسة",
                labelStyle: TextStyle(color: Colors.orange[500]),
                fillColor: Colors.grey,
                icon: Icon(FontAwesomeIcons.school, color: Colors.orange[500],),
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                ),
              ),
              controller: _schoolname,
              keyboardType: TextInputType.text,
            ),

            new TextFormField(
              decoration: new InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500]),
                ),
                errorText: _validate ? 'الحقل لا يمكن ان يكون خالي ' : null,
                labelText: "رقم هاتفك",
                labelStyle: TextStyle(color: Colors.orange[500]),
                fillColor: Colors.grey,
                icon: Icon(FontAwesomeIcons.phone, color: Colors.orange[500],),
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                ),
              ),
              controller: _number,
              keyboardType: TextInputType.phone,
            ),



            new TextFormField(
              decoration: new InputDecoration(
                errorText: _validate ? 'الحقل لا يمكن ان يكون خالي ' : null,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500]),
                ),
                labelText: "اسم المدرس",
                labelStyle: TextStyle(color: Colors.orange[500]),
                fillColor: Colors.grey,
                icon: Icon(FontAwesomeIcons.user, color: Colors.orange[500],),
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                ),
              ),
              controller: _TeacherName,
              enabled: false,
              keyboardType: TextInputType.text,
            ),


            new TextFormField(
              decoration: new InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500]),
                ),
                errorText: _validate ? 'الحقل لا يمكن ان يكون خالي ' : null,
                labelText: "البريد الاكتروني",
                labelStyle: TextStyle(color: Colors.orange[500]),
                fillColor: Colors.grey,
                prefixStyle: new TextStyle(
                  color: Colors.orange[500],
                ),

                hintText: "ادخل حساب كوكل او اي حساب فعال",
                icon: Icon(Icons.email, color: Colors.orange[500],),
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                ),
              ),
              style: TextStyle(
                color: Colors.blueGrey[700],
              ),
              autocorrect: true,

              controller: _email,
              keyboardType: TextInputType.emailAddress,
            ),


            new TextFormField(
              decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange[500]),
                  ),
                  errorText: _validate ? 'الحقل لا يمكن ان يكون خالي ' : null,
                  labelText: "كلمة المرور",
                fillColor: Colors.grey,
                labelStyle: TextStyle(color: Colors.orange[500]),
                  icon: Icon(FontAwesomeIcons.key, color: Colors.orange[500],),
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                ),),
              controller: _pass1,
              obscureText: true,
              keyboardType: TextInputType.text,
            ),

            new TextFormField(
              decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange[500]),
                  ),
                  errorText: _validate ? 'الحقل لا يمكن ان يكون خالي ' : null,
                  labelText: " تاكيد كلمة المرور",
                fillColor: Colors.grey,
                labelStyle: TextStyle(color: Colors.orange[500]),
                  icon: Icon(FontAwesomeIcons.key, color: Colors.orange[500],),
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                ),),
              controller: _pass2,
              obscureText: true,
              keyboardType: TextInputType.text,
              validator: (value) {
                if(value != _pass1.text && _validate == true) {
                  _snack(title:"يرجى الأنتضار ",message: "الرمز غير مطابق",duration1: 10,);
                }
                else{
                 return null;
                }


            },
            ),



            Container(height: 30.0,),
            Container(
              child: Column(
                children: <Widget>[

                  image == null
                      ? Text(' لم يتم اختيار الصورة الشخصية',
                    style: TextStyle(color: Colors.orange[500]),)
                      : Image.file(image, height: 100.0, width: 200.0,),


                  RaisedButton(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.add_a_photo,
                          color: Colors.orange[500],),
                        Container(width: 30.0,),
                        Text('اضغط هنا لاضافة الصورة الشخصية ')
                      ],
                    ),
                    color: Colors.blueGrey[700],
                    splashColor: Colors.orange[500],
                    textColor: Colors.white,
                    onPressed: picker,
                  ),
                  Container(height: 40.0,),

                ],

              ),

            ),



          ],
        ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(


          child: _isLoading ?
          Icon(FontAwesomeIcons.signInAlt, color: Colors.blueGrey[700],) :
          SizedBox(child:CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey[800]),),width: 25.0,height: 25.0,),
          onPressed: () {




            setState(() {
              if (!mounted) return;
              _isLoading = false;
            });

            setState(() {
              if(_email.text.isEmpty && _pass1.text.isEmpty && _pass2.text.isEmpty &&
                  _fullname.text.isEmpty && _schoolname.text.isEmpty
              && _number.text.isEmpty

              ) {
                _validate= true;
              }
              else {_validate = false;}
            });

            setState(() {
              if (!mounted) return;
              _isLoading = false;
            });



            if(_validate == false && _pass2.text == _pass1.text) {

              setState(() {
                if (!mounted) return;
                _isLoading = false;
              });

              uploadImage(fullImageName,context).then((path) {
                fullImagePath = path;

              FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: _email.text, password: _pass2.text
              ).then((singedUser) {


      UserToDatabase().addNewStudent(user: singedUser,
        context: context,
        status: null,
        fullname: _fullname.text,
        schoolname: _schoolname.text,
        number: _number.text,
        gender: _gender,
        department: _department,
        department2: _secondepartment,
        studentImage: '$fullImagePath',
        TeacherName: widget.teacher.fullname,
      );

      singedUser.sendEmailVerification();

      _snack(title:"يرجى الأنتضار ",message: "  تم ارسال رسالة التأكيد الى بريدك الاكتروني",duration1: 10,);

      Future.delayed(Duration(seconds: 10), () {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => LoginPage()));

      });

    });



                setState(() {
                  if (!mounted) return;
                  _isLoading = true;
                });

            }).catchError((e) {
                print(e.toString());
              });
            }




    },
          tooltip: 'تسجيل',
          backgroundColor: Colors.orange[500],
          elevation: 2.0,
        ),

        bottomNavigationBar: new Theme(

          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.blueGrey[700]),
          child: new BottomNavigationBar (

            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down, color: Colors.blueGrey[700],),
                title: Text(
                  '', style: TextStyle(color: Colors.blueGrey[700],),),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down, color: Colors.blueGrey[700],),
                title: Text(
                  '', style: TextStyle(color: Colors.blueGrey[700],),),
              ),

            ],
            onTap: null,
          ),
        )
    );
  }

//

  Future<String> uploadImage(fullImageName,context ) async {

    StorageReference ref = FirebaseStorage.instance.ref().child(fullImageName);
    StorageUploadTask uploadTask = ref.putFile(image);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = dowurl.toString();

    debugPrint(url);
    return url;
  }




}



/*
var auth = firebase.auth();
var emailAddress = "<Mail_id >";

auth.sendPasswordResetEmail(emailAddress).then(function() {
  // Email sent.
    console.log("welcome")
}).catch(function(error) {
  // An error happened.
});
 */


//  @override
//  initState() {
//    _firstname = new TextEditingController();
//    _secondname = new TextEditingController();
//    _lastname = new TextEditingController();
//    _surname = new TextEditingController();
//    _email = new TextEditingController();
//    _pass1 = new TextEditingController();
//    _pass2 = new TextEditingController();


//
//


//    super.initState();
//  }


//
//  final DocumentReference documentReference =
//  Firestore.instance.document("student");


//  void _delete() {
//    documentReference.delete().whenComplete(() {
//      print("Deleted Successfully");
//      setState(() {});
//    }).catchError((e) => print(e));
//  }
//
//  void _update() {
//    Map<String, String> data = <String, String>{
//      "name": "Pawan Kumar Updated",
//      "desc": "Flutter Developer Updated"
//    };
//    documentReference.updateData(data).whenComplete(() {
//      print("Document Updated");
//    }).catchError((e) => print(e));
//  }
//
//  void _fetch() {
//    documentReference.get().then((datasnapshot) {
//      if (datasnapshot.exists) {
//        setState(() {
//
//        });
//      }
//      else{
//        print('error');
//      }
//    });
//  }


//

// to avoid memory leak dispose of subscription ....

/*
const SizedBox(height: 7.0),
                new Container(
              padding: const EdgeInsets.only(left: 15.0),
              color: Colors.white,
              child:
 */