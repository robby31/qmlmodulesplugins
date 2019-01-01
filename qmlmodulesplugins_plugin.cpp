#include "qmlmodulesplugins_plugin.h"
#include "myqmlmodules.h"

#include <qqml.h>
#include "GraphisItem/progresscircle.h"
#include "Models/sqllistmodel.h"
#include "SqlModel/sqlquerymodel.h"
#include "SqlModel/myvxymodelmapper.h"

void QmlmodulespluginsPlugin::registerTypes(const char *uri)
{
    // @uri MyComponents
    qmlRegisterType<MyQmlModules>(uri, 1, 0, "MyQmlModules");
    qmlRegisterType<ProgressCircle>(uri, 1, 0, "ProgressCircle");
    qmlRegisterType<ListModel>(uri, 1, 0, "CListModel");
    qmlRegisterType<SqlListModel>(uri, 1, 0, "SqlListModel");
    qmlRegisterType<SqlQueryModel>(uri, 1, 0, "SqlQueryModel");
    qmlRegisterType<MyVXYModelMapper>(uri, 1, 0, "MyVXYModelMapper");
}


