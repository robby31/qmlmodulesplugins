TEMPLATE = lib
TARGET = qmlmodulesplugins
QT += qml quick sql
CONFIG += qt plugin

TARGET = $$qtLibraryTarget($$TARGET)
uri = MyComponents

INCLUDEPATH += $$(MYLIBRARY)/$$QT_VERSION/include/QmlApplication
LIBS += -L$$(MYLIBRARY)/$$QT_VERSION -l$$qtLibraryTarget(QmlApplication)

# Input
SOURCES += \
    qmlmodulesplugins_plugin.cpp \
    myqmlmodules.cpp \
    GraphisItem/progresscircle.cpp

HEADERS += \
    qmlmodulesplugins_plugin.h \
    myqmlmodules.h \
    GraphisItem/progresscircle.h

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
target.path = $$installPath

qmldir.files = MyComponents/qmldir MyComponents/plugins.qmltypes
qmldir.path = $$installPath

application.files = MyComponents/MyApplication.qml
application.path = $$installPath

busyindicator.files = MyComponents/BusyIndicator/BusyIndicator.qml
busyindicator.path = $$installPath/BusyIndicator

dialog.files = MyComponents/Dialog/FlippableDialog.qml  \
               MyComponents/Dialog/FilteringColumnDelegate.qml \
               MyComponents/Dialog/FilteringDialog.qml
dialog.path = $$installPath/Dialog

header.files = MyComponents/Header/Header.qml \
                MyComponents/Header/AirbusHeader.qml
header.path = $$installPath/Header

popupbox.files = MyComponents/PopupBox/PopupBox.qml
popupbox.path = $$installPath/PopupBox

togglebutton.files = MyComponents/ToggleButton/ToggleButton.qml
togglebutton.path = $$installPath/ToggleButton

mybutton.files = MyComponents/MyButton/MyButton.qml
mybutton.path = $$installPath/MyButton

page.files = MyComponents/Page/Page.qml \
             MyComponents/Page/DatabaseDelegate.qml \
             MyComponents/Page/DatabasePage.qml
page.path = $$installPath/Page

parameterlist.files = MyComponents/ParameterList/ParameterList.qml \
                      MyComponents/ParameterList/ParameterDelegate.qml
parameterlist.path = $$installPath/ParameterList

parameterlistdelegates.files = MyComponents/ParameterList/Delegates/CheckedEnumParameterDelegate.qml \
                               MyComponents/ParameterList/Delegates/CheckedListDelegate.qml \
                               MyComponents/ParameterList/Delegates/EnumParameterDelegate.qml \
                               MyComponents/ParameterList/Delegates/OpenCsvFileParameterDelegate.qml \
                               MyComponents/ParameterList/Delegates/SaveCsvFileParameterDelegate.qml \
                               MyComponents/ParameterList/Delegates/IntegerParameterDelegate.qml \
                               MyComponents/ParameterList/Delegates/TextParameterDelegate.qml
parameterlistdelegates.path = $$installPath/ParameterList/Delegates

tab.files = MyComponents/Tab/Tab.qml \
            MyComponents/Tab/PanelTab.qml
tab.path = $$installPath/Tab

textfield.files = MyComponents/TextFieldWithLabel/TextFieldWithLabel.qml
textfield.path = $$installPath/TextFieldWithLabel

sidemenu.files = MyComponents/SideMenu/SideMenu.qml \
                 MyComponents/SideMenu/ActionDelegate.qml
sidemenu.path = $$installPath/SideMenu

themes.files = MyComponents/Themes/AirbusThemeDefault.qml
themes.path = $$installPath/Themes


splitter.files = MyComponents/Splitter/Splitter.qml
splitter.path = $$installPath/Splitter

statusbar.files = MyComponents/StatusBar/StatusBar.qml
statusbar.path = $$installPath/StatusBar

