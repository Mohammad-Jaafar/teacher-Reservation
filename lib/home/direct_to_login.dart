import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hire_itc/Student/student_screen_page.dart';
import 'package:hire_itc/Teacher/teacher_screen.dart';
import 'package:hire_itc/model/Student.dart';
import 'package:hire_itc/model/Teacher.dart';




class LoginPage extends StatefulWidget {

  LoginPage({this.student,this.teacher});


    List<Student> student;
    List<Teacher> teacher;


 LoginPageState createState() => new LoginPageState(student: student,teacher: teacher);

}




class LoginPageState extends State<LoginPage> {
  LoginPageState({this.teacher,this.student});
    List<Student> student;
    List<Teacher> teacher;



  bool _isLoading = true;

  TextEditingController _email;
  TextEditingController _pass2;

  void _snack({String title, String message, int duration1}) {
    Flushbar(
      title: title,
      message: message,
      icon: Icon(Icons.warning, color: Colors.orange[500],),
      duration: Duration(seconds: duration1),
      backgroundColor: Colors.blueGrey[800],
      flushbarPosition: FlushbarPosition.TOP,
    )
      ..show(context);
  }



  initState() {

    super.initState();
    _email = new TextEditingController();
    _pass2 = new TextEditingController();



  }









  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body:
      new Stack(fit: StackFit.expand,
          children: <Widget>[
            new Image(
              image: new AssetImage("assets/images/logo_bg.png"),
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.darken,
              color: Colors.black87,
            ),
            new Theme(
              data: new ThemeData(
                  brightness: Brightness.dark,
                  inputDecorationTheme: new InputDecorationTheme(
                    // hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
                    labelStyle:
                    new TextStyle(color: Colors.orange[500], fontSize: 25.0),
                    fillColor: Colors.orange[500],
                  )),
              isMaterialAppTheme: true,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  new Container(
                    padding: const EdgeInsets.all(40.0),
                    child: new Form(
                      autovalidate: true,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new TextFormField(
                            decoration: new InputDecoration(
                              labelText: "Enter Email",
                              fillColor: Colors.orange[500],
                              icon: Icon(FontAwesomeIcons.user,
                                color: Colors.orange[500],),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange[500]),
                              ),
                            ),
                            validator: (value) =>
                            value.isEmpty
                                ? 'تحذير : لا يمكن ان تكون خالية'
                                : null,
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,

                          ),
                          new TextFormField(
                            decoration: new InputDecoration(
                                labelText: "Enter password",
                                icon: Icon(FontAwesomeIcons.key,
                                  color: Colors.orange[500],),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange[500]),
                                )),
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                            value.isEmpty
                                ? 'تحذير : لا يمكن ان تكون خالية'
                                : null,
                            controller: _pass2,
                          ),
                          new Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                          ),
                          new MaterialButton(
                              height: 50.0,
                              minWidth: 150.0,
                              color: Colors.orange[500],
                              splashColor: Colors.orange[500],
                              textColor: Colors.blueGrey[800],
                              child: _isLoading ? Icon(
                                  FontAwesomeIcons.signInAlt) : SizedBox(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.blueGrey[700]),),
                                width: 25.0,
                                height: 25.0,),

                              onPressed: () {

                                setState(() {
                                  if (!mounted) return;
                                  _isLoading = false;
                                });

                              if(teacher[0].status != null) {
                                for (var j in teacher) {

                                  if (j.email == _email.text) {
                                    FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                        email: _email.text,
                                        password: _pass2.text

                                    ).then((user) {
                                      if (user.isEmailVerified) {

                                        _navigateToTeacherScreen(context, j);
                                      }

                                      else {
                                        setState(() {
                                          if (!mounted) return;
                                          _isLoading = true;
                                        });
                                        return _snack(title: "تحذير",
                                            message: "قم بتأكيد حسابك عن طريق بريدك الاكتروني",
                                            duration1: 5);
                                      }


                                    }).catchError((e) {

                                      _snack(title: "تحذير",
                                          message: "تأكد من بريدك الاكتروني أو كلمة المرور",
                                          duration1: 5);
                                      setState(() {
                                        if (!mounted) return;
                                        _isLoading = true;
                                      });
                                    });

                                  }

                                }
                              }




                               if(student[0].status == null){
                                for (var i in student) {
                                  if (i.email == _email.text) {
                                    FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                        email: _email.text,
                                        password: _pass2.text

                                    ).then((user) {
                                      if (user.isEmailVerified) {

                                        _navigateToStudentScreen(context, i);
                                      }

                                      else {
                                        setState(() {
                                          if (!mounted) return;
                                          _isLoading = true;
                                        });
                                        return _snack(title: "تحذير",
                                            message: "قم بتأكيد حسابك عن طريق بريدك الاكتروني",
                                            duration1: 5);
                                      }
                                    }).catchError((e) {
                                      _snack(title: "تحذير",
                                          message: "تأكد من بريدك الاكتروني أو كلمة المرور",
                                          duration1: 5);
                                      setState(() {
                                        if (!mounted) return;
                                        _isLoading = true;
                                      });
                                    });
                                  }


                                }
                              }





                              }
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
    );
  }






//  void _onStudentUpdated(Event event){
//    var oldStudentValue = students.singleWhere((student) => student.id == event.snapshot.key);
//    setState((){
//      students[students.indexOf(oldStudentValue)] = new Student.fromSnapShot(event.snapshot);
//    });
//  }
//


//  void _onTeacherUpdated(Event event){
//    var oldStudentValue = teachers.singleWhere((student) => student.id == event.snapshot.key);
//    setState((){
//      teachers[teachers.indexOf(oldStudentValue)] = new Teacher.fromSnapShot(event.snapshot);
//    });
//  }
//
//


  void _navigateToStudentScreen(BuildContext context,Student student) async {

    await Navigator.of(context).pushReplacement(

      new MaterialPageRoute(builder: (context) => StudentScreen(student: student)),
    );

  }

  void _navigateToTeacherScreen(BuildContext context,Teacher teacher) async {

    await Navigator.of(context).pushReplacement(
      new MaterialPageRoute(builder: (context) => TeacherScreen(teacher: teacher,student: student,)),
    );

  }

}

//Navigator.of(context).pushReplacement(
//new MaterialPageRoute(builder: (context) => MyWalkthrough()));

  //  void _showDialog() {
  //    // flutter defined function
  //    showDialog(
  //      context: context,
  //      builder: (BuildContext context) {
  //        // return object of type Dialog
  //        return AlertDialog(
  //          title: new Text("Alert Dialog title"),
  //          content: new Text("Alert Dialog body"),
  //          actions: <Widget>[
  //            // usually buttons at the bottom of the dialog
  //            new FlatButton(
  //              child: new Text("Close"),
  //              onPressed: () {
  //                Navigator.of(context).pop();
  //              },
  //            ),
  //          ],
  //        );
  //      },
  //    );
  //  }

  //  var auth = firebase.auth();
  //  var emailAddress = "<Mail_id >";
  //
  //  auth.sendPasswordResetEmail(emailAddress).then(function() {
  //    // Email sent.
  //    console.log("welcome")
  //  }).catch(function(error) {
  //    // An error happened.
  //  });


/*
 void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }
 */