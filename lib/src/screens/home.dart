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

  @override
  void initState() {
    catController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this
    );
    catAnimation = Tween(begin: 0.0,end: 100.0)
    .animate(
      CurvedAnimation(parent: catController!, curve: Curves.easeIn)
    );
    catController!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation'),
      ),
      body: buildAnimation(),
    );
  }

  Widget buildAnimation(){
    return AnimatedBuilder(
      animation: catAnimation!, 
      builder: (context, child){
        return Container(
          margin: EdgeInsets.only(top: catAnimation!.value),
          child: child,
        );
      },
      child: const Cat(),
    );
  }
}