
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:referease/model/question.dart';
import 'package:referease/model/questionsrepo.dart';
import 'package:referease/model/summary.dart';
import 'package:referease/uipage/search/help.dart';
import 'package:referease/uiutility/colors.dart';
import 'package:referease/uiutility/reusable.dart';


class SummaryEdit extends StatefulWidget{


  final String type;
  DocumentSnapshot documentSnapshot;

  final Summary summary;

  SummaryEdit({Key key, this.type,this.summary, this.documentSnapshot}): assert(type!=null), super(key:key);

  @override
  _SummaryEditState createState() => _SummaryEditState();

}

class _SummaryEditState extends State<SummaryEdit> {


  List <Question> sectionQuestions;
  List <String> sectionQuestionsAns;
  int questionPosition;

  TextEditingController titleController ;
  TextEditingController authorsController ;
  TextEditingController yearController ;

  FirebaseUser _currentUser;



  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    titleController= TextEditingController();
    authorsController= TextEditingController();
    yearController= TextEditingController();

    titleController.text= widget.summary.title;
    authorsController.text= widget.summary.authors;
    yearController.text= widget.summary.year;


    if(widget.type =="reflect"){
      sectionQuestions = QuestionRepository.loadQuestions(QuestionType.reflect);
    }else if (widget.type =="discuss"){
      sectionQuestions = QuestionRepository.loadQuestions(QuestionType.discuss);
    }

