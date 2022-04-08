import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField(
      {Key? key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      required this.width, this.initialValue})
      : super(key: key);
  final String? initialValue;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: SizedBox(
        width: width,
        child: TextFormField(
          initialValue: initialValue,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.manrope(
                color: const Color.fromRGBO(0, 0, 0, 0.45), fontSize: 15),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0x00000000),
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0x00000000),
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
          ),
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
              color: const Color.fromRGBO(0, 0, 0, 0.45), fontSize: 15),
        ),
      ),
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        depth: -3,
        color: const Color.fromRGBO(245, 245, 245, 1),
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
        lightSource: LightSource.topLeft,
      ),
    );
  }
}
