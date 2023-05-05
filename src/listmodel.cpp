#include "listmodel.h"
#include "database.h"
#include <QString>

ListModel::ListModel(QObject *parent)
    : QSqlQueryModel(parent), m_where(""), m_orderBy(""), m_inc_desc("") {

  this->updateModel();
}

// Метод для получения данных из модели
QVariant ListModel::data(const QModelIndex &index, int role) const {

  // Определяем номер колонки, адрес так сказать, по номеру роли
  int columnId = role - Qt::UserRole - 1;
  // Создаём индекс с помощью новоиспечённого ID колонки
  QModelIndex modelIndex = this->index(index.row(), columnId);

  /* И с помощью уже метода data() базового класса
   * вытаскиваем данные для таблицы из модели
   * */
  return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

// Метод для получения имен ролей через хешированную таблицу.
QHash<int, QByteArray> ListModel::roleNames() const {
  /* То есть сохраняем в хеш-таблицу названия ролей
   * по их номеру
   * */
  QHash<int, QByteArray> roles;
  roles[IdRole] = "id";
  roles[TitleRole] = "ttitle";
  roles[DescriptionRole] = "tdescription";
  roles[StateRole] = "tstate";
  return roles;
}

// Метод обновления таблицы в модели представления данных
void ListModel::updateModel() {
  // Обновление производится SQL-запросом к базе данных
  this->setQuery("SELECT id, " TABLE_TITLE ", " TABLE_DESCRIPTION
                 ", " TABLE_STATE " FROM " TABLE +
                 m_where);
}

// Получение id из строки в модели представления данных
int ListModel::getId(int row) {
  return this->data(this->index(row, 0), IdRole).toInt();
}

void ListModel::searchTask(const QString &ttitle) {
  if (m_where != "")
    this->setQuery("SELECT id, " TABLE_TITLE ", " TABLE_DESCRIPTION
                   ", " TABLE_STATE " FROM " TABLE +
                   m_where + " AND " TABLE_TITLE " LIKE '" + ttitle + "%';");
  else
    this->setQuery("SELECT id, " TABLE_TITLE ", " TABLE_DESCRIPTION
                   ", " TABLE_STATE " FROM " TABLE " WHERE " TABLE_TITLE
                   " LIKE '" +
                   ttitle + "%';");
}

QString ListModel::where() const { return m_where; }

void ListModel::setWhere(const QString &newWhere) {
  if (newWhere == "0") {
    m_where = "";
  } else {
    m_where = " WHERE State = " + newWhere;
    emit whereChanged();
  }
}

QString ListModel::orderBy() const { return m_orderBy; }

void ListModel::setOrderBy(const QString &newOrderBy) {
  if (m_orderBy == newOrderBy)
    return;
  m_orderBy = newOrderBy;
  emit orderByChanged();
}

QString ListModel::inc_desc() const { return m_inc_desc; }

void ListModel::setInc_desc(const QString &newInc_desc) {
  if (m_inc_desc == newInc_desc)
    return;
  m_inc_desc = newInc_desc;
  emit inc_descChanged();
}
