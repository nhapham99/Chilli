import 'package:chilli/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class InputUsernameScreen extends StatefulWidget {
  const InputUsernameScreen({
    Key? key,
    required this.onTapConfirm,
  }) : super(key: key);

  final Function() onTapConfirm;

  @override
  State<InputUsernameScreen> createState() => _InputUsernameScreenState();
}

class _InputUsernameScreenState extends State<InputUsernameScreen> {
  bool canContinue = false;

  @override
  void initState() {
    super.initState();
    print("--InputUsernameScreen: initState--");
  }

  @override
  void dispose() {
    print("--InputUsernameScreen: dispose--");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Text(
            "Nice to meet you! What do your friend call you?",
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              fontSize: 18.0.sp,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          CustomTextFieldWidget(
            hintText: "Your nickname...",
            onChange: (text) {
              if (text.isNotEmpty) {
                setState(() {
                  canContinue = true;
                });
              } else {
                setState(() {
                  canContinue = false;
                });
              }
            },
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              if (canContinue) {
                widget.onTapConfirm();
              }
            },
            child: Opacity(
              opacity: canContinue ? 1.0 : 0.4,
              child: Container(
                height: 60,
                width: 80.0.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "CONTINUE",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0.sp,
                      color: const Color(0xFFDC6B66),
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
