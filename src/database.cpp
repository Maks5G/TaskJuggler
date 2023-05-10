#include "database.h"

DataBase::DataBase(QObject *parent) : QObject(parent) {}

DataBase::~DataBase() {}

/* Методи для підключення до бази даних
 * */
void DataBase::connectToDataBase() {
  /* Перед підключенням до бази даних проводимо перевірку на її існування.
   * Залежно від результату робимо відкриття бази даних або її
   * відновлення
   * */
  if (!QFile("C:/example/" DATABASE_NAME).exists()) {
    this->restoreDataBase();
  } else {
    this->openDataBase();
  }
}

/* Методи відновлення бази даних
 * */
bool DataBase::restoreDataBase() {
  // Якщо база даних відкрилась ...
  if (this->openDataBase()) {
    // Проводимо відновлення бази даних
    return (this->createTable()) ? true : false;
  } else {
    qDebug() << "Не вдалося відновити базу даних";
    return false;
  }
  return false;
}

/* Метод для відкриття бази даних
 * */
bool DataBase::openDataBase() {
  /* База даних відкривається за заданим шляхом
   * і імені бази даних, якщо вона існує
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

/* Методи закриття бази даних
 * */
void DataBase::closeDataBase() { db.close(); }

/* Метод для створення таблиці в базі даних
 * */
bool DataBase::createTable() {
  /* В даному випадку використовується формування сирого SQL-запросу
   * з наступним його виконанням.
   * */
  QSqlQuery query;
  if (!query.exec("CREATE TABLE " TABLE " ("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT, " TABLE_TITLE
                  " VARCHAR(255)    NOT NULL," TABLE_DESCRIPTION
                  " VARCHAR(255)    NOT NULL," TABLE_STATE
                  " INTEGER    NOT NULL," TABLE_START
                  " VARCHAR(255)    NOT NULL," TABLE_END
                  " VARCHAR(255)    NOT NULL"
                  " )")) {
    qDebug() << "DataBase: error of create " << TABLE;
    qDebug() << query.lastError().text();
    return false;
  } else {
    return true;
  }
  return false;
}

/* Метод вставки запису в базу даних
 * */
bool DataBase::insertIntoTable(const QVariantList &data) {
  /* Запрос SQL формується із QVariantList,
   * в який передаються дані для вставки в таблицю.
   * */
  QSqlQuery query;
  /* На початку SQL запрос формирується з ключами,
   * які потім звязуються методом bindValue
   * для підстановки даних із QVariantList
   * */
  query.prepare("INSERT INTO " TABLE " ( " TABLE_TITLE ", " TABLE_DESCRIPTION
                ", " TABLE_STATE ", " TABLE_START ", " TABLE_END " ) "
                "VALUES (:Title, :Description, :State, :Start, :End)");
  query.bindValue(":Title", data[0].toString());
  query.bindValue(":Description", data[1].toString());
  query.bindValue(":State", data[2].toString());
  query.bindValue(":Start", data[3].toString());
  query.bindValue(":End", data[4].toString());

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

/* Другий метод для вставки запису в базу даних
 * */
bool DataBase::insertIntoTable(const QString &ttitle,
                               const QString &tdescription, const int tstate,
                               const QString &tstart, const QString &tend) {
  QVariantList data;
  data.append(ttitle);
  data.append(tdescription);
  data.append(tstate);
  data.append(tstart);
  data.append(tend);

  if (insertIntoTable(data))
    return true;
  else
    return false;
}

/* Метод для видалення запису із таблиці
 * */
bool DataBase::removeRecord(const int id) {
  // Видалення рядків з бази даних буде здійснюватися за допомогою SQL-запиту
  QSqlQuery query;

  // Удаление производим по id записи, который передается в качестве аргумента
  // функції
  query.prepare("DELETE FROM " TABLE " WHERE id= :ID ;");
  query.bindValue(":ID", id);

  // Виконуємо видалення
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
                             const QString &tdescription, const QString &tend) {
  QSqlQuery query;

  // аналогічний принцип до минулого, лише більше полів
  query.prepare("UPDATE " TABLE " SET " TABLE_TITLE
                " = :Title, " TABLE_DESCRIPTION " = :Description, " TABLE_END
                " = :End"
                " WHERE id= :ID ;");
  query.bindValue(":Title", ttitle);
  query.bindValue(":Description", tdescription);
  query.bindValue(":ID", id);
  query.bindValue(":End", tend);

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

  // Обновляємо стан за id
  query.prepare("UPDATE " TABLE " SET " TABLE_STATE
                " = :State WHERE id = :ID ;");
  query.bindValue(":State", tstate);
  query.bindValue(":ID", id);

  // Виконуємо запрос
  if (!query.exec()) {
    qDebug() << "error update state " << TABLE;
    qDebug() << query.lastError().text();
    return false;
  } else {
    return true;
  }
  return false;
}
