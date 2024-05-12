// import 'package:devu_app/data/model/money.dart';
// import 'package:devu_app/data/repository/expense_repository.dart';
// import 'package:devu_app/widget/event_form.dart';
// import 'package:flutter/material.dart';

// class CreateEventPage extends StatelessWidget {
//   final ExpenseRepository repository;
//   final Money? event;
//   final DateTime date;
//   final void Function()? onEventAdd;
//   final void Function()? onEventUpdate;
//   final void Function()? onEventDelete;

//   const CreateEventPage(
//       {super.key,
//       required this.repository,
//       this.event,
//       required this.date,
//       this.onEventAdd,
//       this.onEventUpdate,
//       this.onEventDelete});

//   @override
//   Widget build(BuildContext context) {
//     // final repository = context.read<ExpenseRepository>();
//     return Scaffold(
//       appBar: AppBar(
//           title: event == null ? const Text('새로운 예산') : const Text("현재 예산")),
//       body: SingleChildScrollView(
//         physics: const ClampingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: EventForm(
//               categorys: repository.getAllCategory(FilterType.category),
//               labels: repository.getAllCategory(FilterType.label),
//               event: event,
//               date: date,
//               onEventAdd: (newEvent) async {
//                 if (event != null) {
//                   repository.updateExpense(date, event!.id, newEvent);
//                   if (onEventUpdate != null) {
//                     onEventUpdate!();
//                   }
//                 } else {
//                   repository.createExpense(date, newEvent);
//                   if (onEventAdd != null) {
//                     onEventAdd!();
//                   }
//                 }
//                 Navigator.of(context).pop(true);
//               },
//               onEventDelete: () async {
//                 if (event == null) {
//                   return;
//                 }
//                 repository.deleteExpense(date, event!.id);
//                 if (onEventDelete != null) {
//                   onEventDelete!();
//                 }
//                 Navigator.of(context).pop(true);
//               }),
//         ),
//       ),
//     );
//   }
// }