tickbox.files = MyComponents/TickBox/TickBox.qml
tickbox.path = $$installPath/TickBox


tickboximage.files = MyComponents/TickBox/Image/tick.png
tickboximage.path = $$installPath/TickBox/Image

view.files = MyComponents/View/ScrollIndicator.qml \
             MyComponents/View/TableHeaderDelegate.qml \
             MyComponents/View/TableItemDelegate.qml \
             MyComponents/View/PivotView.qml \
             MyComponents/View/MyTableView.qml \
             MyComponents/View/ListViewDelegate.qml

view.path = $$installPath/View

informationsection.files = MyComponents/InformationSection/InformationSection.qml
informationsection.path = $$installPath/InformationSection

coverflow.files = MyComponents/View/CoverFlow/CoverFlow.qml \
                MyComponents/View/CoverFlow/CoverFlowDelegate.qml \
                MyComponents/View/CoverFlow/BackViewList.qml \
                MyComponents/View/CoverFlow/BackViewListDelegate.qml
coverflow.path = $$installPath/View/CoverFlow

coverflowimages.files =    MyComponents/View/CoverFlow/Image/floor.jpg \
                          MyComponents/View/CoverFlow/Image/arrow.png
coverflowimages.path = $$installPath/View/CoverFlow/Image

editabledelegates.files =    MyComponents/View/EditableDelegates/EditableCalendarDelegate.qml \
                             MyComponents/View/EditableDelegates/EditableDelegate.qml \
                             MyComponents/View/EditableDelegates/EditableTextFieldDelegate.qml \
                             MyComponents/View/EditableDelegates/EditableText.qml \
                             MyComponents/View/EditableDelegates/EditableDoubleDelegate.qml \
                             MyComponents/View/EditableDelegates/EditableComboBox.qml \
                             MyComponents/View/EditableDelegates/EditableComboBoxDelegate.qml \
                             MyComponents/View/EditableDelegates/ModelEditableComboBox.qml \
                             MyComponents/View/EditableDelegates/ModelEditableText.qml
editabledelegates.path = $$installPath/View/EditableDelegates

images.files =    MyComponents/Image/AIRBUS.png \
                  MyComponents/Image/close.png \
                  MyComponents/Image/filter.png \
                  MyComponents/Image/arrow.png \
                  MyComponents/Image/table.png \
                  MyComponents/Image/open.png \
                  MyComponents/Image/exit.png \
                  MyComponents/Image/menu.png \
                  MyComponents/Image/save.png
images.path = $$installPath/Image

chart.files = MyComponents/Chart/VSqlBarModelMapper.qml \
              MyComponents/Chart/BridgeChart.qml
chart.path = $$installPath/Chart

INSTALLS += target qmldir application busyindicator dialog header popupbox togglebutton mybutton page
INSTALLS += parameterlist parameterlistdelegates tab images sidemenu themes splitter tickbox tickboximage
INSTALLS += view coverflow coverflowimages editabledelegates statusbar informationsection textfield chart

DISTFILES += \
    MyComponents/Page/DatabasePage.qml \
    MyComponents/Image/arrow.png \
    MyComponents/Image/table.png \
    MyComponents/Image/exit.png \
    MyComponents/View/TableHeaderDelegate.qml \
    MyComponents/View/TableItemDelegate.qml \
    MyComponents/MyButton/MyButton.qml \
    MyComponents/Page/DatabaseDelegate.qml \
    MyComponents/View/PivotView.qml \
    MyComponents/Chart/VSqlBarModelMapper.qml \
    MyComponents/Chart/BridgeChart.qml \
    MyComponents/View/ListViewDelegate.qml \
    MyComponents/View/EditableDelegates/EditableComboBox.qml \
    MyComponents/View/EditableDelegates/EditableText.qml \
    MyComponents/View/EditableDelegates/ModelEditableComboBox.qml \
    MyComponents/View/EditableDelegates/ModelEditableText.qml
