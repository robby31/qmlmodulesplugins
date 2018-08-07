#ifndef QMLMODULESPLUGINS_PLUGIN_H
#define QMLMODULESPLUGINS_PLUGIN_H

#include <QQmlExtensionPlugin>

class QmlmodulespluginsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri) Q_DECL_OVERRIDE;
};

#endif // QMLMODULESPLUGINS_PLUGIN_H