    sectionQuestionsAns = new List(sectionQuestions.length);
    sectionQuestionsAns = widget.summary.answers;
    questionPosition=0;
    setState(() {

    });




  }


  getUserData() async{
    _currentUser = await FirebaseAuth.instance.currentUser();
  }


  Future<Null> openDialog() async{

    TextEditingController lnCont= new TextEditingController();
    TextEditingController midCont= new TextEditingController();
    TextEditingController fnCont = new TextEditingController();

    switch(
    await showDialog(context: context,

        builder: (BuildContext context){
          return SimpleDialog(
            contentPadding: EdgeInsets.only(left: 8.0, right: 8.0, top: 0.0, bottom: 0.0),
            children: <Widget>[
              Container(
                color: kReferSurfaceWhite,
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                height: 200.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    SizedBox(height: 4.0,),
                    Expanded(
                      child: TextFormField(
                        controller: lnCont,
                        decoration: InputDecoration(
                            labelText: "Last Name"
                        ),//input decorator

                        onFieldSubmitted: (value){}, textCapitalization: TextCapitalization.words,),
                    ),
                    SizedBox(height: 8.0,),

                    Expanded(
                      child: TextFormField(
                        controller: midCont,
                        decoration: InputDecoration(
                            labelText: "Middle Name"
                        ),//input decorator

                        onFieldSubmitted: (value){},
                        validator: (input)=>input.length<0?'this field cannot be empty':null,
                      ),
                    ),

                    SizedBox(height: 8.0,),

                    Expanded(
                      child: TextFormField(
                        controller: fnCont,
                        decoration: InputDecoration(
                            labelText: "First Name"
                        ),//input decorator

                        onFieldSubmitted: (value){},
                        validator: (input)=>input.length<0?'this field cannot be empty':null,
                      ),
                    ),


                  ],//widget
                ),
              ),//container

              SimpleDialogOption(

                onPressed: () {
                  Navigator.pop(context, 0);
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    Container(
                      padding: EdgeInsets.only(bottom: 10.0, top: 0.0),
                      child: Text(
                        'Add Author',
                        style: TextStyle(
                            color: kReferAccent, fontWeight: FontWeight.bold, fontSize: 14.0 ),
                      ),
                    )
                  ],
                ),

              ),//simpledialogoption



            ],//shildren
          );//simpleDialog
        }//builder

    )//showdialog


    ){
      case 0:

      case 1: setState(() {

      if(authorsController.text.isEmpty){
        authorsController.text =  "${lnCont.text}, ${fnCont.text} ${midCont.text}";
      }else{
        authorsController.text =  "${authorsController.text}; ${lnCont.text}, ${fnCont.text} ${midCont.text}";
      }
      });// Navigator.of(context).pop();

      break;

    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        centerTitle: true,
        title: Text('Edit a summary'), /*Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: <Widget>[
              Text('New Summary',
                  style: TextStyle(
                      fontSize: 40.0, fontWeight: FontWeight.bold)
              ),
              Text('.',
                  style: TextStyle( color: kReferAccent,
                      fontSize: 40.0, fontWeight: FontWeight.bold)
              ),
            ],
          ),
        ), */ //Text('Add Source'),

        elevation: 0.0,

        backgroundColor:kReferSurfaceWhite ,

        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.help_outline, semanticLabel: 'help',),
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => Help(3),) );
            },
          ),
        ],

      ),//appbar

      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /*-------- leading fields------- */
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: <Widget>[
                      Text( (widget.type=="reflect")?'Reflect':'Discuss',
                          style: TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.bold)
                      ),
                      Text('.',
                          style: TextStyle( color: kReferAccent,
                              fontSize: 40.0, fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.0,),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: kReferAltDarkGrey),
                      // hintText: 'EMAIL',
                      // hintStyle: ,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kReferAccent))
                  ),
                ),
                SizedBox(height: 12.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: <Widget>[
                    Text(
                      'Add authors',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),

                    ),//text
                    Expanded(child: Container(),),

                    GestureDetector(
                        onTap:(){
                          openDialog();
                        } ,//_submit,
                        child: Icon(Icons.add_box)
                    ),
                  ],
                ),//row
                SizedBox(height: 6.0,),

                TextField(
                  controller: authorsController,
                  decoration: InputDecoration(
                      labelText: 'Author(s) (separated by ; )',
                      hintText: 'e.g. Smith, M ; Pavel, G ',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: kReferAltDarkGrey),
                      // hintText: 'EMAIL',
                      // hintStyle: ,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kReferAccent))
                  ),
                ),
                SizedBox(height: 12.0,),
                TextField(
                  controller: yearController,
                  decoration: InputDecoration(
                      labelText: 'Year',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: kReferAltDarkGrey),
                      // hintText: 'EMAIL',
                      // hintStyle: ,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kReferAccent))
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12.0,),

                /*--------End leading fields------- */
                /*--------Question PageView ------- */
                ConstrainedBox(constraints: BoxConstraints(
                  maxHeight: 300.0,
                  minHeight: 100.0,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                  child: // _buildPageElement()[questionPosition],
                  new QuestionView(question: sectionQuestions[questionPosition],
                    answer: sectionQuestionsAns[questionPosition],
                    onValueChanged: (value){
                      sectionQuestionsAns[questionPosition] = value;
                      print("value: ${sectionQuestionsAns[questionPosition]}");
                    },
                    total: sectionQuestions.length,),


                )
              ],//column children
            ),//column
          )//listpadding
        ],
      ),//listview


      floatingActionButton: FloatingActionButton(child: Icon(Icons.save),
          onPressed: (){


            if(widget.documentSnapshot!=null){
              var value;
              Firestore.instance.runTransaction((Transaction trans) async{

                await trans.update(widget.documentSnapshot.reference, {
                  'title' : titleController.text,
                  'authors':authorsController.text,
                  'year':yearController.text,
                  'answers': sectionQuestionsAns,
                  'uid':_currentUser.uid,
                  });

              });

              Fluttertoast.showToast(msg: "The summary has been updated" ,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 2,
                  backgroundColor: kReferAccent,
                  textColor: Colors.white
              );

            }






          }),//onpress

      bottomNavigationBar: BottomAppBar( elevation: 8.0,

        color: kReferPrimary,
        child: Container( height: 50.0,
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.arrow_left , size: 40.0,),
                onTap: (){

                  // pageController.previousPage(duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
                  if(questionPosition>0){
                    questionPosition--;
                    setState(() {
                      print(questionPosition); print(sectionQuestionsAns[questionPosition]);
                    });
                  }
                },
              ),

              Expanded(child: Container(),),
              GestureDetector(
                  onTap: (){
                    //pageController.nextPage(duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);

                    if(questionPosition < sectionQuestions.length-1){
                      questionPosition++;
                      setState(() {
                        print(questionPosition);  print(sectionQuestionsAns[questionPosition]);
                      });
                    }
                  },
                  child: Icon(Icons.arrow_right, size: 40.0,)),
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


    );//scaffold
  }
}


typedef Null ValueChangeCallback(String value);

class QuestionView extends StatefulWidget{

  final int total;
  final Question question;
  final String answer;
  final ValueChangeCallback onValueChanged;

  QuestionView({this.total, this.onValueChanged, this.question, this.answer});

  @override
  QuestionViewState createState() => new QuestionViewState();

}

class QuestionViewState extends State<QuestionView> {

  TextEditingController answerController ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    answerController= TextEditingController();

    answerController.clear();

    answerController.text = widget.answer;

    answerController.addListener(_printLatestValue);

  }


  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    widget.onValueChanged(answerController.text);
    //  widget.answer = answerController.text;
    print("Second text field: ${answerController.text}");
  }


  @override
  Widget build(BuildContext context) {
    if(widget.answer!=null){
      answerController.text = widget.answer;
    }else{
      answerController.clear();
    }
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            'Question ${widget.question.id} of ${widget.total}: ${widget.question.questionDesc}',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold),

          ),
        ),//text
        SizedBox(height: 24.0,),

        Expanded(
          flex: 9,
          child: Container(
            child: TextField(
              controller: answerController,
              maxLines: 7,
              decoration: InputDecoration(hintText: 'Comments',  ),
            ),
          ),
        )
      ],


    );
  }
}