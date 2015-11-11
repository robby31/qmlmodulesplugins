TEMPLATE = lib
TARGET = qmlmodulesplugins
QT += qml quick
CONFIG += qt plugin

DESTDIR = $$PWD/MyComponents
TARGET = $$qtLibraryTarget($$TARGET)
uri = MyComponents

# Input
SOURCES += \
    qmlmodulesplugins_plugin.cpp \
    myqmlmodules.cpp \
    GraphisItem/progresscircle.cpp

HEADERS += \
    qmlmodulesplugins_plugin.h \
    myqmlmodules.h \
    GraphisItem/progresscircle.h

OTHER_FILES =   MyComponents/qmldir \
                MyComponents/plugins.qmltypes \
                MyComponents/BusyIndicator/BusyIndicator.qml \
                MyComponents/Dialog/FlippableDialog.qml \
                MyComponents/Header/Header.qml \
                MyComponents/Header/AirbusHeader.qml \
                MyComponents/PopupBox/PopupBox.qml \
                MyComponents/ToggleButton/ToggleButton.qml \
                MyComponents/Page/Page.qml \
                MyComponents/ParameterList/ParameterList.qml \
                MyComponents/ParameterList/ParameterDelegate.qml \
                MyComponents/ParameterList/Delegates/CheckedEnumParameterDelegate.qml \
                MyComponents/ParameterList/Delegates/CheckedListDelegate.qml \
                MyComponents/ParameterList/Delegates/EnumParameterDelegate.qml \
                MyComponents/ParameterList/Delegates/OpenCsvFileParameterDelegate.qml \
                MyComponents/ParameterList/Delegates/SaveCsvFileParameterDelegate.qml \
                MyComponents/ParameterList/Delegates/IntegerParameterDelegate.qml \
                MyComponents/ParameterList/Delegates/TextParameterDelegate.qml \
                MyComponents/Tab/Tab.qml \
                MyComponents/Tab/PanelTab.qml \
                MyComponents/TextFieldWithLabel/TextFieldWithLabel.qml \
                MyComponents/SideMenu/SideMenu.qml \
                MyComponents/SideMenu/ActionDelegate.qml \
                MyComponents/Splitter/Splitter.qml \
                MyComponents/StatusBar/StatusBar.qml \
                MyComponents/TickBox/TickBox.qml \
                MyComponents/Themes/AirbusThemeDefault.qml \
                MyComponents/View/ScrollIndicator.qml \
                MyComponents/InformationSection/InformationSection.qml \
                MyComponents/View/CoverFlow/CoverFlow.qml \
                MyComponents/View/CoverFlow/CoverFlowDelegate.qml \
                MyComponents/View/CoverFlow/BackViewList.qml \
                MyComponents/View/CoverFlow/BackViewListDelegate.qml \
                MyComponents/View/MyTableView.qml

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = MyComponents/qmldir
unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += target qmldir
}

DISTFILES += \
    jbQuick/Charts/QChart.js \
    jbQuick/Charts/QChartGallery.js \
    jbQuick/Charts/qmldir \
    jbQuick/Charts/QChart.qml \
    jbQuick/Charts/QChartGallery.qml

