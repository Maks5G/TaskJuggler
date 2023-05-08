#ifndef LISTMODEL_H
#define LISTMODEL_H

#include <QObject>
#include <QSqlQueryModel>
#include <QString>

class ListModel : public QSqlQueryModel {
  Q_OBJECT

  Q_PROPERTY(QString where READ where WRITE setWhere NOTIFY whereChanged)
  Q_PROPERTY(
      QString orderBy READ orderBy WRITE setOrderBy NOTIFY orderByChanged)
  Q_PROPERTY(
      QString asc_desc READ asc_desc WRITE setAsc_desc NOTIFY asc_descChanged)

public:
  //  QString m_where;
  //  QString m_orderBy;
  //  QString m_inc_desc;

  /* Перечисляем все роли, которые будут использоваться в TableView
   * Как видите, они должны лежать в памяти выше параметра Qt::UserRole
   * Связано с тем, что информация ниже этого адреса не для кастомизаций
   * */
  enum Roles {
    IdRole = Qt::UserRole + 1, // id
    TitleRole,                 // title
    DescriptionRole,           // description
    StateRole,                 // state
    StartRole,                 // start
    EndRole                    // end
  };

  // объявляем конструктор класса
  explicit ListModel(QObject *parent = 0);

  // Переопределяем метод, который будет возвращать данные
  QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

  QString where() const;
  void setWhere(const QString &newWhere);

  QString orderBy() const;
  void setOrderBy(const QString &newOrderBy);

  QString asc_desc() const;
  void setAsc_desc(const QString &newAsc_desc);

protected:
  /* хешированная таблица ролей для колонок.
   * Метод используется в дебрях базового класса QAbstractItemModel,
   * от которого наследован класс QSqlQueryModel
   * */
  QHash<int, QByteArray> roleNames() const;

signals:

  void whereChanged();

  void orderByChanged();

  void asc_descChanged();

public slots:
  void updateModel();
  int getId(int row);
  void searchTask(const QString &ttitle);

private:
  QString m_where;
  QString m_orderBy;
  QString m_asc_desc;
};

#endif // LISTMODEL_H
