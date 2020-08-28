class ExpenseModel {
  int id;
  String description;
  String date;
  double value;
  String serviceProvider;

  ExpenseModel({
    this.id,
    this.description,
    this.date,
    this.value,
    this.serviceProvider,
  });

  factory ExpenseModel.fromMap(Map value) => ExpenseModel(
        id: value["id"],
        description: value["description"],
        date: value["date"],
        value: value["value"],
        serviceProvider: value["serviceProvider"],
      );

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "description": this.description,
        "date": this.date,
        "value": this.value,
        "serviceProvider": this.serviceProvider,
      };

  @override
  String toString() {
    return this.toMap().toString();
  }
}
