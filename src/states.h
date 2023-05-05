#ifndef STATES_H
#define STATES_H

#include <QObject>

class States : public QObject {
  Q_OBJECT
public:
  enum myStates {
    InProccess = Qt::UserRole + 10, // виконується
    Done,                           // виконано
    Miss,                           // пропущено
    Hold                            // затримано
  };

  Q_ENUM(myStates)
};

#endif // STATES_H
