import 'dart:ffi';
import 'dart:math';

import 'package:devu_app/data/model/expense_category.dart';
import 'package:devu_app/data/model/expense_category_list.dart';
import 'package:devu_app/data/model/money.dart';
import 'package:devu_app/data/model/tag.dart';
import 'package:devu_app/expense_bloc.dart';
import 'package:devu_app/expense_event.dart';
import 'package:devu_app/expense_state.dart';
import 'package:devu_app/utils/utils.dart';
import 'package:devu_app/widget/date_swipe_widget.dart';
import 'package:devu_app/widget/income_card.dart';
import 'package:devu_app/widget/label_selector_widget.dart';
import 'package:devu_app/widget/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalExpensePage extends StatefulWidget {
  @override
  State<TotalExpensePage> createState() => _TotalExpensePageState();
}

class _TotalExpensePageState extends State<TotalExpensePage> {
  DateTime selectedDateTime = DateTime.now();
  List<Tag> selectedTagList = [];
  List<Money> expenseList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExpenseBloc>(context)
        .add(LoadByDayExpenseEvent(selectedDateTime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카테고리 상세'),
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              DateSwipeWidget(
                selectedDateTime,
                onChangeDate: (newDateTime) {
                  setState(() {
                    updateNewDate(newDateTime);
                  });
                },
              ),
              state is ExpenseSucessState
                  ? totalMoneyWidget(state.eventModel.categoryList)
                  : totalMoneyWidget([]),
              SizedBox(
                height: 20,
              ),
              LabelSelectorWidget(
                selectedList: selectedTagList,
                onSelecteds: (newTagList) {
                  setState(() {
                    selectedTagList = newTagList;
                  });
                },
              ),
              if (state is ExpenseSucessState &&
                  getExpenseList(state.eventModel.categoryList, selectedTagList)
                      .isNotEmpty)
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 12.0),
                    itemCount: expenseList.length,
                    itemBuilder: (context, index) {
                      return IncomeCard(
                        expenseList[index],
                        false,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 12,
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  void updateNewDate(DateTime newDateTime) {
    selectedDateTime = newDateTime;
    BlocProvider.of<ExpenseBloc>(context)
        .add(LoadByDayExpenseEvent(newDateTime));
  }

  List<Money> getExpenseList(
      List<ExpenseCategory> categoryList, List<Tag> filterTagList) {
    print(
        'taglist: ${filterTagList.length} categoryList: ${categoryList.length}');
    List<Money> moneyList = [];
    for (int i = 0; i < categoryList.length; i++) {
      print('test: ${categoryList[i].expenseList.length}');
      moneyList.addAll(categoryList[i].expenseList.where((expense) =>
          expense.tagList.any((expenseTag) => filterTagList
              .any((filterTag) => expenseTag.name == filterTag.name))));
    }
    expenseList = moneyList;
    print('expenseList: ${expenseList}');
    return moneyList;
  }

  Widget totalMoneyWidget(List<ExpenseCategory> categoryList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("총 수입"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatToKoreanNumber(getTotalMoney(categoryList, getIncome)),
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
              ),
              LabelWidget(
                '${dp(2.35, 2)}%',
                Colors.green,
                icon: Icons.trending_up,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Text("총 지출"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatToKoreanNumber(-getTotalMoney(categoryList, getExpense)),
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
              ),
              LabelWidget(
                '${dp(1.55, 2)}%',
                Colors.red,
                icon: Icons.trending_down,
              ),
            ],
          ),
        ],
      ),
    );
  }

  int getTotalMoney(List<ExpenseCategory> categoryList,
      int Function(ExpenseCategory) getMoney) {
    return categoryList.fold(
        0, (previousValue, element) => previousValue + getMoney(element));
  }

  int getIncome(ExpenseCategory category) {
    return category.expenseList.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.value < 0 ? 0 : element.value));
  }

  int getExpense(ExpenseCategory category) {
    return category.expenseList.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.value > 0 ? 0 : element.value));
  }

  double dp(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }
}
