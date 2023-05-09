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
  void compareDate();
  void start(ListModel *model, DataBase *dataBase);

signals:
};

#endif // TIMER_H
