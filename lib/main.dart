import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Offset> _points = <Offset>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details){
            setState(() {
              RenderBox object = context.findRenderObject();
              Offset _localPosition = object.globalToLocal(details.globalPosition);
              _points = new List.from(_points)..add(_localPosition);

            });
          },
          onPanEnd: (DragEndDetails details){
            _points.add(null);
          },

          child: CustomPaint(
            painter: Signature(points: _points),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _points.clear();
        },
        child: Icon(Icons.clear),
      ),
    );
  }
}


class Signature extends CustomPainter{

  List<Offset> points;

  Signature({this.points});

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

   for(int i= 0; i < points.length -1; i++){
     if(points[i] != null && points[i+1] != null){
       canvas.drawLine(points[i], points[i+1], paint);
     }
   }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) {
    
    return oldDelegate.points != points;
  }
  
}

