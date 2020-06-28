import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:retro_tv_cars/common/injector.dart';
import 'package:retro_tv_cars/screens/backtothefuture/back_to_the_future_model.dart';
import 'package:provider/provider.dart';

import 'models.dart';

class BackToTheFutureScreen extends StatefulWidget {
  BackToTheFutureScreen({Key key}) : super(key: key);

  @override
  _BackToTheFutureScreenState createState() => _BackToTheFutureScreenState();
}

class _BackToTheFutureScreenState extends State<BackToTheFutureScreen> {
  Timer _timer;
  BackToTheFutureModel model;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BackToTheFutureModel>(
      create: (_) {
        BackToTheFutureModel model =
            BackToTheFutureModel(Injector.audioController);
        _timer = Timer(Duration(seconds: 3), () {
          model.playMainTheme();
        });
        return model;
      },
      child: Consumer<BackToTheFutureModel>(
          builder: (context, BackToTheFutureModel model, child) {
        this.model = model;
        return Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BackToTheFutureWidget(
                timeLapse: TimeLapse(
                    month: "OCT",
                    day: "21",
                    year: "2015",
                    hour: "04",
                    minutes: "29",
                    timeZone: TimeZone.PM,
                    description: "DESTINATION TIME"),
                ledColor: Colors.orange[500],
              ),
              BackToTheFutureWidget(
                timeLapse: TimeLapse(
                    month: "JUL",
                    day: "02",
                    year: "2012",
                    hour: "11",
                    minutes: "49",
                    timeZone: TimeZone.AM,
                    description: "PRESENT TIME"),
                ledColor: Color.fromRGBO(14, 255, 0, 1.0),
              ),
              BackToTheFutureWidget(
                timeLapse: TimeLapse(
                    month: "OCT",
                    day: "26",
                    year: "1985",
                    hour: "01",
                    minutes: "20",
                    timeZone: TimeZone.AM,
                    description: "LAST TIME DEPARTED"),
                ledColor: Colors.yellow[500],
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    model.dispose();
    _timer.cancel();
  }
}

class BackToTheFutureWidget extends StatefulWidget {
  final timeLapse;
  final ledColor;

  BackToTheFutureWidget({Key key, this.timeLapse, this.ledColor});

  @override
  _BackToTheFutureWidgetState createState() => _BackToTheFutureWidgetState();
}

class _BackToTheFutureWidgetState extends State<BackToTheFutureWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        color: Colors.grey[700],
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                dateSection(),
                timeZoneSection(),
                hoursAndMinutesSection(),
              ],
            ),
            timeDescription(),
          ],
        ),
      ),
    );
  }

  Widget dateSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        panelButton("MONTH", Colors.red[900], widget.timeLapse.month,
            Colors.black, 100.0),
        panelButton(
            "DAY", Colors.red[900], widget.timeLapse.day, Colors.black, 75.0),
        panelButton("YEAR", Colors.red[900], widget.timeLapse.year,
            Colors.black, 100.0),
      ],
    );
  }

  Widget timeZoneSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        timeZone(TimeZone.AM, "AM", Colors.red[900], Colors.black, 25.0),
        timeZone(TimeZone.PM, "PM", Colors.red[900], Colors.black, 25.0),
      ],
    );
  }

  Widget hoursAndMinutesSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        panelButton(
            "HOUR", Colors.red[900], widget.timeLapse.hour, Colors.black, 75.0),
        twoPoints(),
        panelButton("MIN", Colors.red[900], widget.timeLapse.minutes,
            Colors.black, 75.0),
      ],
    );
  }

  Widget panelButton(String labelOne, Color bgColorOne, String labelTwo,
      Color bgColorTwo, double width) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      width: width,
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 5.0),
              height: 20.0,
              color: bgColorOne,
              child: Center(
                child: Text(
                  labelOne.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )),
          Container(
              width: width,
              height: 70.0,
              decoration: BoxDecoration(
                color: bgColorTwo,
                border: new Border.all(
                    color: Colors.grey, width: 2.0, style: BorderStyle.solid),
              ),
              child: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  labelTwo.toUpperCase(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "Digital",
                      height: 0.9,
                      fontSize: 60.0,
                      fontWeight: FontWeight.normal,
                      color: widget.ledColor),
                ),
              )),
        ],
      ),
    );
  }

  Widget timeZone(TimeZone timeZone, String labelOne, Color bgColorOne,
      Color bgColorTwo, double width) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: width,
      child: Column(
        children: [
          Container(
              height: 20.0,
              color: bgColorOne,
              child: Center(
                child: Text(
                  labelOne.toUpperCase(),
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )),
          SizedBox(height: 5.0),
          Opacity(
            opacity: timeZone == widget.timeLapse.timeZone ? 1.0 : 0.2,
            child: Container(
              width: 8.0,
              height: 8.0,
              decoration: new BoxDecoration(
                color: widget.ledColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(height: 5.0)
        ],
      ),
    );
  }

  Widget twoPoints() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7.5),
      child: Column(
        children: [
          SizedBox(height: 20.0),
          Container(
            width: 8.0,
            height: 8.0,
            decoration: new BoxDecoration(
              color: widget.ledColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 5.0),
          Column(
            children: [
              Container(
                width: 8.0,
                height: 8.0,
                decoration: new BoxDecoration(
                  color: widget.ledColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget timeDescription() {
    return Column(
      children: [
        timeDescriptionPanel(widget.timeLapse.description, 200.0),
        SizedBox(height: 10.0)
      ],
    );
  }

  Widget timeDescriptionPanel(String labelOne, double width) {
    return Container(
      margin: EdgeInsets.only(left: 20.0),
      width: width,
      child: Column(
        children: [
          Container(
              height: 20.0,
              color: Colors.black,
              child: Center(
                child: Text(
                  labelOne.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }
}
