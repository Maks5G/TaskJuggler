#ifndef LISTMODEL_H
#define LISTMODEL_H

#include <QObject>
#include <QSqlQueryModel>
#include <QString>

class ListModel : public QSqlQueryModel {
  Q_OBJECT

  Q_PROPERTY(QString where READ where WRITE setWhere NOTIFY
                 whereChanged) // для умови виборки даних через WHERE
  Q_PROPERTY(QString orderBy READ orderBy WRITE setOrderBy NOTIFY
                 orderByChanged) // для сортування через ORDER_BY
  Q_PROPERTY(
      QString asc_desc READ asc_desc WRITE setAsc_desc NOTIFY
          asc_descChanged) // ASC DESC для прямого сортування чи оберненого

public:
  /* Перераховуємо всі ролі, які будуть використовуватися в TableView
   * Вони повинні знаходитися в пам'яті вище параметра Qt::UserRole
   * Пов'язано з тим, що інформація нижче цієї адреси не для кастомізацій
   * */
  enum Roles {
    IdRole = Qt::UserRole + 1, // id
    TitleRole,                 // заголовок
    DescriptionRole,           // опис
    StateRole,                 // стан
    StartRole,                 // початкова дата
    EndRole                    // кінцева дата
  };

  // Оголошуємо конструктор класу
  explicit ListModel(QObject *parent = 0);

  // Перевизначаємо метод, який буде повертати дані
  QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

  QString where() const;
  void setWhere(const QString &newWhere);

  QString orderBy() const;
  void setOrderBy(const QString &newOrderBy);

  QString asc_desc() const;
  void setAsc_desc(const QString &newAsc_desc);

protected:
  /* хешована таблиця ролей для колонок.
   * Метод використовується в нетрях базового класу QAbstractItemModel,
   * від якого успадковано клас QSqlQueryModel
   * */
  QHash<int, QByteArray> roleNames() const;

signals:

  void whereChanged();

  void orderByChanged();

  void asc_descChanged();

public slots:
  void updateModel(); // "вивід" бази даних із зазначенимим параметрами
  int getId(int row); // отримування id через індекс моделі
  int getState(int row); // отримування стану через індекс моделі
  QString getEnd(int row); // отримування кінцевої дати через індекс моделі
  void searchTask(const QString &ttitle); // "вивід" бази даних із зазначенимим
                                          // параметрами за заголовком

private:
  QString m_where;
  QString m_orderBy;
  QString m_asc_desc;
};

#endif // LISTMODEL_H
