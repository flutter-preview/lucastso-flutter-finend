import 'package:finend/auth/widgets/blue_button.dart';
import 'package:finend/auth/widgets/text_fields.dart';
import 'package:finend/configs/expense_income_provider.dart';
import 'package:finend/incomes/models/income.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class NewIncome extends StatefulWidget {
  const NewIncome({super.key});

  @override
  State<NewIncome> createState() => _NewIncomeState();
}

class _NewIncomeState extends State<NewIncome> {
  String dropdownValue = list.first;
  TextEditingController inputNameController = TextEditingController();
  TextEditingController inputDataController = TextEditingController();
  TextEditingController inputValorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final incomeManager = Provider.of<ExpenseIncomeManager>(context);
    final incomes = incomeManager.incomes;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/home',
                          );
                        },
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Color(0xFF242424),
                          size: 24,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        "Registrar nova receita",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF242424),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        "Nome:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF242424),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 52,
                        child: CustomTextField(
                          inputHintText: "Insira o nome da receita",
                          inputController: inputNameController,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Data:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF242424),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 52,
                        child: CustomTextField(
                          inputHintText: "Insira a data da receita",
                          inputController: inputDataController,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Valor:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF242424),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 52,
                        child: CustomTextField(
                          inputHintText: "Insira o valor da receita",
                          inputController: inputValorController,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Categoria:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF242424),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 52,
                        child: DropdownButton(
                          isExpanded: true,
                          value: dropdownValue,
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 32),
                      AuthBlueButton(
                        buttonLabel: "Inserir nova receita",
                        onPressed: () {
                          final String name = inputNameController.text;
                          final String date = inputDataController.text;
                          final double value =
                              double.parse(inputValorController.text);
                          final String category = dropdownValue;

                          final newIncome = Income(
                            name: name,
                            value: value,
                            date: date,
                            type: 'Receita',
                            category: category,
                          );
                          incomeManager.addIncome(newIncome);
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
