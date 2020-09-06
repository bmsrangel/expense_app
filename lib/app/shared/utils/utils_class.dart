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
    int today = date.weekday;
    int dayNr = (today + 6) % 7;
    DateTime thisMonday = date.subtract(Duration(days: (dayNr)));
    DateTime thisThursday = thisMonday.add(Duration(days: 3));
    DateTime firstThursday = DateTime(date.year, DateTime.january, 1);

    if (firstThursday.weekday != (DateTime.thursday)) {
      firstThursday = DateTime(date.year, DateTime.january,
          1 + ((4 - firstThursday.weekday) + 7) % 7);
    }

    int x = thisThursday.millisecondsSinceEpoch -
        firstThursday.millisecondsSinceEpoch;
    double weekNumber = x.ceil() / 604800000 + 1;
    return "W${weekNumber.toStringAsFixed(0)}";
  }
}
