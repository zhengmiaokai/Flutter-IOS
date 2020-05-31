import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

enum Directory {
  document,
  temporary,
  library,
}

class LCDirectoryPath {
  static Future<String> get documentDir async {
    final _documentDir = await getApplicationDocumentsDirectory();
    return _documentDir.path;
  }

  static Future<String> get temporaryDir async {
    final _temporaryDir = await getTemporaryDirectory();
    return _temporaryDir.path;
  }

  static Future<String> get storageDir async {
    final _storageDir = await getExternalStorageDirectory();
    return _storageDir.path;
  }
}

class LCKVStorage {

  static SharedPreferences sharedPrefs;

  static Future <SharedPreferences> shareInstance() async {
    if (sharedPrefs == null) {
      sharedPrefs = await SharedPreferences.getInstance();
    }
    return sharedPrefs;
  }

  Future <void> setValueForKey(String value, String key) async{
    SharedPreferences prefs = await shareInstance();
    prefs.setString(key,value);
  }

  Future <String> valueForKey(String key) async{
    SharedPreferences prefs = await shareInstance();
    String value = prefs.getString(key);
    return value;
  }

  test() async {
    LCKVStorage().setValueForKey('value', 'key');
    String value = await LCKVStorage().valueForKey('key');
  }
}

class LCFilePathStorage {

  File loacalFile(String dir, String filePath) {
    File file = new File('$dir/$filePath');
    if(!file.existsSync()) {
      file.createSync();
    }
    return file;
  }

  Future writeToFile(File file, String notes) async {
    File file1 = await file.writeAsString(notes);
    if(file1.existsSync()) {
      print('file save success');
    } else {
      print('file save fail');
    }
  }

  Future<String> readFromFile(File file) async {
    String result = await file.readAsString();
    return result;
  }

  test() async {
    String dir = await LCDirectoryPath.documentDir;
    File file = loacalFile(dir, 'abc.txt');
    await writeToFile(file, 'adsfsfdsfsfsdfsd');
    
    await readFromFile(file);
  }
}

class LCDataBaseStorage  {

  Database dBase;

  Future<Database> creatDB(file) async {
    var path = await getDatabasesPath();
    String dirPath = join(path, file);
    Database db = await openDatabase(dirPath);
    this.dBase = db;
    return db;
  }

  /* 数据类型：INTEGER TEXT DOUBLE LONG SINGLE */
  createTable(String table, Map keyTypes, bool isPRIMARY) async {
    String queryParams = isPRIMARY ? 'id INTEGER PRIMARY KEY' : '';
    for (var key in keyTypes.keys) {
      var value = keyTypes[key];
      queryParams = queryParams + ', $key $value';
    }
    String query = 'create table if not exists $table ($queryParams)';
    await this.dBase.execute(query);
  }

  insert(table, parmas) async {
    await this.dBase.insert(table, parmas); 
  }

  /* 调用示例
  this.rawInsert('dbTable', {'name': 'lilylin', 'age': 27, 'enjoy': '踢足球，跑步，炒菜等等'});
  this.rawInsert('insert into dbTable (name, age, enjoy) VALUES (?, ?, ?)', ['lilylin', 27, '踢足球，跑步，炒菜等等']);
  this.rawInsert('insert into dbTable (name, age, enjoy) VALUES ("lilylin", 27, "踢足球，跑步，炒菜等等")');
  */
  rawInsert(query, [params]) async {
    if (params != null) {
      if (params.runtimeType.toString().contains('Map')) {
        String keys = '';
        List values = new List();
        String zwf = '';
        for (var key in params.keys) {
          var value = params[key];
          keys = keys + (keys.isEmpty?key:', '+key);
          values.add(value);
          zwf = zwf + (zwf.isEmpty?'':', ') + '?';
        }
        String table = query;
        await this.dBase.rawInsert('insert into $table ($keys) VALUES ($zwf)', values);
      } else if (params.runtimeType.toString().contains('List')) {
        await this.dBase.rawInsert(query, params);
      } else {
        print('rawInsert:====插入数据格式有误');
      }
    } else {
      await this.dBase.rawInsert(query);
    }
  }

  update(table, values, {String where, List whereArgs}) async {
    await this.dBase.update(table, values, where: where, whereArgs: whereArgs);
  }

  rawUpdate(query) async {
    await this.dBase.rawUpdate(query);
  }

  Future<List> query(table, {String where, List whereArgs}) async {
    List list = await this.dBase.query(table, where: where, whereArgs: whereArgs);
    return list;
  }

  Future<List> rawQuery(query) async {
    List list = await this.dBase.rawQuery(query);
    return list;
  }

  delete(table) async {
    await this.dBase.delete(table);
    this.dBase.delete(table);
  }
  
  rawDelete(query) async {
    await this.dBase.rawDelete(query);
  }
  
  close() async {
    await this.dBase.close();
  }

  test() async {

    await this.creatDB('db/db_base.db');

    this.createTable('dbTable', {'name':'TEXT', 'age':'INTEGER', 'enjoy':'TEXT'}, true);

    await this.rawInsert('dbTable', {'name': 'lilylin', 'age': 27, 'enjoy': '踢足球，跑步，炒菜等等'});

    List list = await this.query('dbTable');

    Map map = list[0];

    print( 'dbTable(${list.length}):====name/${map['name']}\n' + 'age/${map['age']}\n' + 'enjoy/${map['enjoy']}');

    this.close();
  }
}