import 'package:flutter/cupertino.dart';
import 'package:pub_chem/l10n/l10n.dart';

class TimeAgoUtils {
  TimeAgoUtils._();

  static String getTimeAgo(DateTime dateTime, BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    final l10n = context.l10n;
    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 ${l10n.yearAgo}' : '$years ${l10n.yearsAgo}';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 ${l10n.monthAgo}' : '$months ${l10n.monthsAgo}';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1
          ? '1 ${l10n.dayAgo}'
          : '${difference.inDays} ${l10n.daysAgo}';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1
          ? '1 ${l10n.hourAgo}'
          : '${difference.inHours} ${l10n.hoursAgo}';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? '1 ${l10n.minuteAgo}'
          : '${difference.inMinutes} ${l10n.minutesAgo}';
    } else {
      return l10n.justNow;
    }
  }
}
