import 'package:flutter/material.dart';
import 'package:hire_itc/model/Student.dart';




class StudentInformation extends StatefulWidget{
  final Student student ;
  StudentInformation(this.student);
  @override
  State<StatefulWidget> createState() => new _StudentInformationState();

}


class _StudentInformationState extends State<StudentInformation>{
  final Student student;
  _StudentInformationState({this.student});



  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('معلومات الطالب',style: TextStyle(color: Colors.white,fontFamily: 'Mirza2',),),
        iconTheme: IconThemeData(
          color: Colors.orange[500], //change your color here
        ),
        backgroundColor: Colors.blueGrey[700],
        centerTitle: true,


      ),


      body: Stack(
          children: <Widget>[
            _buildCoverImage(screenSize),
            SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: screenSize.height / 6.4),
                        _buildProfileImage(),
                        SizedBox(height: 10.0),
                        _buildFullName(),

                        _buildStatus(context),
                        _buildStatContainer(),
                        _buildBio(context),
                        _buildSeparator(screenSize),
                        SizedBox(height: 10.0),

                        SizedBox(height: 8.0),
                        _buildButtons(),
                      ],
                    )
                )
            )
          ]
      ),


    );
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/cover.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.student.studentImage),
              fit: BoxFit.fill
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 4.0,
          ),
        ),
      ),
    );
  }


  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'mirza',
      color: Colors.black,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      backgroundColor: Colors.white,
    );

    return Text(
      widget.student.fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        widget.student.gender,
        style: TextStyle(
          fontFamily: 'mirza',
          color: Colors.blueGrey,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'mirza',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color:  Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("الرقم ", widget.student.number),
          _buildStatItem("قسم العلمي", widget.student.department2),
          _buildStatItem("القسط العام", widget.student.department),

        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'mirza',
      fontWeight: FontWeight.w400,//try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[

            Text(
              widget.student.TeacherName,
              textAlign: TextAlign.center,
              style: bioTextStyle,
            ),
            SizedBox(height: 3.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.phone,color: Colors.orange[500],),
                SizedBox(width: 2.0,),
                Text('${widget.student.number}',style: TextStyle(color: Colors.blueGrey)),
              ],),

          ],)
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.orange[500],
      margin: EdgeInsets.only(top: 4.0),

    );
  }




  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {


              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(

                  border: Border.all(),
                  color: Colors.blueGrey[700],

                ),
                child: Center(
                  child: Text(
                    "ارسل رسالة",
                    style: TextStyle(
                      color: Colors.orange[500],
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => {},
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "تنبيه",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}