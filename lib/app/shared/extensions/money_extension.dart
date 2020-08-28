extension MoneyParsing on double {
  String toMoney() {
    return "R\$ " + this.toStringAsFixed(2).replaceAll(".", ",");
  }
}
