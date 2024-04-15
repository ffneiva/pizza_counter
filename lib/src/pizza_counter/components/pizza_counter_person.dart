import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:pizza_counter/src/pizza_counter/pizza_counter_controller.dart';

class PizzaCounterPerson extends StatefulWidget {
  final PizzaCounterController pizzaCounterController;

  const PizzaCounterPerson({
    super.key,
    required this.pizzaCounterController,
  });

  @override
  State<PizzaCounterPerson> createState() => _PizzaCounterPersonState();
}

class _PizzaCounterPersonState extends State<PizzaCounterPerson>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double padding = 16;
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    double radius = math.min(width, height) * 0.8 * 0.25;
    double otherWidgetsVerticalOffset = (width >= height) ? 0 : 80;
    double otherWidgetsHorizontalOffset = (height >= width) ? 0 : 150;
    double verticalOffset = MediaQuery.sizeOf(context).height * 0.5 -
        radius / 2 -
        kToolbarHeight -
        otherWidgetsVerticalOffset / 2 +
        padding;
    double horizontalOffset = MediaQuery.sizeOf(context).width * 0.5 -
        radius / 2 -
        otherWidgetsHorizontalOffset / 2;

    return GestureDetector(
      onTap: _countPizza,
      onLongPress: () {
        widget.pizzaCounterController.personRemoveCounter();
        setState(() {});
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: AnimatedBuilder(
              animation: animationController,
              builder: (_, child) {
                return Transform.rotate(
                  angle: animationController.value * 2 * math.pi,
                  child: child,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/images/logo.png'),
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).canvasColor.withOpacity(0.5),
                      BlendMode.dstATop,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: verticalOffset,
            left: horizontalOffset,
            child: Container(
              width: radius,
              height: radius,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 255, 160, 0),
              ),
              child: Center(
                child: Text(
                  widget.pizzaCounterController.personCounter.toString(),
                  style: TextStyle(
                    fontSize: radius * 0.4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _animate() {
    animationController.reset();
    animationController.status == AnimationStatus.forward
        ? animationController.stop()
        : animationController.forward();
  }

  void _countPizza() {
    _animate();
    widget.pizzaCounterController.personAddCounter();
    setState(() {});
  }
}
