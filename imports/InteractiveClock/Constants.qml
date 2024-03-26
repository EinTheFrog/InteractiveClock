pragma Singleton
import QtQuick 6.2
import QtQuick.Studio.Application

QtObject {
    readonly property int width: (clockRadius * 2) + 40
    readonly property int height: (clockRadius * 2) + 40
    readonly property int clockRadius: 200
    readonly property int clockBorderWidth: 20

    property string relativeFontDirectory: "fonts"

    /* Edit this comment to add your custom font */
    readonly property font font: Qt.font({
                                             family: Qt.application.font.family,
                                             pixelSize: Qt.application.font.pixelSize
                                         })
    readonly property font largeFont: Qt.font({
                                                  family: Qt.application.font.family,
                                                  pixelSize: Qt.application.font.pixelSize * 1.6
                                              })

    readonly property color backgroundColor: "#EAEAEA"
    readonly property color clockBackgroundColor: "#FFFFFF"
    readonly property color clockBorderColor: "#000000"


    property StudioApplication application: StudioApplication {
        fontPath: Qt.resolvedUrl("../../content/" + relativeFontDirectory)
    }
}
