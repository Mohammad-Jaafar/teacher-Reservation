import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hire_itc/home/direct_to_login.dart';
import 'package:hire_itc/Teacher/search_teacher.dart';
import 'package:hire_itc/Teacher/teacher_registeration.dart';
import 'package:hire_itc/model/Student.dart';
import 'package:hire_itc/model/Teacher.dart';



class ChooseAccount extends StatefulWidget {
  ChooseAccount({Key key, this.students,this.teachers}) : super(key: key);

  List<Student> students;
  List<Teacher> teachers;

  @override
  State createState() => new ChooseAccountState();
}




final studentReference = FirebaseDatabase.instance.reference().child('Students');
final teacherReference = FirebaseDatabase.instance.reference().child('teachers');

class ChooseAccountState extends State<ChooseAccount> {



  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Student> students;
  List<Teacher> teachers;


  StreamSubscription<Event> _onStudentAddedSubscription;
  StreamSubscription<Event> _onTeacherAddedSubscription;
  StreamSubscription<Event> _onStudentChangedSubscription;
  StreamSubscription<Event> _onTeacherChangedSubscription;


  initState() {

    super.initState();

    students= new List();
    teachers= new List();
    _onStudentAddedSubscription = studentReference.onChildAdded.listen(_onStudentAdded);
    _onTeacherAddedSubscription = teacherReference.onChildAdded.listen(_onTeacherAdded);
    _onStudentChangedSubscription = studentReference.onChildChanged.listen(_onStudentUpdated);
    _onTeacherChangedSubscription = teacherReference.onChildChanged.listen(_onTeacherUpdated);

  }

  @override
  void dispose() {  /// close database .....

    super.dispose();
    _onStudentAddedSubscription.cancel();
    _onTeacherAddedSubscription.cancel();
   _onStudentChangedSubscription.cancel();
   _onTeacherChangedSubscription.cancel();
  }




  void  _snack({String text}) {

    Flushbar(
      title: text,
      icon: Icon(Icons.warning,color: Colors.orange[300],),
      duration: Duration(seconds: 5 ),
      backgroundColor:Colors.blueGrey[800],

      flushbarPosition: FlushbarPosition.TOP,
    )
      ..show(context);


  }








  @override
  Widget build(BuildContext context) {




    return new Scaffold(

      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('احجز مدرسك',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Mirza2'),),
        backgroundColor: Colors.blueGrey[700],
        centerTitle:true ,
          automaticallyImplyLeading: false,
      ),

      backgroundColor: Colors.white,
      body: WillPopScope(
    //Wrap out body with a `WillPopScope` widget that handles when a user is cosing current route

    onWillPop: () async {

    Future.value(false);//return a `Future` with false value so this route cant be popped or closed.

    },



     child: new Column(

        mainAxisAlignment:MainAxisAlignment.center,

                children: <Widget>[

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child:  Text(" هل انت طالب ؟ ",style: TextStyle(fontSize: 20.0,color: Colors.orange[500],fontWeight: FontWeight.bold,fontFamily: 'Mirza')),
                      ),
                    ),

                 Container(height: 5.0,),

                  new SizedBox(
                      width:250.0,
                      height: 50.0,
                  child:MaterialButton(
                    color: Colors.blueGrey[700],
                    splashColor: Colors.orange[500],
                    textColor: Colors.orange[500],
                    child: Row(
                      children: <Widget>[
                        new Icon(FontAwesomeIcons.search),
                        Container(width: 30.0,),
                        Text(" ابحث عن مدرسك هنا  ",style: TextStyle(color: Colors.white,fontSize: 17.0,fontFamily: 'Mirza'),),

                      ],
                    ),
                    onPressed: (){

                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return TeacherSearch(teacher: teachers,);}));


                    }
                  )),

