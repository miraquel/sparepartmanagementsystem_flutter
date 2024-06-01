import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingOverlay(
      {super.key, required this.child, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Stack(
                  children: [
                    AbsorbPointer(
                      absorbing: true,
                      child: ModalBarrier(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitSpinningLines(
                              color: Colors.blueAccent,
                              size: 100.0,
                              lineWidth: 3.0,
                              itemCount: 5,
                            ),
                            SizedBox(height: 10),
                            // Plain loading text with small font size and no bold weight with underscore
                            Text(
                              'Loading...',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), // Loading indicator on top of the barrier
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
