import 'package:flutter/material.dart';
import 'package:penggajian/employee.dart';
import 'package:penggajian/payroll.dart';

void main() => runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: App(),
      ),
    );

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Payroll _payroll = Payroll();
  List<Employee> employees = [];

  Map maritalStatus = {
    'TK': 'Belum Kawin',
    'K0': 'Kawin dan Belum Punya Anak',
    'K1': 'Kawin dan Punya Anak',
  };

  @override
  void initState() {
    employees = dummyEmployees
        .map(
          (employee) => _payroll.getEmployeeDataByNationality(
            name: employee.name,
            nationality: employee.nationality,
            maritalStatus: employee.maritalStatus,
            monthlyBruto: employee.monthlyBruto,
            insurance: employee.insurance,
          ),
        )
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Penggajian'),
      ),
      body: ListView(
        children: List.generate(
          employees.length,
          (index) => Padding(
            padding: EdgeInsets.fromLTRB(
              8.0,
              index == 0 ? 8.0 : 4.0,
              8.0,
              index == employees.length - 1 ? 8.0 : 4.0,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Nama'),
                        const Text('Status Pernikahan'),
                        const Text('Bruto per Bulan'),
                        const Text('Netto per Bulan'),
                        const Text('Pajak per Bulan'),
                        employees[index].nationality != 'Indonesia'
                            ? const Text('Tunjangan Asuransi')
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(width: 8.0),
                    employees[index].nationality == 'Indonesia'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(employees[index].name),
                              Text(
                                  '${maritalStatus[employees[index].maritalStatus]}'),
                              Text(
                                  'IDR ${employees[index].monthlyBruto.toStringAsFixed(2)} juta'),
                              Text(
                                  'IDR ${employees[index].monthlyNetto.toStringAsFixed(2)} juta'),
                              Text(
                                  'IDR ${employees[index].monthlyTax.toStringAsFixed(2)} juta'),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(employees[index].name),
                              Text(employees[index].maritalStatus),
                              Text(
                                  'VND ${employees[index].monthlyBruto.toStringAsFixed(2)} juta'),
                              Text(
                                  'VND ${employees[index].monthlyNetto.toStringAsFixed(2)} juta'),
                              Text(
                                  'VND ${employees[index].monthlyTax.toStringAsFixed(2)} juta'),
                              Text(
                                  'VND ${employees[index].insurance.toStringAsFixed(2)} juta'),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
