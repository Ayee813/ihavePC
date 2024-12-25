import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetsService {
  // Your Google Sheets credentials
  static const _credentials = r'''
  {
    // Your Google Service Account credentials JSON here
  }
  ''';
  
  // Your spreadsheet ID
  static const _spreadsheetId = 'your_spreadsheet_id_here';
  
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;
  
  // Initialize the Google Sheets connection
  static Future<void> init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Orders');
    
    // Create header row if it doesn't exist
    await _worksheet?.values.insertRow(1, [
      'Name',
      'Phone',
      'Province',
      'District',
      'Village',
      'Delivery Service',
      'Payment Image URL',
      'Timestamp'
    ]);
  }
  
  // Upload image to Firebase Storage and return URL
  static Future<String> uploadImage(File imageFile) async {
    final storageRef = FirebaseStorage.instance.ref();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final imageRef = storageRef.child('payment_evidence/$timestamp.jpg');
    
    await imageRef.putFile(imageFile);
    return await imageRef.getDownloadURL();
  }
  
  // Insert order data into Google Sheets
  static Future<bool> insertOrder(Map<String, dynamic> orderData, File imageFile) async {
    try {
      // Upload image first
      final imageUrl = await uploadImage(imageFile);
      
      // Prepare row data
      final rowData = [
        orderData['name'],
        orderData['phone'],
        orderData['province'],
        orderData['district'],
        orderData['village'],
        orderData['deliveryService'],
        imageUrl,
        DateTime.now().toIso8601String()
      ];
      
      // Insert data into the next available row
      await _worksheet?.values.appendRow(rowData);
      return true;
    } catch (e) {
      print('Error inserting order: $e');
      return false;
    }
  }
}