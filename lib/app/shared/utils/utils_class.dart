class Utils {
  static Map<String, String> serviceProvidersImagePath = {
    "99": "images/logo_99.png",
    "Uber": "images/logo_uber.png",
    "Taxi": "images/logo_taxi.png",
  };

  static Map<int, String> monthsOfTheYear = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };

  static String getWeekNumberFromDate(DateTime date) {
    int dayOfYear = date.difference(DateTime(date.year, 01, 01)).inDays + 1;
    int weekNumber = ((dayOfYear - date.weekday + 10) / 7).floor();
    return "W${weekNumber.toStringAsFixed(0)}";
  }
}
