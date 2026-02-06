import 'package:flutter/material.dart';
import 'package:pub_chem/l10n/l10n.dart';

class FailureMessageUtils {
  FailureMessageUtils._();
  static String mapFailureToMessage(String failure, BuildContext context) {
    final failureMessage = failure.toLowerCase();
    final l10n = context.l10n;
    if (failureMessage.contains('not found') ||
        failureMessage.contains('404') ||
        failureMessage.contains('no cid found')) {
      return l10n.checkSpellingOrTryAnother;
    } else if (failureMessage.contains('network') ||
        failureMessage.contains('connection') ||
        failureMessage.contains('timeout')) {
      return l10n.netErrorTryAgain;
    } else if (failureMessage.contains('server') ||
        failureMessage.contains('500') ||
        failureMessage.contains('503')) {
      return l10n.serverErrorUnable;
    } else if (failureMessage.contains('bad response') ||
        failureMessage.contains('unexpected')) {
      return l10n.serverErrorUnable;
    } else {
      return l10n.serverErrorUnable;
    }
  }
}
