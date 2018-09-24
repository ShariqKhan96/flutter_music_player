import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_music_player/songs.dart';
import 'package:flutter_music_player/theme.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MusicPlayerClass();
}

class MusicPlayerClass extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,

        leading: new IconButton(icon: new Icon(Icons.arrow_back_ios
          ,
          color: const Color(0xFFDDDDDD),),
            onPressed: () {}),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.menu,
            color: const Color(0xFFDDDDDD),),
              onPressed: () {})
        ],

      ),
      body: new Column(
        children: <Widget>[

          //seekbar
          new Expanded(
            child: Center(
              child: new Container(
                width: 125.0,
                height: 125.0,


                child: RadialProgressBar(
                  progressPercent: 0.2,
                  thumbPosition: 0.2,
                  progressColor: accentColor,
                  thumbColor: lightAccentColor,
                  trackColor: const Color(0xFFDDDDDD),
                  innerPadding: const EdgeInsets.all(10.0),
                  child: ClipOval(

                    clipper: new CircleClipper(),

                    child: new Image.network(demoPlaylist.songs[0].albumArtUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

          ),

          //visualizer

          new Container(
            width: double.infinity,
            height: 125.0,
          ),


          ///controls and song name, title
          Container(

            width: double.infinity,
            child: Material(
              color: accentColor,
              //the reason of using material widget is iconbutton tap transitions
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                child: new Column(
                  children: <Widget>[
                    new RichText(
                      text: new TextSpan(
                          text: '',
                          children: [
                            new TextSpan(
                                text: 'Song  title\n',
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 4.0,
                                    height: 1.5
                                )
                            ), new TextSpan(
                                text: 'Song  Name\n',
                                style: new TextStyle(
                                    color: Colors.white.withOpacity(0.75),
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 4.0,
                                    height: 1.5
                                )
                            ),


                          ]
                      ),


                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Row(
                        children: <Widget>[

                          new Expanded(
                            child: new Container(),
                          ),


                          new IconButton(
                              icon: Icon(Icons.skip_previous,
                                color: Colors.white, size: 35.0,
                              ),
                              splashColor: lightAccentColor,
                              highlightColor: Colors.transparent,

                              onPressed: () {

                              }),
                          new Expanded(
                            child: new Container(),
                          ),

                          new RawMaterialButton(
                            onPressed: () {},
                            shape: CircleBorder(

                            ),
                            fillColor: Colors.white,
                            splashColor: lightAccentColor,
                            highlightColor: lightAccentColor.withOpacity(0.5),
                            elevation: 10.0,
                            highlightElevation: 5.0,
                            child: new Padding(
                              padding: EdgeInsets.all(8.0),
                              child: new Icon(Icons.play_arrow,
                                color: darkAccentColor,
                                size: 35.0,),
                            ),
                          ),

                          new Expanded(
                            child: new Container(),
                          ),

                          new IconButton(
                            icon: Icon(Icons.skip_next, color: Colors.white,
                              size: 35.0,),
                            onPressed: () {

                            },
                            splashColor: lightAccentColor,
                            highlightColor: Colors.transparent,
                          ),


                          new Expanded(
                            child: new Container(),
                          )
                        ], //playback controls
                      ),
                    )
                  ],
                ),
              ),
            ),

          )
        ],


      ),
    );
  }
}

class RadialProgressBar extends StatefulWidget {

  final double trackWidth;
  final Color trackColor;
  final double progressWidth;
  final Color progressColor;
  final double thumbSize;
  final Color thumbColor;
  final EdgeInsets outerPadding;
  final EdgeInsets innerPadding;

  final double progressPercent;
  final double thumbPosition;
  final Widget child;


  RadialProgressBar({
    this.trackWidth = 3.0,
    this.trackColor = Colors.grey,
    this.progressWidth = 5.0,
    this.progressColor = Colors.black,
    this.thumbSize = 10.0,
    this.thumbColor = Colors.black,
    this.progressPercent = 0.0,
    this.outerPadding = const EdgeInsets.all(0.0),
    this.innerPadding = const EdgeInsets.all(0.0),
    this.thumbPosition = 0.0,
    this.child

  });

  @override
  _RadialSeekBarState createState() => new _RadialSeekBarState();
}

class _RadialSeekBarState extends State<RadialProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.outerPadding,
      child: new CustomPaint(
        foregroundPainter: RadialSeekBarPainter(
          trackWidth: widget.trackWidth,
          trackColor: widget.trackColor,
          progressWidth: widget.progressWidth,
          progressColor: widget.progressColor,
          progressPercent: widget.progressPercent,
          thumbSize: widget.thumbSize,
          thumbColor: widget.thumbColor,
          thumbPosition: widget.thumbPosition,

        ),
        child: Padding(
          child: widget.child,
          padding: _insetsForPainter() + widget.innerPadding,),
      ),
    );
  }

  EdgeInsets _insetsForPainter() {
    final outerThick = max(
        widget.trackWidth, max(widget.progressWidth, widget.thumbSize)) / 2.0;
    return EdgeInsets.all(outerThick);
  }


}

class RadialSeekBarPainter extends CustomPainter {

  final double trackWidth;
  Color trackColor;
  final Paint trackPaint;
  final double progressWidth;
  Color progressColor;
  final Paint progressPaint;
  final double thumbSize;
  Color thumbColor;
  final double progressPercent;
  final double thumbPosition;
  final Paint thumbPaint;

  RadialSeekBarPainter({
    @required this.trackWidth,
    @required trackColor,
    @required this.progressWidth,
    @required progressColor,
    @required this.thumbSize,
    @required thumbColor,
    @required this.progressPercent,
    @required this.thumbPosition,
  })
      : trackPaint = new Paint()
    ..color = trackColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = trackWidth,
        progressPaint= new Paint()
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = progressWidth
          ..strokeCap = StrokeCap.round,
        thumbPaint = new Paint()
          ..color = thumbColor
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final outerThickness = max(trackWidth, max(progressWidth, thumbSize));
    Size constrainedSize = new Size(
        size.width - outerThickness, size.height - outerThickness);

    final center = new Offset(size.width, size.height) / 2.0;
    final radius = min(constrainedSize.width, constrainedSize.height) / 2.0;
    final progressAngle = 2 * pi * progressPercent;


    canvas.drawCircle(center, radius, trackPaint);
    canvas.drawArc(new Rect.fromCircle(
        center: center,
        radius: radius
    ), -pi / 2, progressAngle, false, progressPaint);


    //paint thumb
//

    final thumbRadius = thumbSize / 2.0;
    final thumbAngle = 2 * pi * thumbPosition - (pi / 2);
    final thumbX = cos(thumbAngle) * radius;
    final thumbY = sin(thumbAngle) * radius;
    final thumbCenter = new Offset(thumbX, thumbY) + center;


    canvas.drawCircle(thumbCenter, thumbRadius, thumbPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CircleClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return new Rect.fromCircle(
        center: new Offset(size.width, size.height) / 2.0,
        radius: min(size.width, size.height) / 2.0
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }

}


