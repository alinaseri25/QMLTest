#ifndef MYBACKEND_H
#define MYBACKEND_H

#include <QObject>
#include <QDebug>

class MyBackend : public QObject
{
    Q_OBJECT
public:
    explicit MyBackend(QObject *parent = nullptr);

signals:
    void valueChanged(int newValue);

public slots:
    void doSomethingFromQml(const QString &msg);
};

#endif // MYBACKEND_H
