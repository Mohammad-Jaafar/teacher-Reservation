import 'dart:io';

import 'package:hire_itc/home/direct_to_login.dart';
import 'package:hire_itc/model/Teacher.dart';
import 'package:hire_itc/model/user_to_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flushbar/flushbar.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:date_format/date_format.dart';




class TeacherRegister extends StatefulWidget {
  const TeacherRegister({this.teacher});

 final Teacher teacher;
  @override
  State createState() => new TeacherRegisterState();
}

class TeacherRegisterState extends State<TeacherRegister> {


  File image;


  TextEditingController _fullname;
  TextEditingController _academicqualify;
  TextEditingController _number;
  TextEditingController _address;
  TextEditingController _experience;
  TextEditingController _email;
  TextEditingController _pass1;
  TextEditingController _pass2;
  TextEditingController _details;
  TextEditingController _age;
  TextEditingController _fee;
  TextEditingController _firstFee;


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

  initState() {
    _fullname = new TextEditingController();
    _academicqualify = new TextEditingController();
    _number = new TextEditingController();
    _address = new TextEditingController();
    _experience = new TextEditingController();
    _email = new TextEditingController();
    _pass1 = new TextEditingController();
    _pass2 = new TextEditingController();
    _details = new TextEditingController();
    _age = new TextEditingController();
    _fee = new TextEditingController();
    _firstFee = new TextEditingController();
    url = "";

    super.initState();
  }

  bool _isLoading = true;
  bool _validate = false;


  void _snack(
      {BuildContext context, String title, String message, int duration1}) {
    Flushbar(
      title: title,
      message: message,
      icon: Icon(Icons.warning, color: Colors.orange[500],),
      duration: Duration(seconds: duration1),
      backgroundColor: Colors.blueGrey[700],

      flushbarPosition: FlushbarPosition.TOP,
    )
      ..show(context);
  }

  var passKey = GlobalKey<FormFieldState>();





  List<String> _locations = ['ذكر', 'انثى']; // Option 2
  String _gender;

  List<String> _subjects = [
    'اسلامية',
    'عربي',
    'رياضيات',
    'English',
    'French',
    'احياء',
    'فيزياء',
    'كيمياء',
    'اجتماعيات',
    'اقتصاد'
  ]; // Option 2
  String _subject;
  String url;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var fullImagePath;
    var now = formatDate(new DateTime.now(), [yyyy, '-', mm, '-', dd]);

    var fullImageName = 'images/${_fullname.text}-$now' + '.jpg';
    //var fullImageName2 =  'images%2F${_fullname.text}-$now'+'.jpg';

    return new Scaffold(
        key: _formKey,

        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.orange[500], //change your color here
          ),
          title: Text('تسجيل المدرسين', style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.blueGrey[700],
          centerTitle: true,
        ),

