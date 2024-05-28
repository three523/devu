import 'package:devu_app/data/model/expense_category.dart';
import 'package:devu_app/data/model/expense_category_list.dart';
import 'package:devu_app/data/repository/expense_repository.dart';
import 'package:devu_app/data/resource.dart';
import 'package:devu_app/expense_bloc.dart';
import 'package:devu_app/expense_detail_bloc.dart';
import 'package:devu_app/expense_event.dart';
import 'package:devu_app/expense_state.dart';
import 'package:devu_app/page/add_category_page.dart';
import 'package:devu_app/page/add_expenses_page.dart';
import 'package:devu_app/page/detail_category_page.dart';
import 'package:devu_app/page/total_expense_page.dart';
import 'package:devu_app/utils/extenstion.dart';
import 'package:devu_app/utils/utils.dart';
import 'package:devu_app/widget/category_card.dart';
import 'package:devu_app/widget/home_appbar.dart';
import 'package:devu_app/widget/income_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  // final ExpenseRepository repository;

  MainPage();

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime currentDateTime = DateTime.now();
  int currentPageIndex = 0;
  final double defaultPadding = 16.0;
  ExpenseCategory? category;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ExpenseBloc>(context)
        .add(LoadByDayExpenseCategoryListEvent(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
      return Scaffold(
        floatingActionButton: state is ExpenseSucessState &&
                state.eventModel.categoryList.isNotEmpty
            ? FloatingActionButton(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: CircleBorder(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        final category =
                            state.eventModel.categoryList[currentPageIndex];
                        return AddExpensesPage(expenseCategory: category);
                      },
                    ),
                  );
                },
                child: Icon(Icons.add),
              )
            : null,
        body: SafeArea(
          child: Column(
            children: [
              state is ExpenseSucessState
                  ? Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 16.0, right: 16.0),
                            child: HomeAppBar(
                              '/addCategory',
                              () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddCategoryPage(currentDateTime)),
                                );
                              },
                              onChangeDate: (date) {
                                currentDateTime = date;
                                currentPageIndex = 0;
                                BlocProvider.of<ExpenseBloc>(context).add(
                                    LoadByDayExpenseCategoryListEvent(date));
                              },
                              description: totalExpense(state.eventModel),
                              dateTime: currentDateTime,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 175,
                            child: state.eventModel.categoryList.isEmpty
                                ? Center(
                                    child: expenseEmptyWidget(
                                        '카테고리가 존재하지 않습니다\n카테고리를 추가해주세요'))
                                : PageView.builder(
                                    onPageChanged: onPageViewChange,
                                    scrollDirection: Axis.horizontal,
                                    controller: PageController(
                                      viewportFraction: 0.8,
                                    ),
                                    itemCount:
                                        state.eventModel.categoryList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return BlocProvider(
                                                  create: (_) =>
                                                      ExpenseDetailBloc(
                                                          ExpenseRepository()),
                                                  child: DetailCategoryPage(
                                                    state.eventModel
                                                        .categoryList[index],
                                                    unixTimestampToDateTime(
                                                        state
                                                            .eventModel
                                                            .categoryList[index]
                                                            .timeStamp),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CategoryCard(
                                            25.0,
                                            category: state
                                                .eventModel.categoryList[index],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          SizedBox(
                            height: 8,
                            width: double.infinity,
                            child: Center(
                              child: ListView.separated(
                                itemCount: state.eventModel.categoryList.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      border: currentPageIndex == index
                                          ? null
                                          : Border.all(
                                              width: 0.5,
                                              color: Colors.black,
                                            ),
                                      borderRadius: BorderRadius.circular(8),
                                      color: currentPageIndex == index
                                          ? primaryColor
                                          : Colors.white,
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 4,
                                  );
                                },
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "최근 내역",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TotalExpensePage(),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('모두보기'),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          state.eventModel.categoryList.isEmpty
                              ? Expanded(
                                  child: Center(
                                      child: expenseEmptyWidget(
                                          '지출 내역이 없습니다\n지출한 내역이 있다면 추가해주세요')))
                              : state.eventModel.categoryList[currentPageIndex]
                                      .expenseList.isEmpty
                                  ? Expanded(
                                      child: Center(
                                          child: expenseEmptyWidget(
                                              '지출 내역이 없습니다\n지출한 내역이 있다면 추가해주세요')))
                                  : Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: ListView.separated(
                                          padding:
                                              EdgeInsetsDirectional.symmetric(
                                                  vertical: 12.0),
                                          itemCount: state
                                              .eventModel
                                              .categoryList[currentPageIndex]
                                              .expenseList
                                              .length,
                                          itemBuilder: (context, index) {
                                            return IncomeCard(
                                              state
                                                  .eventModel
                                                  .categoryList[
                                                      currentPageIndex]
                                                  .expenseList[index],
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
                                    ),
                        ],
                      ),
                    )
                  : Center(
                      child: Text('데이터를 가져오는데 문제가 생겼습니다.'),
                    ),
            ],
          ),
        ),
      );
    });
  }

  String? totalExpense(ExpenseCategoryList categoryList) {
    final totalExpense = categoryList.categoryList.fold(
        0, (previousValue, element) => previousValue + element.belowMoeny);
    return totalExpense.toPriceString() + '원';
  }

  void onPageViewChange(int page) {
    setState(() {
      currentPageIndex = page;
      final state = BlocProvider.of<ExpenseBloc>(context).state;
      if (state is ExpenseSucessState) {
        category = state.eventModel.categoryList[page];
      }
    });
  }

  ExpenseCategory? getCategory() {
    if (category == null) {
      final state = BlocProvider.of<ExpenseBloc>(context).state;
      if (state is ExpenseSucessState) {
        if (state.eventModel.categoryList.isNotEmpty) {
          category = state.eventModel.categoryList[currentPageIndex];
          return category;
        } else {
          return null;
        }
      }
    } else {
      return category;
    }
    return null;
  }

  Widget expenseEmptyWidget(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
      ],
    );
  }
}
