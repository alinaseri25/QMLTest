#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <mybackend.h>
#include <mylistmodel.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    MyBackend *backend =  new MyBackend(NULL);
    engine.rootContext()->setContextProperty("backend", backend);

    MyListModel *listModel = new MyListModel(NULL);
    engine.rootContext()->setContextProperty("listModel", listModel);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("QMLTest", "Main");

    return app.exec();
}
