#include "mylistmodel.h"

MyListModel::MyListModel(QObject *parent)
    : QAbstractListModel(parent)
{
    // مقدار اولیه (برای تست)
    m_items.append({ "Item 1", 10 });
    m_items.append({ "Item 2", 20 });
    m_items.append({ "Item 3", 30 });
}

int MyListModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return m_items.size();
}

QVariant MyListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return {};

    const Item &item = m_items.at(index.row());

    switch (role) {
    case TitleRole: return item.title;
    case ValueRole: return item.value;
    }
    return {};
}

QHash<int, QByteArray> MyListModel::roleNames() const
{
    return {
        { TitleRole, "title" },
        { ValueRole, "value" }
    };
}

void MyListModel::addItem(const QString &title, int value)
{
    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append({ title, value });
    endInsertRows();
}

void MyListModel::removeFirst()
{
    if (m_items.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, 0);
    m_items.removeAt(0);
    endRemoveRows();
}

void MyListModel::editFirst(int newValue)
{
    if (m_items.isEmpty())
        return;

    m_items[0].value = newValue;

    emit dataChanged(index(0), index(0), { ValueRole });
}
