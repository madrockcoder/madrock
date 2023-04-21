// import '../repos/global_repo.dart';

// import '../models/currency.dart';

// class SessionCache {
//   static List<Currency> _currency = [];

//   static List<Currency> get getCurrency => _currency;

//   Future<void> init() async {
//     await fetchCurrency();
//   }

//   fetchCurrency() async {
//     _currency = await GlobalRepo().fetchCurrencies();
//     //print(currency);
//   }

//   static List<Currency> findCurrencies(String searchTerm,
//       [List<Currency>? currencies]) {
//     if (searchTerm.isEmpty) {
//       return currencies ?? getCurrency;
//     } else {
//       return (currencies ?? getCurrency).where((e) {
//         final i = e.name.toLowerCase();
//         final j = e.code.toLowerCase();
//         final query = searchTerm.toLowerCase();

//         return i.contains(query) || j.contains(query);
//       }).toList();
//     }
//   }
// }
