import 'dart:math';

import 'package:animation/src/widgets/cat.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {

  Animation<double>? catAnimation;
  AnimationController? catController;
  Animation<double>? boxAnimation;
  AnimationController? boxController;

  @override
  void initState() {
    catController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this
    );
    catAnimation = Tween(begin: -35.0,end: -80.0)
    .animate(
      CurvedAnimation(parent: catController!, curve: Curves.easeIn)
    );

    boxController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this //for the ticker provider mixin
    );
    boxAnimation = Tween(begin: pi*0.6,end: pi*0.65) 
    .animate(
      CurvedAnimation(
        parent: boxController!, 
        curve: Curves.easeInOut //how the tween moves from the begin value to end value 
      )
    );
    boxController!.forward();
    boxAnimation!.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        boxController!.reverse();
      }else if(status == AnimationStatus.dismissed){
        boxController!.forward();
      }
    });
    catAnimation!.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        boxController!.stop();
      }else if(status == AnimationStatus.dismissed){
        boxController!.forward();
      }
    });

    super.initState();
  }

  onTap(){
    if(catController!.status == AnimationStatus.completed){
      // boxController!.forward();
      catController!.reverse();
    }else if(catController!.status == AnimationStatus.dismissed){
      // boxController!.stop();
      catController!.forward();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation'),
      ),
      body: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              buildCatAnimation(),
              buildbox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
          ),
        ),
      )
      
    );
  }

  Widget buildCatAnimation(){
    return AnimatedBuilder(
      animation: catAnimation!, 
      builder: (context, child){
        return Positioned(
          top: catAnimation!.value,
          right: 0,
          left: 0,
          child: child!,
        );
      },
      child: const Cat(),
    );
  }

  Widget buildbox(){
    return Container(
      height: 200,
      width: 200,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap(){
    return Positioned(
      left: 3,
      top: 2,
      child: AnimatedBuilder(
        animation: boxAnimation!,
        builder: (context, child){
          return Transform.rotate(
            alignment: Alignment.topLeft,
            angle: boxAnimation!.value,
            child: child
          );
        },
        child: Container(
          height: 10,
          width: 125,
          color: Colors.brown,
        ),
      ),
    );
  }

  Widget buildRightFlap(){
    return Positioned(
      right: 3,
      top: 2,
      child: AnimatedBuilder(
        animation: boxAnimation!,
        builder: (context, child){
          return Transform.rotate(
            alignment: Alignment.topRight,
            angle: -boxAnimation!.value,
            child: child
          );
        },
        child: Container(
          height: 10,
          width: 125,
          color: Colors.brown,
        ),
      ),
    );
  }
}