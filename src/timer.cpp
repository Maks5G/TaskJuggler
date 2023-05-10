#include "timer.h"
#include "states.h"
#include <QDateTime>

Timer::Timer(QObject *parent) : QObject{parent} {}

void Timer::compareDate() {
  QDateTime dateTime;
  QString time_format = "dd.MM.yyyy";
  for (int i = 0; i < m_list->rowCount(); ++i) { // цикл по всім рядкам
    QDateTime end = QDateTime::fromString(
        m_list->getEnd(i),
        time_format); // перетворюємо строку в об'єкт QDateTime
    if (dateTime.currentDateTime() >
            end && // перевірка чи теперішня дата більша за отримману з бд
        m_list->getState(i) ==
            States::InProccess) { // умова, що стан, який відповідає цьому
                                  // часові, в процесі
      m_db->updateState(m_list->getId(i), States::Miss); // змінюємо стан
      m_list->updateModel(); // знову зчитуємо всю таблицю
    }
  }
  m_Timer->start(); // знову запускаємо таймер
}

void Timer::start(ListModel *model, DataBase *dataBase) {
  m_list = model;
  m_db = dataBase;

  m_Timer = new QTimer(this);
  m_Timer->setInterval(10000);
  m_Timer->setSingleShot(true); // повторюється таймер тільки раз
  connect(m_Timer, SIGNAL(timeout()), this,
          SLOT(compareDate())); // з'єднуємо сигнал кінця таймеру із методом для
                                // порівняння дат

  compareDate(); // запускаємо перевірку
}
