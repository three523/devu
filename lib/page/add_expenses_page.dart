import 'package:devu_app/data/model/expense_category.dart';
import 'package:devu_app/data/model/money.dart';
import 'package:devu_app/data/model/tag.dart';
import 'package:devu_app/data/resource.dart';
import 'package:devu_app/expense_bloc.dart';
import 'package:devu_app/expense_event.dart';
import 'package:devu_app/expense_state.dart';
import 'package:devu_app/utils/extenstion.dart';
import 'package:devu_app/utils/utils.dart';
import 'package:devu_app/widget/label_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

enum RecodeType { income, expenses }

//TODO: 키보드 올라갈때 버튼 어떻게 할지 처리하기

class AddExpensesPage extends StatefulWidget {
  ExpenseCategory? expenseCategory;

  AddExpensesPage({this.expenseCategory});

  @override
  State<AddExpensesPage> createState() => _AddExpensesPageState();
}

class _AddExpensesPageState extends State<AddExpensesPage> {
  final isSelected = <bool>[true, false];
  List<Tag> tagList = [];
  TextEditingController priceController = TextEditingController(text: '0');
  TextEditingController memoController = TextEditingController();
  int price = 0;
  double bottomInset = 0.0;

  @override
  Widget build(BuildContext context) {
    bottomInset = MediaQuery.of(context).viewInsets.bottom;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('기록 하기'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToggleButtons(
              borderRadius: BorderRadius.circular(4.0),
              constraints: BoxConstraints(
                  minHeight: 20, minWidth: 60, maxHeight: 34, maxWidth: 60),
              children: [
                Center(child: Text('지출')),
                Center(child: Text('수입')),
              ],
              onPressed: (index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < isSelected.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      isSelected[buttonIndex] = true;
                    } else {
                      isSelected[buttonIndex] = false;
                    }
                  }
                });
              },
              color: primaryColor,
              borderColor: primaryColor,
              selectedBorderColor: primaryColor,
              fillColor: primaryColor,
              selectedColor: Colors.white,
              isSelected: isSelected,
            ),
            SizedBox(
              height: 24,
            ),
            isExpenses()
                ? Text(
                    '얼마를 썼나요?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )
                : Text(
                    '얼마를 더할까요?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
            Row(
              children: [Spacer(), Text("${formatToKoreanNumber(price)}원")],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Center(
                child: TextField(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: priceController,
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        price = 0;
                      } else {
                        price = value.toPrice() ?? price;
                      }
                      priceController.text = price.toPriceString();
                    });
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              '카테고리를 설정해주세요',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 91, 148, 168),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: () {
                        final state =
                            BlocProvider.of<ExpenseBloc>(context).state;
                        if (state is ExpenseSucessState) {
                          final categoryList = state.eventModel.categoryList;
                          showCategorySelectDialog(context, categoryList);
                        }
                      },
                      child: Text(widget.expenseCategory?.title ?? ''),
                    ),
                    isOutOfExpenses() == null
                        ? Container()
                        : Text(
                            '예산을 ${isOutOfExpenses()}원 초과했어요',
                            style: TextStyle(color: Colors.red),
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              '라벨를 설정해주세요',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8,
            ),
            LabelSelectorWidget(
              onSelecteds: (newTagList) {
                print('Add Expense: $newTagList');
                tagList = newTagList;
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              '메모를 작성해주세요',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: TextField(
                    controller: memoController,
                    maxLines: null,
                    decoration: InputDecoration.collapsed(
                      hintText: '기록에 표시될 상세 내용을 작성해주세요.',
                    ),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomSheet: SafeArea(
        child: Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              int price = priceController.text.toPrice() ?? 0;
              if (price <= 0) {
                return;
              }
              price = isExpenses() ? price : -price;
              final category = widget.expenseCategory;
              if (category != null && isOutOfExpenses() == null) {
                BlocProvider.of<ExpenseBloc>(context).add(CreateExpenseEvent(
                    category,
                    Money(
                        id: Uuid().v4().toString(),
                        title: memoController.text,
                        categoryId: category.id,
                        date: DateTime.now(),
                        value: price,
                        tagList: tagList)));
                Navigator.of(context).pop();
              } else {
                //TODO: 카테고리 선택 된 경우 에러처리
              }
            },
            child: Text('저장하기'),
          ),
        ),
      ),
    );
  }

  bool isExpenses() {
    return isSelected[0];
  }

  int? isOutOfExpenses() {
    if (priceController.text.toPrice() == null &&
        widget.expenseCategory == null) {
      return null;
    }
    final category = widget.expenseCategory!;
    int categoryUsedMoney = category.expenseList
        .fold(0, (previousValue, element) => previousValue + element.value);
    int leftMoney = category.belowMoeny - categoryUsedMoney;
    final price = priceController.text.toPrice()!;
    leftMoney = leftMoney - price;

    if (leftMoney < 0) {
      return -leftMoney;
    }

    return null;
  }

  void showCategorySelectDialog(
      BuildContext context, List<ExpenseCategory> categoryList) {
    int categoryIndex = 0;
    if (widget.expenseCategory != null) {
      categoryIndex = categoryList
          .indexWhere((element) => element.id == widget.expenseCategory!.id);
      if (categoryIndex == -1) {
        categoryIndex = 0;
      }
    }
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context,
              void Function(void Function()) dialogSetState) {
            return Dialog(
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.expenseCategory?.title ?? '',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            for (int i = 0; i < categoryList.length; i++)
                              GestureDetector(
                                onTap: () {
                                  dialogSetState(
                                    () {
                                      setState(() {
                                        categoryIndex = i;
                                        widget.expenseCategory =
                                            categoryList[i];
                                      });
                                    },
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  color: i == categoryIndex
                                      ? primaryColor
                                      : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Text(
                                      categoryList[i].title,
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
