import 'package:flutter/material.dart';

class AnimatedScaleTile extends StatefulWidget {
  final String backgroundImage;
  final String iconImage;

  AnimatedScaleTile({
    required this.backgroundImage,
    required this.iconImage,
  });

  @override
  _AnimatedScaleTileState createState() => _AnimatedScaleTileState();
}

class _AnimatedScaleTileState extends State<AnimatedScaleTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: (details) {
          _onTapUp(details);
        },
        onTapCancel: _onTapCancel,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/${widget.backgroundImage}'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: Offset(0, 10), // changes position of shadow
                  ),
                ],
              ),
            ),
            Positioned(
              bottom:
                  -30, // Adjust this value to move the icon partially outside
              right: -20, // Adjust this value to position the icon to the right
              child: Image.asset(
                'assets/${widget.iconImage}',
                width: 90, // Increase the width
                height: 90, // Increase the height
              ),
            ),
          ],
        ),
      ),
    );
  }
}
