import 'package:flutter/material.dart';
import 'package:pub_chem/app/utils/failure_message_utils.dart';
import 'package:pub_chem/l10n/l10n.dart';

class SearchErrorWidget extends StatelessWidget {
  const SearchErrorWidget({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      crossAxisAlignment: .start,
      children: [
        Card(
          elevation: 0.5,
          child: Padding(
            padding: const .all(16),
            child: Column(
              mainAxisAlignment: .center,
              mainAxisSize: .min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.compoundNotFound,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: .bold,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 72,
                  child: Text(
                    FailureMessageUtils.mapFailureToMessage(message, context),
                    textAlign: .center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
