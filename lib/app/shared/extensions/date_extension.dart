extension GetDate on DateTime {
  String getDate() {
    return this.toString().split(" ")[0];
  }
}

extension ConvertDate on String {
  String convertToMonthAndYear(Map monthsMapping) {
    List<String> splittedDateString = this.split("-");
    String monthName = monthsMapping[int.tryParse(splittedDateString[1])];
    return "$monthName/${splittedDateString[0]}";
  }
}
