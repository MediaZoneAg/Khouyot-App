
import 'package:flutter/material.dart';
import 'package:khouyot/features/cart/ui/widgets/thank_you_view_body.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Transform.translate(
            offset: const Offset(0, -16), child: const ThankYouViewBody()),
      ),
    );
  }
}
