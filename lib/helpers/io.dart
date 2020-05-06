import 'dart:io';
import 'package:path_provider/path_provider.dart';

readFile(fileName) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName.json');
    if (await file.exists()) {
      return await file.readAsString();
    } else {
      return null;
    }
  } catch (e) {
    print("Couldn't read file");
  }
}

saveFile(fileName, String content) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$fileName.json');
  await file.writeAsString(content);
  print('saved');
}
