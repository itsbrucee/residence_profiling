import 'package:flutter/material.dart';

class StepPage extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final bool isLastStep;

  const StepPage({
    super.key,
    required this.title,
    required this.content,
    this.onNext,
    this.onBack,
    this.isLastStep = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child: content),
            Row(
              children: [
                if (onBack != null)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onBack,
                      child: const Text('Back'),
                    ),
                  ),
                if (onBack != null && onNext != null) const SizedBox(width: 16),
                if (onNext != null)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onNext,
                      child: Text(isLastStep ? 'Finish' : 'Next'),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
