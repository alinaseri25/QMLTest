#ifndef MYLISTMODEL_H
#define MYLISTMODEL_H

#include <QAbstractListModel>
#include <QObject>

class MyListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit MyListModel(QObject *parent = nullptr);

    // ساختار یک آیتم
    struct Item {
        QString title;
        int value;
    };

    // کلیدهای Role
    enum Roles {
        TitleRole = Qt::UserRole + 1,
        ValueRole
    };

    // توابع پایهٔ QAbstractListModel:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    // توابع کنترل داده‌ها
    Q_INVOKABLE void addItem(const QString &title, int value);
    Q_INVOKABLE void removeFirst();
    Q_INVOKABLE void editFirst(int newValue);

private:
    QList<Item> m_items;
};

#endif // MYLISTMODEL_H
