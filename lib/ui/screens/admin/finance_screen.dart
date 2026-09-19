import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/finance_provider.dart';
import '../../widgets/app_shell.dart';
class FinanceScreen extends StatefulWidget { const FinanceScreen({super.key}); @override State<FinanceScreen> createState()=>_FinanceScreenState(); }
class _FinanceScreenState extends State<FinanceScreen>{@override void initState(){super.initState();WidgetsBinding.instance.addPostFrameCallback((_)=>context.read<FinanceProvider>().load());}
 @override Widget build(BuildContext context){final p=context.watch<FinanceProvider>();final r=p.report;return AppShell(child:ListView(padding:const EdgeInsets.all(20),children:[Text('Accounting & Finance',style:Theme.of(context).textTheme.headlineSmall),const SizedBox(height:16),Text('Revenue: KES ${(r['revenue']??r['totalRevenue']??0)}'),Text('Expenses: KES ${(r['expenses']??r['totalExpenses']??0)}'),Text('Net profit: KES ${r['netProfit']??0}'),Text('Cash position: KES ${r['cashPosition']??0}'),const SizedBox(height:24),FilledButton.icon(onPressed:p.loading?null:p.reconcile,icon:const Icon(Icons.sync),label:const Text('Reconcile operational accounting')),if(p.message!=null)Padding(padding:const EdgeInsets.only(top:12),child:Text(p.message!))]));}
}
