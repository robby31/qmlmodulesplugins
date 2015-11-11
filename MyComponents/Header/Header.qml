import QtQuick 2.0

Rectangle {
    id: bar
    property alias logoCompany: logo_company.source
    property alias logoApplication: logo_app.source
    color: theme.headerBackgroundColor

    Image {
        id: logo_company
        height: parent.height/2
        fillMode: Image.PreserveAspectFit
        anchors {left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: height/2}
    }

    Image {
        id: logo_app
        height: parent.height
        fillMode: Image.PreserveAspectFit
        anchors {left: logo_company.right; verticalCenter: parent.verticalCenter; leftMargin: height/2}
    }
}
