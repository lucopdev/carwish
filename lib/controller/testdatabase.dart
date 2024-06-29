import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p; // Importando 'path' com o prefixo 'p'

void printDatabasePath() async {
  var documentsDirectory = await getApplicationDocumentsDirectory();
  var dbPath = p.join(documentsDirectory.path, 'cars_database.db');
  print('Database Path: >>>>>>>>>>>>>>>>>>>>>> $dbPath');
}