                  Container(height: 50.0,),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child:  Text(" هل انت مدرس ؟ ",style: TextStyle(fontSize: 20.0,color: Colors.orange[500],fontWeight: FontWeight.bold,fontFamily: 'Mirza')),
                    ),
                  ),
                  Container(height: 5.0,),

                  new SizedBox(
                      width:250.0,
                      height: 50.0,
                  child: MaterialButton(
                    color: Colors.blueGrey[700],
                    splashColor: Colors.orange[500],
                    textColor: Colors.orange[500],
                    child: Row(
                      children: <Widget>[


                        new Icon(FontAwesomeIcons.user
                        ),
                        Container(width: 30.0,),
                        Text(" انضم الى فريق التدريس ",style: TextStyle(color: Colors.white,fontSize: 17.0,fontFamily: 'Mirza')),

                      ],
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return TeacherRegister();}));

                    },
                  )),

                ],
              )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){


        Navigator.push(context,MaterialPageRoute(builder: (context) =>
                  LoginPage(
                    teacher: teachers,
                    student: students,)));



        },
        tooltip: 'تسجيل الدخول',
        backgroundColor: Colors.orange[500],
        child: Icon(FontAwesomeIcons.signInAlt, color: Colors.blueGrey[700],),
        elevation: 2.0,
      ),

 bottomNavigationBar : new Theme(

   data:Theme.of(context).copyWith(
     // sets the background color of the `BottomNavigationBar`
       canvasColor: Colors.blueGrey[700]),
   child:new BottomNavigationBar (

     items:  <BottomNavigationBarItem>[
       new BottomNavigationBarItem(
           icon: Icon(Icons.arrow_drop_down,color:Colors.blueGrey[700] ,),
           title: Text('',style: TextStyle(color:Colors.blueGrey[700] , ),),
       ),
       new BottomNavigationBarItem(
         icon: Icon(Icons.arrow_drop_down,color:Colors.blueGrey[700] ,),
         title:  Text('',style: TextStyle(color:Colors.blueGrey[700] , ),),
       ),

     ],
     onTap: null,
      ),
    )
    );


  }

  void _onStudentAdded(Event event){
    setState((){
      students.add(new Student.fromSnapShot(event.snapshot));

    });
  }

  void _onTeacherAdded(Event event){
    setState((){
      teachers.add(new Teacher.fromSnapShot(event.snapshot));

    });
  }

  void _onStudentUpdated(Event event){
    var oldStudentValue = students.singleWhere((student) => student.id == event.snapshot.key);
    setState((){
      students[students.indexOf(oldStudentValue)] = new Student.fromSnapShot(event.snapshot);
    });
  }

  void _onTeacherUpdated(Event event){
    var oldStudentValue = teachers.singleWhere((student) => student.id == event.snapshot.key);
    setState((){
      teachers[teachers.indexOf(oldStudentValue)] = new Teacher.fromSnapShot(event.snapshot);
    });
  }










}



/*
@override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: null,
      body: pages(),
      bottomNavigationBar:new Container(
        color: Colors.green,
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                title: new Text("Home")
            ),
            new BottomNavigationBarItem(
                icon: const Icon(Icons.work),
                title: new Text("Self Help")
            ),
            new BottomNavigationBarItem(
                icon: const Icon(Icons.face),
                title: new Text("Profile")
            )
          ],
        currentIndex: index,
        onTap: (int i){setState((){index = i;});},
        fixedColor: Colors.white,
        ),
      );
    );
  };
  new Theme(
      data: Theme.of(context).copyWith(
    // sets the background color of the `BottomNavigationBar`
    canvasColor: Colors.blueGrey[800],
    // sets the active color of the `BottomNavigationBar` if `Brightness` is light
    primaryColor: Colors.red,
    textTheme: Theme.of(context).textTheme.copyWith(caption: new TextStyle(color: Colors.orange[500]))),
    // sets the inactive color of the `BottomNavigationBar`
 */


/*


 void _signedIn() {
    setState(() {
      if (!mounted) return;
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      if (!mounted) return;
      authStatus = AuthStatus.notSignedIn;
    });
  }



  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,

}

 */