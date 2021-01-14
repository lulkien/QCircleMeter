import QtQuick 2.0

Rectangle
{
    id: root
    width: 100
    height: 100

    property int idata: 0

    signal clicked()

    border.color: "black"

    Text {
        id: name
        anchors.centerIn: parent
        text: root.idata
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
