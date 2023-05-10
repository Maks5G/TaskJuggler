#ifndef TIMER_H
#define TIMER_H

#include "database.h"
#include "listmodel.h"
#include <QObject>
#include <QString>
#include <QTimer>

class Timer : public QObject {
  Q_OBJECT

public:
  explicit Timer(QObject *parent = nullptr);

private:
  QTimer *m_Timer;
  ListModel *m_list;
  DataBase *m_db;

public slots:
  void compareDate(); // перевірка кожного запису на те, чи не прийшов дедлайн
  void start(ListModel *model,
             DataBase *dataBase); // умовно конструктор з якого начинаємо все
                                  // виконувати
};

#endif // TIMER_H
