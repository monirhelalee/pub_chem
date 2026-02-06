import 'package:flutter/material.dart';
import 'package:pub_chem/app/utils/time_ago_utils.dart';
import 'package:pub_chem/l10n/l10n.dart';
import 'package:pub_chem/search/domain/entities/recent_search.dart';

class RecentSearchListTileWidget extends StatelessWidget {
  const RecentSearchListTileWidget({
    required this.onTap,
    required this.search,
    super.key,
  });
  final VoidCallback onTap;
  final RecentSearch search;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: search.isSuccess
                      ? Colors.green.withOpacity(0.1)
                      : Theme.of(
                          context,
                        ).colorScheme.error.withOpacity(
                          0.1,
                        ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  search.isSuccess ? Icons.check_circle : Icons.cancel,
                  color: search.isSuccess
                      ? Colors.green
                      : Theme.of(context).colorScheme.error,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      search.searchText,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      search.isSuccess
                          ? TimeAgoUtils.getTimeAgo(
                              search.timestamp,
                              context,
                            )
                          : l10n.notFound,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: search.isSuccess
                            ? Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant
                            : Theme.of(
                                context,
                              ).colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.search,
                size: 16,
                color: Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
