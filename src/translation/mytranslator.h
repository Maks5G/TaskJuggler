#ifndef MYTRANSLATOR_H
#define MYTRANSLATOR_H

#include "mylang.h"
#include <QGuiApplication>
#include <QObject>
#include <QQuickView>
#include <QTranslator>

class MyTranslator : public QObject {
  Q_OBJECT
  Q_PROPERTY(QString emptyString READ getEmptyString NOTIFY languageChanged)

public:
  MyTranslator(QGuiApplication *app) { mApp = app; }

  QString getEmptyString() { return ""; }

signals:
  void languageChanged();

public slots:
  void updateLanguage(int lang) {
    switch (lang) {
    case MyLang::UKR:
      mTranslator.load(":/translations/TaskJuggler_uk_UA.qm");
      mApp->installTranslator(&mTranslator);
      break;
    default:
      mApp->removeTranslator(&mTranslator);
      break;
    }
    emit languageChanged();
  }

private:
  QGuiApplication *mApp;
  QTranslator mTranslator;
};

#endif // MYTRANSLATOR_H
