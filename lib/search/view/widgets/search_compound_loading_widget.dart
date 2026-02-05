import 'package:flutter/material.dart';
import 'package:pub_chem/app/view/widgets/shimmer_widget.dart';

class SearchCompoundLoadingWidget extends StatelessWidget {
  const SearchCompoundLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ShimmerWidget(width: double.infinity, height: 120),
      ],
    );
  }
}
