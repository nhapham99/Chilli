import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget({
    Key? key,
    this.hintText,
    this.maxTextLength = 20,
    this.controller,
    this.onChange,
  }) : super(key: key);

  final String? hintText;

  final int? maxTextLength;

  final TextEditingController? controller;

  final Function(String)? onChange;

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> with TickerProviderStateMixin {
  int textLength = 0;

  late AnimationController _counterVisibilityAnimationController;

  late Animation<double> _counterVisibilityAnimation;

  late AnimationController _counterJumpingAnimationController;

  @override
  void initState() {
    super.initState();
    print("--CustomTextFieldWidget: initState--");
    _counterVisibilityAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    final counterVisibilityCurve = CurvedAnimation(parent: _counterVisibilityAnimationController, curve: Curves.elasticInOut);
    _counterVisibilityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(counterVisibilityCurve);
  }

  @override
  void dispose() {
    print("--CustomTextFieldWidget: dispose--");
    _counterVisibilityAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
                fontSize: 16.0.sp,
                color: Colors.white.withOpacity(0.6),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              fillColor: Colors.black.withOpacity(0.08),
              filled: true,
              counterText: "",
            ),
            maxLength: widget.maxTextLength,
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              fontSize: 16.0.sp,
              color: Colors.white,
            ),
            onChanged: (text) {
              setState(() {
                if (textLength == 0 && text.isNotEmpty) {
                  textLength = text.length;
                  _counterVisibilityAnimationController.forward();
                } else if (textLength == 1 && text.isEmpty) {
                  textLength = text.length;
                  _counterVisibilityAnimationController.reverse();
                } else {
                  textLength = text.length;
                  _counterJumpingAnimationController.forward(from: 0.75);
                }
              });
              if (widget.onChange != null) widget.onChange!(text);
            },
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ScaleTransition(
            scale: _counterVisibilityAnimation,
            child: ZoomIn(
              duration: const Duration(milliseconds: 200),
              controller: (controller) => _counterJumpingAnimationController = controller,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 60,
                height: 30,
                child: Center(
                  child: Text(
                    "$textLength / ${widget.maxTextLength}",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0.sp,
                      color: const Color(0xFFDC6B66),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
