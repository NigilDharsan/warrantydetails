import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warrantydetails/utils/Loader/LoaderController.dart';

class Loader extends StatelessWidget {
  final bool? isLoading;
  final double appIconSize;
  final double borderRadius;
  final double overlayOpacity;
  final Color? overlayBackgroundColor;
  final Color? circularProgressColor;

  Loader(
      {this.isLoading,
      this.appIconSize = 100,
      this.borderRadius = 15,
      this.overlayOpacity = 0.5,
      this.circularProgressColor,
      this.overlayBackgroundColor});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // loaderController.showLoader();
      return Get.find<LoaderController>().isLoading.value
          ? OverLayAnimation(
              isLoading: Get.find<LoaderController>().isLoading.value,
              opacity: overlayOpacity,
              color: Colors.black,
              progressIndicator: Material(
                // color: buttonColor,
                borderRadius: BorderRadius.circular(borderRadius),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 10, right: 10),
                  child: SizedBox(
                    height: 60,
                    width: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //     width: 130,
                        //     height: 40,
                        //     child: Image.asset(Images.byufuel_logo)),
                        const SizedBox(
                          height: 5,
                          width: 130,
                          child: LinearProgressIndicator(
                              // backgroundColor: buttonColor,
                              // color: buttonTextColor,
                              ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ), //Change this loading overlay
              child: Container(),
            )
          : SizedBox.shrink(); // Empty widget when not loading
    });
  }
}

//OverLayAnimation class for ModalBarrier
class OverLayAnimation extends StatefulWidget {
  final bool isLoading;
  final double opacity;
  final Color? color;
  final Widget progressIndicator;
  final Widget child;

  const OverLayAnimation({
    required this.isLoading,
    required this.child,
    this.opacity = 0.5,
    this.progressIndicator = const CircularProgressIndicator(),
    this.color,
  });

  @override
  State<OverLayAnimation> createState() => _OverLayAnimationState();
}

class _OverLayAnimationState extends State<OverLayAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool? _overlayVisible;

  _OverLayAnimationState();

  @override
  void initState() {
    super.initState();
    _overlayVisible = false;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      status == AnimationStatus.forward
          ? setState(() => {_overlayVisible = true})
          : null;
      status == AnimationStatus.dismissed
          ? setState(() => {_overlayVisible = false})
          : null;
    });
    if (widget.isLoading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(OverLayAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.forward();
    }

    if (oldWidget.isLoading && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    widgets.add(widget.child);

    if (_overlayVisible == true) {
      final modal = FadeTransition(
        opacity: _animation,
        child: Stack(
          children: <Widget>[
            Opacity(
              child: ModalBarrier(
                dismissible: false,
                color: widget.color ?? Theme.of(context).colorScheme.background,
              ),
              opacity: widget.opacity,
            ),
            Center(child: widget.progressIndicator),
          ],
        ),
      );
      widgets.add(modal);
    }

    return Stack(children: widgets);
  }
}
