import 'package:devu_app/data/model/expense_category.dart';
import 'package:devu_app/data/model/expense_category_list.dart';
import 'package:devu_app/expense_bloc.dart';
import 'package:devu_app/expense_detail_bloc.dart';
import 'package:devu_app/expense_event.dart';
import 'package:devu_app/expense_state.dart';
import 'package:devu_app/widget/category_card.dart';
import 'package:devu_app/widget/income_card.dart';
import 'package:devu_app/widget/date_swipe_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCategoryPage extends StatefulWidget {
  ExpenseCategory category;
  DateTime selectedDateTime;

  DetailCategoryPage(this.category, this.selectedDateTime);

  @override
  State<DetailCategoryPage> createState() => _DetailCategoryPageState();
}

class _DetailCategoryPageState extends State<DetailCategoryPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExpenseDetailBloc>(context).add(
        LoadByDayExpenseCategoryEvent(
            widget.selectedDateTime, widget.category.title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('카테고리 상세'),
      ),
      body: BlocBuilder<ExpenseDetailBloc, ExpenseState>(
          builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            DateSwipeWidget(
              widget.selectedDateTime,
              onChangeDate: (newDateTime) {
                updateDate(newDateTime, context);
              },
            ),
            Container(
              width: double.infinity,
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: CategoryCard(
                    30.0,
                    category: getCategory(state),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 12.0),
                  itemCount: getCategory(state).expenseList.length,
                  itemBuilder: (context, index) {
                    return IncomeCard(
                      getCategory(state).expenseList[index],
                      true,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 12,
                    );
                  },
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  ExpenseCategory getCategory(ExpenseState state) {
    return state is ExpenseCategorySucessState
        ? state.category
        : widget.category;
  }

  void updateDate(DateTime newDateTime, BuildContext context) {
    widget.selectedDateTime = newDateTime;
    BlocProvider.of<ExpenseDetailBloc>(context)
        .add(LoadByDayExpenseCategoryEvent(newDateTime, widget.category.title));
  }
}
