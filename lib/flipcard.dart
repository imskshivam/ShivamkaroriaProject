import 'package:flutter/material.dart';

import 'dart:math';

import 'package:flutter/material.dart';

class flipcard extends StatefulWidget {
  flipcard(
      {super.key,
      required this.size,
      required this.cVV,
      required this.cardName,
      required this.cardNumber,
      required this.expDate});

  final String cardName;
  final String cardNumber;
  final String cVV;
  final String expDate;

  final Size size;

  @override
  State<flipcard> createState() => _flipcardState();
}

class _flipcardState extends State<flipcard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isFront = true;
  bool _isFlipped = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void _toggleFlip() {
    setState(() {
      _isFlipped = !_isFlipped;

      if (_isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Widget _buildFrontCard() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: widget.size.height * 0.3,
        width: widget.size.width * 0.88,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(49, 21, 175, 0.91),
                  spreadRadius: 1,
                  blurRadius: 15,
                  offset: const Offset(0, 15)),
            ],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
            gradient: LinearGradient(colors: [
              Colors.white.withOpacity(0.4),
              Colors.white.withOpacity(0.18)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Stack(
          children: [
            Positioned(
              top: -15,
              left: -15,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pinkAccent.withOpacity(0.2)),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.greenAccent.withOpacity(0.2)),
              ),
            ),
            Positioned(
              top: widget.size.height * 0.2 * 0.82,
              left: 17,
              child: Container(
                  height: widget.size.height * 0.3 * 0.15,
                  width: widget.size.width * 0.85 * 0.7,
                  child: Text(
                    widget.cardNumber,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
            Positioned(
              top: widget.size.height * 0.2 * 0.99,
              left: 17,
              child: Container(
                  height: widget.size.height * 0.3 * 0.15,
                  width: widget.size.width * 0.85 * 0.7,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.cardName.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  )),
            ),
            Positioned(
              top: widget.size.height * 0.2 * 0.99,
              right: 17,
              child: Container(
                  height: widget.size.height * 0.3 * 0.15,
                  width: widget.size.width * 0.85 * 0.7,
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.expDate,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15),
                      ))),
            ),
            Positioned(
              bottom: 10,
              right: 17,
              child: InkWell(
                onTap: () {},
                child: Container(
                    height: widget.size.height * 0.3 * 0.15,
                    width: widget.size.width * 0.85 * 0.15,
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    return Center(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(-1.0, 1.0),
        child: Container(
          margin: EdgeInsets.only(top: 20),
          height: widget.size.height * 0.3,
          width: widget.size.width * 0.88,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(49, 21, 175, 0.91),
                    spreadRadius: 1,
                    blurRadius: 15,
                    offset: const Offset(0, 15)),
              ],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
              gradient: LinearGradient(colors: [
                Colors.white.withOpacity(0.4),
                Colors.white.withOpacity(0.18)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Stack(
            children: [
              Positioned(
                top: -15,
                left: -15,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.pinkAccent.withOpacity(0.2)),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.greenAccent.withOpacity(0.2)),
                ),
              ),
              Positioned(
                top: widget.size.height * 0.2 * 0.82,
                left: 17,
                child: Container(
                    height: widget.size.height * 0.3 * 0.15,
                    width: widget.size.width * 0.85 * 0.7,
                    child: Text(
                      widget.cardNumber,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ),
              Positioned(
                top: widget.size.height * 0.2 * 0.99,
                left: 17,
                child: Container(
                    height: widget.size.height * 0.3 * 0.15,
                    width: widget.size.width * 0.85 * 0.7,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.cardName.toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    )),
              ),
              Positioned(
                top: widget.size.height * 0.2 * 0.99,
                right: 17,
                child: Container(
                    height: widget.size.height * 0.3 * 0.15,
                    width: widget.size.width * 0.85 * 0.7,
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          widget.expDate,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15),
                        ))),
              ),
              Positioned(
                bottom: 10,
                right: 17,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                      height: widget.size.height * 0.3 * 0.15,
                      width: widget.size.width * 0.85 * 0.15,
                      child: Icon(
                        Icons.remove_red_eye_sharp,
                        color: Colors.white,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleFlip,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(pi * _animation.value);

          return Transform(
            alignment: Alignment.center,
            transform: transform,
            child:
                _animation.value >= 0.5 ? _buildBackCard() : _buildFrontCard(),
          );
        },
      ),
    );
  }
}
