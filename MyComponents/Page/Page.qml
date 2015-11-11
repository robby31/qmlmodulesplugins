import QtQuick 2.0
import MyComponents 1.0

Item {
    id: page
    property alias actions: sideMenu.actions
    signal actionClicked(string name);
    function toggleMenu() {if (isMenuVisible()) hideMenu(); else showMenu();}
    function showMenu() {sideMenu.show()}
    function hideMenu() {sideMenu.hide()}
    function isMenuVisible() {return (sideMenu.state=="VISIBLE") ? true : false}
    width: 1000
    height: 600

    SideMenu {
        id: sideMenu
        anchors.fill: parent
        z: 1000
        actions: actions
        onActionClicked: {page.actionClicked(name)}
    }
}
