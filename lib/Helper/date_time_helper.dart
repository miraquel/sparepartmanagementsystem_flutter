class DateTimeHelper {
  DateTimeHelper._();

  static DateTime minDateTime = DateTime(1753, 1, 1);

  static DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
}