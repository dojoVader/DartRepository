import 'dart:io';

import 'package:csv/csv.dart';


// Load the CSV into List

final csvFileHandler = File('./import.csv');

// Create a List of Shopify Columns for Products
Map<String,String> ShopifyProductColumn = {
  'GTIN': 'Variant Barcode',
  'Nom produit retranscris dans le code barre': 'Title',
  'Marque': 'Brand',
  'CoBranding': 'Type',
  'Code fabriquant': 'Tags',
  'Catégorie': 'Product Category',
  'Collection nom': 'Collection',
  'Description réference' : 'Description',
  'PRIX TTC': 'Variant Price',
};

swapHeaderForShopify( header){
     return header.map((column) => ShopifyProductColumn.containsKey(column.toString().trim()) ? ShopifyProductColumn[column.toString().trim()] : column.toString().trim()).toList();
}



Future<void> main(List<String> arg) async {
  print("**** Welcome to the Shopify CSV Mapper ****");

  var csvStringData = await csvFileHandler.readAsString();
  // Convert the CSV to List
  List<List<dynamic>> csvTable = CsvToListConverter(eol: '\n').convert(csvStringData);
  csvTable[0].add('Status');
  csvTable[0].add('Handle');
  csvTable[0].add('Option1 Name');
  csvTable[0].add('Option1 Value');
  var newHeader = swapHeaderForShopify(csvTable[0]);
  csvTable[0] = newHeader;
  csvTable.removeAt(1); // The 2nd row is not needed to be exported

  // loop through the csv table
  for (var idx =0; idx <= csvTable.length -1; idx++) {
    // Generate the description for Shopify
    if(idx == 0) continue; // Skip the header
    var currentRow = csvTable[idx];
    currentRow[14] = currentRow[14] + "\n" + currentRow[15];
    print(currentRow[9]);
    // Strip off the symbol in the price
    currentRow[9] = currentRow[9].toString().trim() != 'price on request'  ? currentRow[9].toString().replaceAll('€', '') : 0;
    currentRow.add('active'); // 16
    currentRow.add(currentRow[1].toString().toLowerCase().replaceAll(' ', '-').toLowerCase()); // 17
    // Add custom Option name to dimension
    currentRow.add('Dimension'); // 18
    currentRow.add(currentRow[8]); // 19
  }
  // Print the Column index for aid in mapping
  csvTable[0].asMap().forEach((key, value) {
    print('$key: $value');
  });

  // Write the List to CSV String using the csv package
  String csv = const ListToCsvConverter().convert(csvTable);
  // Write the CSV String to a file
  await File('./shopify-export.csv').writeAsString(csv);
  print("**** Export Complete ****");





}