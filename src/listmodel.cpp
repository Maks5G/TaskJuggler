#include "listmodel.h"
#include "database.h"
#include <QString>

ListModel::ListModel(QObject *parent)
    : QSqlQueryModel(parent), m_where(""), m_orderBy(" ORDER BY id "),
      m_asc_desc("") {

  this->updateModel();
}

// Метод отримання даних з моделей
QVariant ListModel::data(const QModelIndex &index, int role) const {

  // З'ясовуємо номер колонки, адрес так сказать, по номеру роли
  int columnId = role - Qt::UserRole - 1;
  // Створюємо індекс за допомогою новоспеченої ідентифікаційної колонки
  QModelIndex modelIndex = this->index(index.row(), columnId);

  /* І за допомогою вже методу data() базового класу
   * вибираємо дані для таблиці з моделей
   * */
  return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

// Метод отримання імені ролі через хешировану таблицю.
QHash<int, QByteArray> ListModel::roleNames() const {
  /* Тобто збереігаємо в хеш-таблиці назви ролей
   * по їх номеру
   * */
  QHash<int, QByteArray> roles;
  roles[IdRole] = "id";
  roles[TitleRole] = "ttitle";
  roles[DescriptionRole] = "tdescription";
  roles[StateRole] = "tstate";
  roles[StartRole] = "tstart";
  roles[EndRole] = "tend";
  return roles;
}

// Метод оновлення таблиці в моделі представлення даних
void ListModel::updateModel() {
  // Оновлення виробляється SQL-запитом до бази даних
  this->setQuery("SELECT * FROM " TABLE + m_where + m_orderBy + m_asc_desc);
}

// Отримання id із строки в моделі представлення даних
int ListModel::getId(int row) {
  return this->data(this->index(row, 0), IdRole).toInt();
}
// Отримання стану із строки в моделі представлення даних
int ListModel::getState(int row) {
  return this->data(this->index(row, 0), StateRole).toInt();
}
// Отримання кінцевої дати із строки в моделі представлення даних
QString ListModel::getEnd(int row) {
  return this->data(this->index(row, 0), EndRole).toString();
}

void ListModel::searchTask(const QString &ttitle) {
  if (m_where != "")
    this->setQuery("SELECT * FROM " TABLE + m_where +
                   " AND " TABLE_TITLE " LIKE '" + ttitle + "%'" + m_orderBy +
                   m_asc_desc);
  else
    this->setQuery("SELECT * FROM " TABLE " WHERE " TABLE_TITLE " LIKE '" +
                   ttitle + "%'" + m_orderBy + m_asc_desc);
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
  m_orderBy = " ORDER BY " + newOrderBy;
  emit orderByChanged();
}

QString ListModel::asc_desc() const { return m_asc_desc; }

void ListModel::setAsc_desc(const QString &newAsc_desc) {
  if (m_asc_desc == newAsc_desc)
    return;
  m_asc_desc = newAsc_desc;
  emit asc_descChanged();
}
