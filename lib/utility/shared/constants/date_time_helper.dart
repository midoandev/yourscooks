

extension DateTimeHelper on DateTime {

  String get formatDateTime {
    // Create a map for month names in Indonesian
    const monthsInIndonesian = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    // Get the month name in Indonesian
    String month = monthsInIndonesian[this.month - 1];

    // Format the day and year
    String day = this.day.toString();
    String year = this.year.toString();

    // Combine the parts into the desired format
    return '$month, $day $year';
  }
}
