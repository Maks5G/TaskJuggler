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

/* Директиви імен таблиці, полів таблиці та бази даних */
#define DATABASE_HOSTNAME "NameTaskJuggler"
#define DATABASE_NAME "TaskJuggler.db"

#define TABLE "TaskJugglerTable"        // Назва таблиці
#define TABLE_TITLE "Title"             // Другий стовпець
#define TABLE_DESCRIPTION "Description" // Третій стовпець
#define TABLE_STATE "State"             // Четвертий стовпець
#define TABLE_START "StartDateTime"     // П'ятий стовпець
#define TABLE_END "EndDate"             // Шостий стовпець

// Первая колонка содержит Autoincrement ID

class DataBase : public QObject {
  Q_OBJECT
public:
  explicit DataBase(QObject *parent = 0);
  ~DataBase();
  /* Методи для безпосередньої роботи з класом
   * Підключення до бази даних і вставка записів у таблицю
   * */
  void connectToDataBase();

private:
  // Сам об'єкт бази даних, з яким буде проводитися робота
  QSqlDatabase db;

private:
  /* Внутрішні методи для роботи з базою даних
   * */
  bool openDataBase();    // Відкрити бази даних
  bool restoreDataBase(); // Відновлення бази даних
  void closeDataBase();   // Закриття бази даних
  bool createTable(); // Створення бази таблиці в базі даних

public slots:
  bool insertIntoTable(const QVariantList &data); // Додавання записів у таблицю
  bool insertIntoTable(const QString &ttitle, const QString &tdescription,
                       const int tstate, const QString &tstart,
                       const QString &tend); // Додавання записів у таблицю
  bool removeRecord(const int id); // Видалення запису з таблиці за її id
  bool
  replaceRecord(const int id, const QString &ttitle,
                const QString &tdescription,
                const QString &tend); // Заміна запису в таблиці за допомогою id
  bool
  updateState(const int id,
              const int tstate); // Заміна стану запису (In Proccess, Hold...)
};

#endif // DATABASE_H
