import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:retro_tv_cars/common/injector.dart';

import 'knight_rider_model.dart';
import 'voice_panel_controller.dart';
import 'models.dart';
import 'package:provider/provider.dart';

class KnightRiderScreen extends StatefulWidget {
  KnightRiderScreen({Key key}) : super(key: key);

  @override
  _KnightRiderScreenState createState() => _KnightRiderScreenState();
}

class _KnightRiderScreenState extends State<KnightRiderScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(flex: 4, child: leftPanel()),
          Expanded(flex: 2, child: CentralPanel()),
          Expanded(flex: 4, child: rightPanel()),
        ],
      ),
    );
  }

  Widget leftPanel() {
    return Container(
      child: Container(
        alignment: Alignment.centerRight,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            panelButton("ALT", Colors.yellow),
            panelButton("OIL PRESS", Colors.yellow),
            panelButton("OIL TEMP", Colors.red),
            panelButton("EGT", Colors.red),
            panelButton("FUEL", Colors.red),
          ],
        ),
      ),
    );
  }

  Widget rightPanel() {
    return Container(
      child: Container(
        color: Colors.black,
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            panelButton("AUX", Colors.yellow),
            panelButton("SAT COMM", Colors.yellow),
            panelButton("ACC", Colors.red),
            panelButton("RADAR", Colors.red),
            panelButton("MP1", Colors.red),
          ],
        ),
      ),
    );
  }

  Widget panelButton(String label, Color bgColor) {
    return Container(
        width: 90.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: bgColor,
          border: new Border.all(
              color: Colors.black, width: 2.0, style: BorderStyle.solid),
        ),
        child: Center(
          child: Text(
            label.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
  }
}

class CentralPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<KnightRiderModel>(
      create: (_) {
        return KnightRiderModel(Mode.normal_cruise, VoicePanelController(),
            Injector.audioController);
      },
      child: Column(
        children: [
          Expanded(flex: 55, child: VoicePanel()),
          Expanded(
            flex: 45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    threePanels(),
                    ModeSelectorPanel(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget threePanels() {
    return Column(
      children: [
        Container(width: 25, height: 50, color: Colors.yellow),
        SizedBox(height: 2.0),
        Container(width: 25, height: 50, color: Colors.yellow),
        SizedBox(height: 2.0),
        Container(width: 25, height: 50, color: Colors.yellow),
      ],
    );
  }
}

class ModeSelectorPanel extends StatefulWidget {
  @override
  _ModeSelectorPanelState createState() => _ModeSelectorPanelState();
}

class _ModeSelectorPanelState extends State<ModeSelectorPanel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        modeSelector(Mode.normal_cruise, "NORMAL CRUISE",
            Color.fromRGBO(14, 255, 0, 1.0)),
        modeSelector(Mode.auto_cruise, "AUTO CRUISE", Colors.yellow),
        modeSelector(Mode.pursuit, "PURSUIT", Colors.red),
      ],
    );
  }

  Widget modeSelector(Mode mode, String label, Color color) {
    return GestureDetector(
        child: ModeSelector(mode, label, color),
        onTap: () {
          setState(() {
            Provider.of<KnightRiderModel>(context, listen: false).setMode(mode);
          });
        });
  }
}

class ModeSelector extends StatefulWidget {
  final Mode mode;
  final String label;
  final Color bgColor;

  ModeSelector(this.mode, this.label, this.bgColor);

  @override
  _ModeSelectorState createState() => _ModeSelectorState();
}

class _ModeSelectorState extends State<ModeSelector> {
  @override
  Widget build(BuildContext context) {
    return Consumer<KnightRiderModel>(
        builder: (context, KnightRiderModel model, child) {
      return Opacity(
        opacity: getOpacity(model.currentMode),
        child: Container(
            alignment: Alignment.center,
            width: 90.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: widget.bgColor,
              border: new Border.all(
                  color: Colors.black, width: 2.0, style: BorderStyle.solid),
            ),
            child: Text(
              widget.label.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      );
    });
  }

  getOpacity(Mode currentMode) {
    if (currentMode == widget.mode) {
      return 1.0;
    } else {
      return 0.2;
    }
  }
}

class VoicePanel extends StatefulWidget {
  @override
  _VoicePanelState createState() => _VoicePanelState();
}

class _VoicePanelState extends State<VoicePanel> with TickerProviderStateMixin {
  KnightRiderModel _model;

  AnimationController _animationController;
  Animation<double> _voicePanelAnimation;

  double opacity;

  @override
  void initState() {
    super.initState();
    _onModelReady();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KnightRiderModel>(
        builder: (context, KnightRiderModel model, child) {
      this._model = model;
      triggerAnimationIfNeeded();
      return Container(
        alignment: Alignment.bottomCenter,
        child: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: 17,
          shrinkWrap: true,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                redLight(index, 0),
                redLight(index, 1),
                redLight(index, 2),
              ],
            );
          },
        ),
      );
    });
  }

  Widget redLight(int index, int column) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          int offset = column == 1 ? 2 : 0;
          List<int> lightsToEnable =
              _model.lightsToEnable(_voicePanelAnimation.value, offset);
          return Opacity(
            opacity: lightsToEnable.contains(index) ? 1.0 : 0.2,
            child: Container(
                width: 55.0,
                height: 18.0,
                margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                color: Colors.redAccent),
          );
        });
  }

  void _onModelReady() {
    this.opacity = 0.2;
    _animationController =
        AnimationController(vsync: this, duration: new Duration(seconds: 1));
    _voicePanelAnimation = Tween(begin: 0.0, end: 5.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.bounceIn));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
  }

  void triggerAnimationIfNeeded() {
    if (_model.currentMode == Mode.pursuit) {
      _model.playMainTheme();
      _animationController.forward();
    } else {
      _model.stopPlaying();
      _animationController.stop();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _model.stopPlaying();
    _animationController.dispose();
  }
}
