import 'dart:core';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_dolist_app/Features/Favourites/Data/Model/favourite.dart';
import 'package:to_dolist_app/Features/HomeScreen/Data/model/Category.dart';

import '../../Features/DetailsHome/Data/model/Task.dart';
import '../../Features/TaskDate/Data/model/today_task.dart';

abstract class DataBaseHelper{

  static Database? database;


  static Future<Database> getDatabase() async {
    if (database != null) {
      return database!;
    } else {
      database = await initDatabase();
      return database!;
    }
  }

  static Future<Database> initDatabase() async {
    return await openDatabase(

      join(await getDatabasesPath(), 'TooDo.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE Task(id INTEGER PRIMARY KEY AUTOINCREMENT , title TEXT NOT NULL ,recycle INTEGER  NULL,isFav INTEGER NULL , date TEXT NOT NULL ,priority Text NULL,categoryId INTEGER NOT NULL,FOREIGN KEY(categoryId) references Category(id))",
        );
        await db.execute(
          "CREATE TABLE Category(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, color1 INTEGER NOT NULL, color2 INTEGER NOT NULL);",
        );
      },

      version: 1,
    );
  }

  static Future<List<TaskCategory>> getCategories() async {
    final myDb = await getDatabase();
    var data = await myDb.rawQuery(
        "select * from 'Category'");
    return data.map((e) => TaskCategory.fromJson(e)).toList();
  }

  static Future<String> insertCategory(TaskCategory category) async {
    
    final myDb = await getDatabase();
    await myDb.insert('Category', category.toJson());
    return "inserted Successfully";
 
  }


  static Future<String> updateCategory(TaskCategory category) async {

    final myDb = await getDatabase();
    await myDb.rawQuery("Update Category set name='${category.name}',color1=${category.color1},color2=${category.color2} where id=${category.id}");
 return "updated Successfully";
  }

static Future<String> deleteCategory(int id)async{

  final myDb = await getDatabase();
  await myDb.rawQuery("delete from Category where id=$id");
  return "deleted Successfully";

  }

 static Future<List<Tasks>>getDataDependsOnCategoryAndPriority
    ({required final int id,required final String priority})
 async

 {
     final Database myDb=await initDatabase();

     final data = await myDb.rawQuery(
       "SELECT * FROM Task WHERE categoryId = ? AND priority = ? AND recycle = 0",
       [id, priority],
     );

     return  data.map((Map<String,dynamic> e) =>Tasks.fromJson(e)).toList();
}

static Future<int>insertTask(Tasks task)async{

  final Database myDb=await initDatabase();

  return await myDb.insert('Task', task.toJson());
}

static Future<int>deleteTask(int id)async{

final Database myDb=await initDatabase();
return await myDb.rawDelete("delete from Task where id=$id");

  }

static Future<int>updateTask(Tasks task)async{
  final Database myDb=await initDatabase();
  return await myDb.rawUpdate("Update Task set title='${task.title}',isFav=${task.isFav},categoryId=${task.categoryId},priority='${task.priority}',recycle=${task.isRecycleBin},date='${task.date}' where id=${task.id}");

  }

  static Future<int>updateRestore(Today today) async {

    final Database myDb=await initDatabase();

    return await myDb.rawUpdate("Update Task set recycle=${today.isRecycle} where id=${today.id}");
  }

  static Future<int> updateFav ({required int id,required dynamic isFav}) async {

  final Database myDb = await initDatabase();

  // You can use the item properties generically
  return await myDb.rawUpdate(
  "Update Task set isFav = ? where id = ?",
  [isFav, id]
  );
  }




  static Future<List<Today>> getAllDataToday(DateTime time) async {

    final  myDb= await getDatabase();

    var data = await myDb.rawQuery(

        "select Category.color1,Category.color2 ,Task.title,Task.id,Task.isFav from Category  INNER JOIN Task  on Category.id=Task.categoryId where Task.date = '${DateFormat('yMMMd')
            .format(time)
            .toString()}'");
    return data.map((e) => Today.fromJson(e)).toList();
  }


  static Future<List<Today>> getAllDataUpcoming(DateTime time) async {

    final myDb = await getDatabase();

    var data = await myDb.rawQuery(
        " select Category.color1,Category.color2 ,Task.title,Task.id,Task.isFav from Category  INNER JOIN Task  on Category.id=Task.categoryId where date = '${DateFormat('yMMMd')
            .format(time)
            .toString()}'");

    return data.map((e) => Today.fromJson(e)).toList();

  }

  static Future<List<FavModel>> getFavourites() async {

  final myDb=await initDatabase();

  final data=await myDb.rawQuery("select Category.color1 ,Category.color2 ,Task.title,Task.id,Task.isFav,Task.date from Task inner join Category on Task.categoryId = Category.id where isFav= 1");

  return data.map((e)=>FavModel.fromJson(e)).toList();

}

static Future<List<Today>> getRecycleBinData() async {

    final myDb=await initDatabase();

  var data =await myDb.rawQuery('select Category.color1,Category.color2 ,Task.title,Task.date,Task.id,Task.isFav from Category inner join Task on Category.id=Task.categoryId where Task.recycle=1');
return data.map((e){
  return Today.fromJson(e);
}).toList();
  }



}
