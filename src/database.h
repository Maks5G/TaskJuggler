#ifndef DATABASE_H
#define DATABASE_H

#include <QDate>
#include <QDebug>
#include <QFile>
#include <QObject>
#include <QSql>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>

/* Директивы имен таблицы, полей таблицы и базы данных */
#define DATABASE_HOSTNAME "NameTaskJuggler"
#define DATABASE_NAME "TaskJuggler.db"

#define TABLE "TaskJugglerTable"        // Название таблицы
#define TABLE_TITLE "Title"             // Вторая колонка
#define TABLE_DESCRIPTION "Description" // Третья колонка
#define TABLE_STATE "State"             // Четвертая колонка

// Первая колонка содержит Autoincrement ID

class DataBase : public QObject {
  Q_OBJECT
public:
  explicit DataBase(QObject *parent = 0);
  ~DataBase();
  /* Методы для непосредственной работы с классом
   * Подключение к базе данных и вставка записей в таблицу
   * */
  void connectToDataBase();

private:
  // Сам объект базы данных, с которым будет производиться работа
  QSqlDatabase db;

private:
  /* Внутренние методы для работы с базой данных
   * */
  bool openDataBase();    // Открытие базы данных
  bool restoreDataBase(); // Восстановление базы данных
  void closeDataBase();   // Закрытие базы данных
  bool createTable(); // Создание базы таблицы в базе данных

public slots:
  bool
  insertIntoTable(const QVariantList &data); // Добавление записей в таблицу
  bool insertIntoTable(const QString &ttitle, const QString &tdescription,
                       const int tstate);
  bool removeRecord(const int id); // Удаление записи из таблицы по её id
  bool replaceRecord(const int id, const QString &ttitle,
                     const QString &tdescription);
  bool updateState(const int id, const int tstate);
};

#endif // DATABASE_H
