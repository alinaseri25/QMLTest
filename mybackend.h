#ifndef MYBACKEND_H
#define MYBACKEND_H

#include <QObject>
#include <QDebug>
#include <QTimer>

class MyBackend : public QObject
{
    Q_OBJECT
public:
    explicit MyBackend(QObject *parent = nullptr);

private:
    QTimer *timer;
    qint64 timerCounter;

private slots:
    void onTimerTimeout(void);

signals:
    void valueChanged(int newValue);
    void changeButtonText(QString data);

public slots:
    void doSomethingFromQml(const QString &msg);
};

#endif // MYBACKEND_H
