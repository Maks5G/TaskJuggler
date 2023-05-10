#ifndef MYLANG_H
#define MYLANG_H

#include <QLocale>
#include <QObject>

class MyLang : public QObject {
  Q_OBJECT
public:
  MyLang() {}

  enum E_Languages { ENG = QLocale::English, UKR = QLocale::Ukrainian };

  Q_ENUM(E_Languages)
};

#endif // MYLANG_H
