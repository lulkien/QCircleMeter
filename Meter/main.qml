import QtQuick 2.14
import QtQuick.Window 2.14
import QmlCustomItem 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    QCircleMeter
    {
        id: qMeter
        anchors.centerIn: parent
        width: 200
        height: 200
        data: 0

        Behavior on data
        {
            NumberAnimation
            {
                duration: 250
                alwaysRunToEnd: true
                onStopped: rec.isHovered = false
            }
        }
    }

    Text {
        id: name

        anchors.centerIn: qMeter
        font.pixelSize: 25
        font.bold: true

        text: ((qMeter.data < 10) ? (" " + qMeter.data) : qMeter.data) + "%"
    }


    Rectangle
    {
        id: rec
        property bool isHovered: false
        width: 100
        height: 100
        color: isHovered ? "blue" : "red"

        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onEntered:
            {
                qMeter.data += 5
                parent.isHovered = true
            }
            onExited:
            {
                qMeter.data -= 5
                parent.isHovered = false
            }
            onClicked:
            {
                qMeter.data += 50
            }
        }
    }

}
