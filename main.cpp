#include <QGuiApplication>
#include <QLocale>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTranslator>

#include "src/database.h"
#include "src/listmodel.h"
#include "src/states.h"

int main(int argc, char *argv[]) {
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
  QGuiApplication app(argc, argv);

  QTranslator translator;
  const QStringList uiLanguages = QLocale::system().uiLanguages();
  for (const QString &locale : uiLanguages) {
    const QString baseName = "TaskJuggler_" + QLocale(locale).name();
    if (translator.load(":/i18n/" + baseName)) {
      app.installTranslator(&translator);
      break;
    }
  }

  qmlRegisterType<States>("States", 1, 0, "States");

  QQmlApplicationEngine engine;
  engine.addImportPath(":/ui");
  const QUrl url(QStringLiteral("qrc:/main.qml"));

  // Подключаемся к базе данных
  DataBase database;
  database.connectToDataBase();

  // Объявляем и инициализируем модель данных
  ListModel *model = new ListModel();

  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreated, &app,
      [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
          QCoreApplication::exit(-1);
      },
      Qt::QueuedConnection);
  // Обеспечиваем доступ к модели и классу для работы с базой данных из QML
  engine.rootContext()->setContextProperty("myModel", model);
  engine.rootContext()->setContextProperty("database", &database);
  engine.load(url);

  return app.exec();
}
