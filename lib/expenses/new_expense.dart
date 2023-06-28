import 'package:finend/auth/widgets/blue_button.dart';
import 'package:finend/auth/widgets/text_fields.dart';
import 'package:finend/configs/expense_income_provider.dart';
import 'package:finend/expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:uuid/uuid.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  TextEditingController inputNameController = TextEditingController();
  TextEditingController inputDataController = TextEditingController();
  TextEditingController inputValorController = TextEditingController();
  TextEditingController inputCategoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final expenseManager = Provider.of<ExpenseIncomeManager>(context);
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
                        "Registrar nova despesa",
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
                          inputController: inputNameController,
                          inputHintText: "Insira o nome da despesa",
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
                      InkWell(
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (date) {
                              setState(() {
                                inputDataController.text =
                                    formatDate(date, [dd, '/', mm, '/', yyyy]);
                              });
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.pt,
                          );
                        },
                        child: Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today),
                              const SizedBox(width: 8),
                              Text(
                                inputDataController.text,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
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
                        child: TextField(
                          controller: inputValorController,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Insira o valor da despesa",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF4F4F4),
                          ),
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
                      SizedBox(
                        height: 52,
                        child: CustomTextField(
                          inputController: inputCategoryController,
                          inputHintText: "Insira a categoria da despesa",
                        ),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 32),
                      AuthBlueButton(
                        buttonLabel: "Inserir nova despesa",
                        onPressed: () {
                          final String id = const Uuid().v4();
                          final String name = inputNameController.text;
                          final String date = inputDataController.text;
                          final double value =
                              double.parse(inputValorController.text);
                          final String category = inputCategoryController.text;

                          final newExpense = Expense(
                            id: id,
                            name: name,
                            value: -value,
                            date: date,
                            type: 'Despesa',
                            category: category,
                          );
                          expenseManager.addExpense(newExpense);

                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
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
