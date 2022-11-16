class Employee {
  final String name;
  final String nationality;
  final String maritalStatus;
  final double monthlyBruto;
  final double monthlyNetto;
  final double monthlyTax;
  final double insurance;

  Employee({
    required this.name,
    required this.nationality,
    required this.maritalStatus,
    required this.monthlyBruto,
    required this.monthlyNetto,
    required this.monthlyTax,
    this.insurance = 0.0,
  });
}

class DummyEmployee {
  final String name;
  final String nationality;
  final String maritalStatus;
  final double monthlyBruto;
  final double insurance;

  DummyEmployee({
    required this.name,
    required this.nationality,
    required this.maritalStatus,
    required this.monthlyBruto,
    this.insurance = 0.0,
  });
}

List<DummyEmployee> dummyEmployees = [
  DummyEmployee(
    name: 'Karyawan Indonesia',
    nationality: 'Indonesia',
    maritalStatus: 'K1',
    monthlyBruto: 30,
  ),
  DummyEmployee(
    name: 'Karyawan Vietnam',
    nationality: 'Vietnam',
    maritalStatus: 'Sudah Kawin',
    monthlyBruto: 30,
    insurance: 1,
  ),
];
