import QtQuick 2.14
import QtQuick.Window 2.14
import QmlCustomItem 1.0

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property int rootdata: 0
    onRootdataChanged:
    {
        if (rootdata > 100) rootdata = 100
        if (rootdata < 0) rootdata = 0
    }

    QSensorClock
    {
        id: clock
        anchors.centerIn: parent
        dataUpdate: root.rootdata
        updateInterval: 2
        thickness: 25
        textSize: 20
    }


    Row
    {
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }
        spacing: 2
        Repeater
        {
            model: [5, 20, 45, 80]
            delegate: QRec
            {
                idata: modelData
                onClicked: root.rootdata += modelData
            }
        }
    }

    Row
    {
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
        }
        spacing: 2
        Repeater
        {
            model: [-5, -20, -45, -80]
            delegate: QRec
            {
                idata: modelData
                onClicked: root.rootdata += modelData
            }
        }
    }

    QRec
    {
        width: 100
        height: 100
        anchors
        {
            verticalCenter: root.verticalCenter
            right: root.right
        }

        idata: root.rootdata
    }

}
