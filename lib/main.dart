import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    title: "My Clock",
    home: HomePage(),
  );
  
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  Animation animation;
  AnimationController animationController;


  _currentTime(){
    return "${DateTime.now().hour}:${DateTime.now().minute}";
  }
  
  _HomePageState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController=AnimationController(vsync: this,duration: Duration(seconds: 5));
    animationController.addListener(() {
      if(animationController.isCompleted){
        animationController.reverse();
      }else if(animationController.isDismissed){
        animationController.forward();
      }

      setState(() {

      });

    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    animation=CurvedAnimation(parent:animationController ,curve:Curves.elasticInOut );
    animation=Tween(begin:-0.5 ,end:0.5 ).animate(animation);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: Text("My Animation",style: TextStyle(fontSize: 21.0,fontWeight: FontWeight.bold),),
        elevation: 0.0,
        centerTitle: debugInstrumentationEnabled,
      ),
      
      body:Container(
        color: Colors.green.shade400,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            children: <Widget>[
              Material(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                elevation: 20.0,
                color: Colors.tealAccent,
                
                child: Container(
                  height: 320,
                  width: 300,
                  child: Center(
                    child: Text(_currentTime(),style: TextStyle(
                      color: Colors.black87,fontSize: 30
                    ),),
                  ),
                ),
              )
              ,
              Transform(
                alignment: FractionalOffset(0.5,0.0),
                transform: Matrix4.rotationZ(animation.value),
                child: Container(

                  child: Image.asset("images/pendulum.jpg",height: 200,width:100 ,),

                ),
              )
            ],
          ),
          
        ),

      ) ,
    );
  }
}
