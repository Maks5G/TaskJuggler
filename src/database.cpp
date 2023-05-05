#include "database.h"

DataBase::DataBase(QObject *parent) : QObject(parent) {}

DataBase::~DataBase() {}

/* Методы для подключения к базе данных
 * */
void DataBase::connectToDataBase() {
  /* Перед подключением к базе данных производим проверку на её существование.
   * В зависимости от результата производим открытие базы данных или её
   * восстановление
   * */
  if (!QFile("C:/example/" DATABASE_NAME).exists()) {
    this->restoreDataBase();
  } else {
    this->openDataBase();
  }
}

/* Методы восстановления базы данных
 * */
bool DataBase::restoreDataBase() {
  // Если база данных открылась ...
  if (this->openDataBase()) {
    // Производим восстановление базы данных
    return (this->createTable()) ? true : false;
  } else {
    qDebug() << "Не удалось восстановить базу данных";
    return false;
  }
  return false;
}

/* Метод для открытия базы данных
 * */
bool DataBase::openDataBase() {
  /* База данных открывается по заданному пути
   * и имени базы данных, если она существует
   * */
  db = QSqlDatabase::addDatabase("QSQLITE");
  db.setHostName(DATABASE_HOSTNAME);
  db.setDatabaseName("C:/example/" DATABASE_NAME);
  if (db.open()) {
    return true;
  } else {
    return false;
  }
}

/* Методы закрытия базы данных
 * */
void DataBase::closeDataBase() { db.close(); }

/* Метод для создания таблицы в базе данных
 * */
bool DataBase::createTable() {
  /* В данном случае используется формирование сырого SQL-запроса
   * с последующим его выполнением.
   * */
  QSqlQuery query;
  if (!query.exec("CREATE TABLE " TABLE " ("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT, " TABLE_TITLE
                  " VARCHAR(255)    NOT NULL," TABLE_DESCRIPTION
                  " VARCHAR(255)    NOT NULL," TABLE_STATE
                  " INTEGER    NOT NULL"
                  " )")) {
    qDebug() << "DataBase: error of create " << TABLE;
    qDebug() << query.lastError().text();
    return false;
  } else {
    return true;
  }
  return false;
}

/* Метод для вставки записи в базу данных
 * */
bool DataBase::insertIntoTable(const QVariantList &data) {
  /* Запрос SQL формируется из QVariantList,
   * в который передаются данные для вставки в таблицу.
   * */
  QSqlQuery query;
  /* В начале SQL запрос формируется с ключами,
   * которые потом связываются методом bindValue
   * для подстановки данных из QVariantList
   * */
  query.prepare("INSERT INTO " TABLE " ( " TABLE_TITLE ", " TABLE_DESCRIPTION
                ", " TABLE_STATE " ) "
                "VALUES (:Title, :Description, :State)");
  query.bindValue(":Title", data[0].toString());
  query.bindValue(":Description", data[1].toString());
  query.bindValue(":State", data[2].toString());

  // После чего выполняется запросом методом exec()
  if (!query.exec()) {
    qDebug() << "error insert into " << TABLE;
    qDebug() << query.lastError().text();
    return false;
  } else {
    return true;
  }
  return false;
}

/* Второй метод для вставки записи в базу данных
 * */
bool DataBase::insertIntoTable(const QString &ttitle,
                               const QString &tdescription, const int tstate) {
  QVariantList data;
  data.append(ttitle);
  data.append(tdescription);
  data.append(tstate);

  if (insertIntoTable(data))
    return true;
  else
    return false;
}

/* Метод для удаления записи из таблицы
 * */
bool DataBase::removeRecord(const int id) {
  // Удаление строки из базы данных будет производитсья с помощью SQL-запроса
  QSqlQuery query;

  // Удаление производим по id записи, который передается в качестве аргумента
  // функции
  query.prepare("DELETE FROM " TABLE " WHERE id= :ID ;");
  query.bindValue(":ID", id);

  // Выполняем удаление
  if (!query.exec()) {
    qDebug() << "error delete row " << TABLE;
    qDebug() << query.lastError().text();
    return false;
  } else {
    return true;
  }
  return false;
}

bool DataBase::replaceRecord(const int id, const QString &ttitle,
                             const QString &tdescription) {
  QSqlQuery query;

  query.prepare("UPDATE " TABLE " SET " TABLE_TITLE
                " = :Title, " TABLE_DESCRIPTION " = :Description"
                " WHERE id= :ID ;");
  query.bindValue(":Title", ttitle);
  query.bindValue(":Description", tdescription);
  query.bindValue(":ID", id);

  if (!query.exec()) {
    qDebug() << "error replace row " << TABLE;
    qDebug() << query.lastError().text();
    return false;
  } else {
    return true;
  }
  return false;
}

bool DataBase::updateState(const int id, const int tstate) {
  QSqlQuery query;

  // Удаление производим по id записи, который передается в качестве аргумента
  // функции
  query.prepare("UPDATE " TABLE " SET " TABLE_STATE
                " = :State WHERE id = :ID ;");
  query.bindValue(":State", tstate);
  query.bindValue(":ID", id);

  // Выполняем удаление
  if (!query.exec()) {
    qDebug() << "error update state " << TABLE;
    qDebug() << query.lastError().text();
    return false;
  } else {
    return true;
  }
  return false;
}
