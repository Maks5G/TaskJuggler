#include "timer.h"
#include "states.h"
#include <QDateTime>

Timer::Timer(QObject *parent) : QObject{parent} {}

void Timer::compareDate() {
  QDateTime dateTime;
  QString time_format = "dd.MM.yyyy";
  for (int i = 0; i < m_list->rowCount(); ++i) {
    QDateTime end = QDateTime::fromString(m_list->getEnd(i), time_format);
    if (dateTime.currentDateTime() > end &&
        m_list->getState(i) == States::InProccess) {
      m_db->updateState(m_list->getId(i), States::Miss);
      m_list->updateModel();
    }
  }
  m_Timer->start();
}

void Timer::start(ListModel *model, DataBase *dataBase) {
  m_list = model;
  m_db = dataBase;

  m_Timer = new QTimer(this);
  m_Timer->setInterval(10000);
  m_Timer->setSingleShot(true);
  connect(m_Timer, SIGNAL(timeout()), this, SLOT(compareDate()));
}
