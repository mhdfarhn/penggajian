import 'employee.dart';

class Payroll {
  Map<String, dynamic> ptkpId = {
    'TK': 25,
    'K0': 50,
    'K1': 75,
  };

  Map<String, dynamic> ptkpVn = {
    'Belum Kawin': 15,
    'Sudah Kawin': 30,
  };

  double _calculateYearlyNetto({
    required double bruto,
    required String maritalStatus,
    required String nationality,
    required double insurance,
  }) {
    double netto;

    switch (nationality) {
      case 'Indonesia':
        netto = (bruto * 12) - ptkpId[maritalStatus];
        break;
      case 'Vietnam':
        netto = (bruto * 12) - (insurance * 12) - ptkpVn[maritalStatus];
        break;
      default:
        netto = 0.0;
    }

    return netto;
  }

  double _calculateMonthlyNetto(double yearlyNetto) {
    return yearlyNetto / 12;
  }

  double _calculateYearlyTaxId(double yearlyNetto) {
    double tax = 0.0;

    // penghasilan netto 0-50
    if (yearlyNetto >= 0 && yearlyNetto <= 50) {
      tax = 50 * 5 / 100;
      // penghasilan netto 50-250
    } else if (yearlyNetto > 50 && yearlyNetto <= 250) {
      tax = (50 * 5 / 100) + ((yearlyNetto - 50) * 10 / 100);
      // penghasilan netto >250
    } else if (yearlyNetto > 250) {
      tax = (50 * 5 / 100) + ((yearlyNetto - 50) * 15 / 100);
    }

    return tax;
  }

  double _calculateYearlyTaxVn(double yearlyNetto) {
    double tax = 0.0;

    // penghasilan netto 50
    if (yearlyNetto == 50) {
      tax = 50 * 2.5 / 100;
      // penghasilan netto >50
    } else if (yearlyNetto > 50) {
      tax = (50 * 2.5 / 100) + ((yearlyNetto - 50) * 7.5 / 100);
    }

    return tax;
  }

  double _calculateMonthlyTax(double yearlyTax) {
    return yearlyTax / 12;
  }

  Employee getEmployeeDataByNationality({
    required String name,
    required String nationality,
    required String maritalStatus,
    required double monthlyBruto,
    required double insurance,
  }) {
    double yearlyNetto = _calculateYearlyNetto(
      bruto: monthlyBruto,
      maritalStatus: maritalStatus,
      nationality: nationality,
      insurance: insurance,
    );

    double monthlyNetto = _calculateMonthlyNetto(yearlyNetto);

    double yearlyTax = nationality != 'Vietnam'
        ? _calculateYearlyTaxId(yearlyNetto)
        : _calculateYearlyTaxVn(yearlyNetto);

    double monthlyTax = _calculateMonthlyTax(yearlyTax);

    Employee employee = Employee(
      name: name,
      nationality: nationality,
      maritalStatus: maritalStatus,
      monthlyBruto: monthlyBruto,
      monthlyNetto: monthlyNetto,
      monthlyTax: monthlyTax,
      insurance: insurance,
    );

    return employee;
  }
}