        backgroundColor: Colors.white,
        body:
        new Scrollbar(
            child: new SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,

                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: <Widget>[


                    new DropdownButton(

                      icon: Icon(
                        Icons.arrow_drop_down, color: Colors.orange[500],),
                      isExpanded: true,
                      style: TextStyle(color: Colors.orange[500]),

                      hint: Text(' رجاءا اختر الجنس',
                        style: TextStyle(color: Colors.blueGrey[700]),),
                      // Not necessary for Option 1
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

                    SizedBox(height: 10),
                    new DropdownButton(

                      icon: Icon(Icons.arrow_drop_down, color: Colors.orange,),
                      isExpanded: true,
                      style: TextStyle(color: Colors.orange[500]),

                      hint: Text(' رجاءا اختر مادة التدريس',
                        style: TextStyle(color: Colors.blueGrey[700],),),


                      value: _subject,
                      onChanged: (newValue) {
                        setState(() {
                          _subject = newValue;
                        });
                      },
                      items: _subjects.map((
                          location) { //map iterable across all index
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 10),
                    new TextFormField(
                      decoration: new InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500]),
                        ),

                        labelText: "الاسم الكامل",
                        labelStyle: TextStyle(color: Colors.orange[500]),
                        errorText: _validate
                            ? 'الحقل لا يمكن ان يكون خالي '
                            : null,
                        fillColor: Colors.grey,
                        icon: Icon(
                          FontAwesomeIcons.user, color: Colors.orange[500],),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                        ),
                      ),
                      controller: _fullname,
                      style: TextStyle(color: Colors.blueGrey),
                      keyboardType: TextInputType.text,

                    ),
                    SizedBox(height: 10),
                    new TextFormField(
                      decoration: new InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500]),
                        ),
                        errorText: _validate
                            ? 'الحقل لا يمكن ان يكون خالي '
                            : null,

                        labelText: "التحصيل الدراسي",
                        labelStyle: TextStyle(color: Colors.orange[500]),
                        fillColor: Colors.blueGrey,
                        icon: Icon(FontAwesomeIcons.graduationCap,
                          color: Colors.orange[500],),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                        ),
                      ),
                      controller: _academicqualify,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 10),
                    new TextFormField(
                      decoration: new InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500]),
                        ),
                        errorText: _validate
                            ? 'الحقل لا يمكن ان يكون خالي '
                            : null,
                        labelText: "رقم هاتفك ",
                        labelStyle: TextStyle(color: Colors.orange[500]),
                        fillColor: Colors.blueGrey,
                        icon: Icon(
                          FontAwesomeIcons.phone, color: Colors.orange[500],),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                        ),
                      ),
                      controller: _number,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    new TextFormField(
                      decoration: new InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500]),
                        ),
                        errorText: _validate
                            ? 'الحقل لا يمكن ان يكون خالي '
                            : null,
                        labelText: "عدد سنوات الخبرة",
                        labelStyle: TextStyle(color: Colors.orange[500]),
                        fillColor: Colors.blueGrey,
                        icon: Icon(Icons.beenhere, color: Colors.orange[500],),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                        ),
                      ),
                      controller: _experience,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    new TextFormField(
                      decoration: new InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500]),
                        ),
                        labelText: "العنوان",
                        labelStyle: TextStyle(color: Colors.orange[500]),
                        errorText: _validate
                            ? 'الحقل لا يمكن ان يكون خالي '
                            : null,
                        fillColor: Colors.blueGrey,
                        icon: Icon(
                          Icons.add_location, color: Colors.orange[500],),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                        ),
                      ),
                      controller: _address,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 10),
                    new TextFormField(
                      decoration: new InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500]),
                        ),
                        errorText: _validate
                            ? 'الحقل لا يمكن ان يكون خالي '
                            : null,
                        labelText: "البريد الاكتروني",
                        labelStyle: TextStyle(color: Colors.orange[500]),
                        fillColor: Colors.blueGrey,
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

                    SizedBox(height: 10),
                    new TextFormField(
                      decoration: new InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange[500]),
                          ),
                          errorText: _validate
                              ? 'الحقل لا يمكن ان يكون خالي '
                              : null,
                          labelText: "كلمة المرور",
                        fillColor: Colors.blueGrey,
                        labelStyle: TextStyle(color: Colors.orange[500]),
                          icon: Icon(
                            FontAwesomeIcons.key, color: Colors.orange[500],),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                        ),),
                      controller: _pass1,
                      key: passKey,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      validator: (password) {
                        var result = password.length < 4
                            ? "كلمة السر يجب ان تكون اكثر من 4 "
                            : null;
                        return result;
                      },
                    ),
                    SizedBox(height: 10),
                    new TextFormField(
                      decoration: new InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange[500]),
                          ),
                          errorText: _validate
                              ? 'الحقل لا يمكن ان يكون خالي '
                              : null,
                          labelText: " تاكيد كلمة المرور",
                        fillColor: Colors.blueGrey,
                        labelStyle: TextStyle(color: Colors.orange[500]),
                          icon: Icon(
                            FontAwesomeIcons.key, color: Colors.orange[500],),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                        ),),
                      controller: _pass2,
                      obscureText: true,
                      validator: (confirmation) {
                        var password = passKey.currentState.value;
                        return equals(confirmation, password)
                            ? null
                            : "عدم تطابق كلمة المرور";
                      },
                      keyboardType: TextInputType.text,

                    ),
                    SizedBox(height: 10),

                    new TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: _details,
                      minLines: 2,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500]),
                        ),
                        fillColor: Colors.blueGrey,
                        hintText: "اوصف مهاراتك التعليمية التي تجعلك مدرس مختلف",

                        icon: Icon(Icons.create, color: Colors.orange[500],),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                        ),

                      ),
                    ),
                    SizedBox(height: 10),
                    new TextFormField(
                      decoration: new InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange[500]),
                          ),
                          errorText: _validate
                              ? 'الحقل لا يمكن ان يكون خالي '
                              : null,
                          labelText: "العمر",
                        fillColor: Colors.blueGrey,
                        labelStyle: TextStyle(color: Colors.orange[500]),
                          icon: Icon(
                            Icons.access_alarm, color: Colors.orange[500],),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                        ),),
                      controller: _age,
                      keyboardType: TextInputType.number,

                    ),
                    SizedBox(height: 10),
                    new TextFormField(
                      decoration: new InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500]),
                        ),

                        labelText: " اجور التدريس كاملة",
                        labelStyle: TextStyle(color: Colors.orange[500]),
                        errorText: _validate
                            ? 'الحقل لا يمكن ان يكون خالي '
                            : null,
                        fillColor: Colors.grey,
                        icon: Icon(
                          FontAwesomeIcons.moneyCheckAlt, color: Colors.orange[500],),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                        ),
                      ),
                      controller: _fee,
                      style: TextStyle(color: Colors.blueGrey),
                      keyboardType: TextInputType.number,

                    ),
                    SizedBox(height: 10),
                    new TextFormField(
                      decoration: new InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500]),
                        ),

                        labelText: " القسط الاول",
                        labelStyle: TextStyle(color: Colors.orange[500]),
                        errorText: _validate
                            ? 'الحقل لا يمكن ان يكون خالي '
                            : null,
                        fillColor: Colors.grey,
                        hintText: "القسط الاول لتثبيت الحجز ",
                        icon: Icon(
                          FontAwesomeIcons.moneyCheckAlt, color: Colors.orange[500],),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[500], width: 0.0),
                        ),
                      ),
                      controller: _firstFee,
                      style: TextStyle(color: Colors.blueGrey),
                      keyboardType: TextInputType.number,

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
          SizedBox(child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Colors.blueGrey[700]),), width: 25.0, height: 25.0,),
          onPressed: () {
            setState(() {
              if (!mounted) return;
              _isLoading = false;
            });

            setState(() {
              if (_email.text.isEmpty && _pass1.text.isEmpty &&
                  _pass2.text.isEmpty &&
                  _fullname.text.isEmpty && _academicqualify.text.isEmpty &&
                  _number.text.isEmpty &&
                  _experience.text.isEmpty && _details.text.isEmpty &&
                  _age.text.isEmpty && _fee.text.isEmpty && _firstFee.text.isEmpty

              ) {
                _validate = true;
              }
              else {
                _validate = false;
              }
            });

            setState(() {
              if (!mounted) return;
              _isLoading = false;
            });

            if (_validate == false && _pass2.text == _pass1.text) {

              uploadImage(fullImageName,context).then((path){
                fullImagePath = path;
              FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: _email.text, password: _pass2.text
              ).then((singedUser) {






                UserToDatabase().addNewTeacher(user: singedUser,
                  context: context,
                  status: "1",
                  fullname: _fullname.text,
                  academicqualify: _academicqualify.text,
                  number: _number.text,
                  address: _address.text,
                  subject: _subject,
                  experience: _experience.text,
                  gender: _gender,
                  age: _age.text,
                  details: _details.text,
                  teacherImage:'$fullImagePath',
                  fee: _fee.text,
                  firstFee: _firstFee.text,

                );
                singedUser.sendEmailVerification();



                Future.delayed(
                    Duration(seconds: 10), () {
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (context) => LoginPage()));

                }
                );

                _snack(context: context,
                  title: "يرجى الأنتضار ",
                  message: "  تم ارسال رسالة التأكيد الى بريدك الاكتروني",
                  duration1: 12,);

              });

                setState(() {
                  if (!mounted) return;
                  _isLoading = true;
                });

              }).catchError((e) {
                print(e);
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







  Future<String> uploadImage(fullImageName,context ) async {

    StorageReference ref = FirebaseStorage.instance.ref().child(fullImageName);
    StorageUploadTask uploadTask = ref.putFile(image);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = dowurl.toString();

   debugPrint(url);
    return url;
  }



}




//  Future<String> _pickSaveImage() async {
//    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
//
//    setState(() {
//      _image = image;
//    });
//    var now = formatDate(new DateTime.now(), [yyyy,'-', mm ,'-',dd]);
//
//    var fullImageName =  'images/${_fullname.text}-$now'+'.jpg';
//
//    StorageReference ref = FirebaseStorage.instance.ref().child(fullImageName);
//
//    StorageUploadTask uploadTask = ref.putFile(_image);
//
//    return await (await uploadTask.onComplete).ref.getDownloadURL();
//  }




/*
// query multiple collections in firestore

Future<List<DocumentSnapshot>> getSeedID() async{
    var data = await Firestore.instance.collection('users').document(widget.userId).collection('products').getDocuments();
    var productList = data.documents;
    print("Data length: ${productList.length}");
    for(int i = 0; i < productList.length; i++){
      var productId = Firestore.instance.collection('products').document(productList[i]['productId']).documentID;
      if(productId != null) {
        print("Data: " + productId);
      }
    }
    return productList;
  }


    DocumentReference documentReference =
                Firestore.instance.collection("users").document("John");
            documentReference.get().then((datasnapshot) {
              if (datasnapshot.exists) {
                print(datasnapshot.data['email'].toString(););
              }
              else{
                print("No such user");
              }
 */



