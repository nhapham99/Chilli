import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/bouce_widget.dart';
import '../../../widgets/fade_widget.dart';

class WellcomeWidget extends StatefulWidget {
  const WellcomeWidget({
    Key? key,
    required this.onTapLogin,
    required this.onTapRegister,
  }) : super(key: key);

  final Function() onTapRegister;

  final Function() onTapLogin;

  @override
  State<WellcomeWidget> createState() => _WellcomeWidgetState();
}

class _WellcomeWidgetState extends State<WellcomeWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        FadeWidget(
          delay: const Duration(milliseconds: 1000),
          child: Text(
            'Hi there,',
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              fontSize: 26.0.sp,
              color: Colors.white,
            ),
          ),
        ),
        FadeWidget(
          delay: const Duration(milliseconds: 1000 + 900),
          child: Text(
            "I'm Chilli",
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              fontSize: 32.0.sp,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 15),
        FadeWidget(
          delay: const Duration(milliseconds: 1000 + 1000),
          child: SizedBox(
            width: 60.0.w,
            child: Text(
              "Your new personal self-care comanion",
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
                fontSize: 18.0.sp,
                color: Colors.white.withOpacity(0.45),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: widget.onTapRegister,
          child: BounceWidget(
            duration: const Duration(milliseconds: 2000),
            delay: const Duration(milliseconds: 1000 + 1000 + 800),
            child: Container(
              height: 60,
              width: 75.0.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(-1, -1),
                    blurRadius: 0.2,
                    spreadRadius: 0.3,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'HI, CHILLI !',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5.sp,
                    color: const Color(0xFFDC6B66),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: widget.onTapLogin,
          child: BounceWidget(
            duration: const Duration(milliseconds: 2000),
            delay: const Duration(milliseconds: 1000 + 1000 + 900),
            child: SizedBox(
              width: 75.0.w,
              child: Text(
                "I ALREADY HAVE AN ACCOUNT",
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5.sp,
                  color: Colors.white.withOpacity(0.45),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
