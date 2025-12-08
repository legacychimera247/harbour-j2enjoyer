import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Column {
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.paddingLarge

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: Qt.resolvedUrl('../../images/harbour-j2enjoyer.png')
            width: Theme.iconSizeLarge
            height: width
            sourceSize {
                width: width
                height: height
            }
        }

        Item {
            width: parent.width
            height: appWindow.loading ? busyIndicator.height : (numberLabel.height + totalLabel.height)
            Behavior on height { NumberAnimation { duration: 200 } }
            
            BusyIndicator {
                id: busyIndicator
                size: BusyIndicatorSize.Medium
                anchors.horizontalCenter: parent.horizontalCenter
                running: appWindow.loading
            }

            Label {
                id: numberLabel
                opacity: appWindow.loading ? 0 : 1
                Behavior on opacity { FadeAnimator {} }
                width: parent.width
                bottomPadding: Theme.paddingSmall
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeHuge
                fontSizeMode: Text.Fit
                minimumPixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignHCenter
                text: number
            }
            Label {
                id: totalLabel
                opacity: appWindow.loading ? 0 : 1
                Behavior on opacity { FadeAnimator {} }
                anchors.top: numberLabel.bottom
                x: Theme.paddingSmall
                width: parent.width - 2*x
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeMedium
                fontSizeMode: Text.Fit
                minimumPixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("sold out of %n", "after a number of units, e.g. 1500 [in big] <new line> sold out of 2000", total)
            }

            /*ProgressBar {
                id: progressBar
                anchors.top: totalLabel.bottom
                width: parent.width
                minimumValue: 0
                maximumValue: total
                value: number
                valueText: qsTr("%Ln% funded", '', percentage)
            }*/
        }
    }

    CoverActionList {
        enabled: !appWindow.loading
        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: appWindow.update()
        }
    }
}
