#include "mybackend.h"

MyBackend::MyBackend(QObject *parent)
    : QObject{parent}
{}

QString MyBackend::doSomethingFromQml(const QString &msg)
{
    qDebug() << "Called from QML:" << msg;

    // فقط برای تست—هر مقدار دلخواه می‌تونه باشه
    emit valueChanged(msg.length());

    return QString("Hello");
}
