#include "mybackend.h"

MyBackend::MyBackend(QObject *parent)
    : QObject{parent}
{
    timerCounter = 0;

    timer = new QTimer(this);
    connect(timer,&QTimer::timeout,this,&MyBackend::onTimerTimeout);
    timer->start(1000);
}

void MyBackend::onTimerTimeout()
{
    emit valueChanged(timerCounter);
    timerCounter++;
}

void MyBackend::doSomethingFromQml(const QString &msg)
{
    qDebug() << "Called from QML:" << msg;

    emit changeButtonText(QString("Hello at %1").arg(timerCounter));
}
