import 'package:flutter/material.dart';
import 'package:flutter_project_2/providers/loading_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingContainer extends ConsumerStatefulWidget {
  const LoadingContainer({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  ConsumerState<LoadingContainer> createState() => _LoadingContainer();
}

class _LoadingContainer extends ConsumerState<LoadingContainer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.green,
      end: Colors.yellow,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loadingStateProvider);
    return Stack(
      children: [
        widget.child,
        if (state.isLoading)
          Container(
            color: Colors.black.withOpacity(0.75),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: AnimatedBuilder(
                        animation: _colorAnimation,
                        builder: (context, child) {
                          return CircularProgressIndicator(
                            color: Colors.white,
                            valueColor: _colorAnimation,
                          );
                        }),
                  ),
                  SizedBox(width: state.text == "" ? 0 : 20),
                  Text(state.text,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
