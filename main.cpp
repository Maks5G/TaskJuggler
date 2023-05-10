#include <QGuiApplication>
#include <QIcon>
#include <QLocale>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTranslator>

#include "src/database.h"
#include "src/listmodel.h"
#include "src/states.h"
#include "src/timer.h"
#include "src/translation/mylang.h"
#include "src/translation/mytranslator.h"

int main(int argc, char *argv[]) {
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
  QGuiApplication app(argc, argv);
  app.setWindowIcon(QIcon(":/ui/assets/TaskJuggler.png"));

  MyTranslator mTrans(&app);

  // забезпучуємо доступ до enum двох класів та до класа таймера
  qmlRegisterType<MyLang>("MyLang", 1, 0, "MyLang");
  qmlRegisterType<Timer>("Timer", 1, 0, "MyTimer");
  qmlRegisterType<States>("States", 1, 0, "States");

  QQmlApplicationEngine engine;
  engine.addImportPath(":/ui");
  const QUrl url(QStringLiteral("qrc:/main.qml"));

  // Підключаємося до бази даних
  DataBase database;
  database.connectToDataBase();

  // Оголошуємо та ініціалізуємо модель даних
  ListModel *model = new ListModel();

  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreated, &app,
      [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
          QCoreApplication::exit(-1);
      },
      Qt::QueuedConnection);
  // Забезпечуємо доступ до моделі, трансляції та класу для роботи з базою даних
  // з QML
  engine.rootContext()->setContextProperty("myModel", model);
  engine.rootContext()->setContextProperty("database", &database);
  engine.rootContext()->setContextProperty("mytrans", (QObject *)&mTrans);
  engine.load(url);

  return app.exec();
}
