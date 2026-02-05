import 'package:flutter/material.dart';
import 'package:pub_chem/app/view/widgets/shimmer_widget.dart';

class CompoundDetailsLoadingWidget extends StatelessWidget {
  const CompoundDetailsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: .all(16),
      child: SingleChildScrollView(
        child: Column(
          spacing: 12,
          children: [
            ShimmerWidget(width: double.infinity, height: 100),
            ShimmerWidget(width: double.infinity, height: 80),
            ShimmerWidget(width: double.infinity, height: 80),
            ShimmerWidget(width: double.infinity, height: 80),
            ShimmerWidget(width: double.infinity, height: 80),
            ShimmerWidget(width: double.infinity, height: 250),
          ],
        ),
      ),
    );
  }
}
