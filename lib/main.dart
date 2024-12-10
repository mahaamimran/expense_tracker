import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/expenses_provider.dart';
import 'screens/main_screen.dart';
import 'screens/add_expense_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpensesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Define our custom colors
    const primaryColor = Color(0xFF607D8B); // as requested
    const backgroundColor = Color(0xFFECEFF1); // as requested

    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        primaryColor: primaryColor,
        // Using ColorScheme to provide a consistent color palette
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: Colors.teal,
          background: backgroundColor,
          surface: Colors.white,
          onPrimary: Colors.white,
          onSurface: Colors.black87,
        ),
        scaffoldBackgroundColor: backgroundColor,
        cardColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white, // Make text/icons white on dark appBar
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          focusColor: primaryColor,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2.0, color: primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const MainScreen(),
      routes: {
        AddExpenseScreen.routeName: (_) => const AddExpenseScreen(),
      },
    );
  }
}
