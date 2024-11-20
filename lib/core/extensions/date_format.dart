import 'package:intl/intl.dart';

extension DateFormatting on DateTime {
  String toFormattedString() {
    final DateFormat formatter = DateFormat("d MMM yyyy 'at' HH:mm");
    return formatter.format(this);
  }
}
