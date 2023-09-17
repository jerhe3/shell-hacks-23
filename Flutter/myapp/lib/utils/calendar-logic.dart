import 'package:intl/intl.dart';
import 'package:myapp/utils/calendar/structures.dart';

class CalendarLogic {
  CalendarLogic._();

  static bool isOverLapping(DateTime firstStart, DateTime firstEnd,
      DateTime secondStart, DateTime secondEnd) {
    return getLatestDateTime(firstStart, secondStart)
        .isBefore(getEarliestDateTime(firstEnd, secondEnd));
  }

  static DateTime getLatestDateTime(DateTime first, DateTime second) {
    return first.isAfterOrEq(second) ? first : second;
  }

  static DateTime getEarliestDateTime(DateTime first, DateTime second) {
    return first.isBeforeOrEq(second) ? first : second;
  }

  static String formatDateTime(DateTime dt) {
    return DateFormat.Hm().format(dt);
  }

  static List<CalendarEvent> addCalendarEvent(
      List<CalendarEvent>? calendar, CalendarEvent event) {
    if (calendar == null) {
      calendar = <CalendarEvent>[];
      calendar.add(event);
      return calendar;
    }

    var flag = 0;
    calendar.forEach((calendar_event) {
      if (isOverLapping(calendar_event.range.start, calendar_event.range.end,
          event.range.start, event.range.end)) {
        flag = 1;
      }
    });

    if (flag == 1) {
      return calendar;
    }

    calendar.add(event);

    return calendar;
  }
}

extension DateTimeExt on DateTime {
  bool isBeforeOrEq(DateTime second) {
    return isBefore(second) || isAtSameMomentAs(second);
  }

  bool isAfterOrEq(DateTime second) {
    return isAfter(second) || isAtSameMomentAs(second);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime get startOfDay => DateTime(year, month, day, 0, 0);

  DateTime get endOfDay => DateTime(year, month, day + 1, 0, 0);

  DateTime startOfDayService(DateTime service) =>
      DateTime(year, month, day, service.hour, service.minute);

  DateTime endOfDayService(DateTime service) =>
      DateTime(year, month, day, service.hour, service.minute);
}
