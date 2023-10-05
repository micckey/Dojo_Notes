import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatTimestamp(Timestamp? timestamp) {
  // Convert Firestore Timestamp to DateTime
  if (timestamp != null) {
    DateTime dateTime = timestamp.toDate();

    if (DateTime.now().difference(dateTime) < const Duration(days: 1)) {
      if (DateTime.now().difference(dateTime) < const Duration(seconds: 60)) {
        return 'Just Now';
      } else if (DateTime.now().difference(dateTime) <
          const Duration(hours: 1)) {
        if (DateTime.now().difference(dateTime) <
            const Duration(minutes: 2)) {
          return '1 minute ago';
        }
        return ' ${dateTime.difference(DateTime.now()).inMinutes.toString().substring(1)} minutes ago';
      } else if (DateTime.now().difference(dateTime) <
          const Duration(hours: 2)) {
        return '1 hour ago';
      }
      return ' ${dateTime.difference(DateTime.now()).inHours.toString().substring(1)} hours ago';
    } else {
      // Format DateTime using intl package's DateFormat
      return DateFormat('MMM d, y - HH:mm a').format(dateTime);
    }
  }
  return '...';
}