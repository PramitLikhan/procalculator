import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../screen/Calculator/concaveDecoration.dart';
import 'neumorphicTheme.dart';

class NeuCalculatorButton extends StatefulWidget {
  NeuCalculatorButton({
    Key key,
    @required this.text,
    this.textColor,
    this.textSize,
    this.isPill = false,
    @required this.onPressed,
    this.isChosen = false,
  }) : super(key: key);

  final bool isChosen;
  final bool isPill;
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final double textSize;

  @override
  _NeuCalculatorButtonState createState() => _NeuCalculatorButtonState();
}

class _NeuCalculatorButtonState extends State<NeuCalculatorButton> {
  bool _isPressed = false;

  @override
  void didUpdateWidget(NeuCalculatorButton oldWidget) {
    if (oldWidget.isChosen != widget.isChosen) {
      setState(() => _isPressed = widget.isChosen);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onPointerDown(PointerDownEvent event) {
    setState(() => _isPressed = true);
    widget.onPressed();
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() => _isPressed = widget.isChosen);
  }

  @override
  Widget build(BuildContext context) {
    final neumorphicTheme = Provider.of<CustomNeumorphicTheme>(context);
    final width = MediaQuery.of(context).size.width;
    final squareSideLength = width / 7;
    final buttonWidth = squareSideLength * (widget.isPill ? 2.2 : 1);
    final buttonSize = Size(buttonWidth, squareSideLength);

    final innerShadow = ConcaveDecoration(
      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(buttonSize.width),
        borderRadius: BorderRadius.circular(0),
      ),
      colors: neumorphicTheme.innerShadowColors,
      depression: 10,
    );

    final outerShadow = BoxDecoration(
      border: Border.all(color: Colors.transparent),
//      borderRadius: BorderRadius.circular(buttonSize.width),
      color: neumorphicTheme.buttonColor,
//      color: widget.textColor,
      boxShadow: neumorphicTheme.outerShadow,
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child:
//      Card(
//        elevation: 2,
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(10),
//        ),
//        child:
          Neumorphic(
        style: NeumorphicStyle(
          depth: 3,
          color: Colors.white,
        ),
        child: SizedBox(
          height: buttonSize.height,
          width: buttonSize.width,
          child: Listener(
            onPointerDown: _onPointerDown,
            onPointerUp: _onPointerUp,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 50),
                  padding: EdgeInsets.all(width / 12),
                  decoration: _isPressed ? innerShadow : outerShadow,
                ),
                Center(
                  child: widget.text == 'C'
                      ? Icon(
                          Icons.backspace_outlined,
                          size: 30,
                          color: widget.textColor ?? Theme.of(context).textTheme.bodyText1.color,
                        )
                      : Text(
                          widget.text,
                          style: GoogleFonts.montserrat(
                            fontSize: widget.textSize ?? 40,
                            fontWeight: widget.text == '.' ? FontWeight.bold : FontWeight.w200,
                            color: widget.textColor ?? Theme.of(context).textTheme.bodyText1.color,
//                      color: _isPressed ? Colors.black : Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
//      ),
    );
  }
}
