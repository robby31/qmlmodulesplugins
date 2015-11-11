#include "qmlmodulesplugins_plugin.h"
#include "myqmlmodules.h"

#include <qqml.h>
#include "GraphisItem/progresscircle.h"

void QmlmodulespluginsPlugin::registerTypes(const char *uri)
{
    // @uri MyComponents
    qmlRegisterType<MyQmlModules>(uri, 1, 0, "MyQmlModules");
    qmlRegisterType<ProgressCircle>(uri, 1, 0, "ProgressCircle");
}


