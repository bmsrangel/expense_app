extension GetDate on DateTime {
  String getDate() {
    return this.toString().split(" ")[0];
  }
}
