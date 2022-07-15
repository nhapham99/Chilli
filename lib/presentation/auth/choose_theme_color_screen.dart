import 'dart:ui';

import 'package:chilli/blocs/app_setup/app_setup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseThemeColorScreen extends StatefulWidget {
  const ChooseThemeColorScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseThemeColorScreen> createState() => _ChooseThemeColorScreenState();
}

class _ChooseThemeColorScreenState extends State<ChooseThemeColorScreen> {
  late PageController _pageController;

  double _scrollAmount = 0.0;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    print("--ChooseThemeColorSreen: initState--");
    _pageController = PageController(viewportFraction: 1 / 3, initialPage: currentIndex);
    _pageController.addListener(() {
      setState(() {
        _scrollAmount = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    print("--ChooseThemeColorSreen: dispose--");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<AppSetupBloc>(),
      builder: (context, state) {
        List<List<Color>> listColors = context.read<AppSetupBloc>().listColors;
        return PageView.builder(
          controller: _pageController,
          itemBuilder: (_, index) {
            currentIndex = index;
            return _buildColorSelectors(
              listColors[index],
              currentIndex,
              _scrollAmount,
            );
          },
          itemCount: listColors.length,
        );
      },
    );
  }
}

Widget _buildColorSelectors(final List<Color> colors, int index, double scrollAmount) {
  const double diameter = 30.0;

  final double clampedDifference = (scrollAmount - index).clamp(-1, 1);

  final Offset offset = Offset(0.0, 128.0 * clampedDifference);

  final double scale = lerpDouble(1.0, 0.7, clampedDifference.abs())!;

  return Transform.translate(
    offset: offset,
    child: Transform.scale(
      scale: scale,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          border: Border.all(width: 3.0, color: Colors.white),
        ),
      ),
    ),
  );
}
