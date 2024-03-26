import QtQuick 6.2
import InteractiveClock

Item {  
    property int hours: 0;
    property int minutes: 0;
    property bool am: true;

    Rectangle {
        id: container

        x: -time_metrics.boundingRect.width / 2
        y: 10

        width: time_metrics.boundingRect.width + 4
        height: time_metrics.boundingRect.height + 4
        radius: 4
        color: Constants.clockBackgroundColor
        opacity: 0.8

        Text {
            id: time_text

            text: hours + ":" + (minutes < 10 ? "0" + minutes : minutes)
            color: Constants.clockBorderColor
            font.family: "Helvetica"
            font.pointSize: 14
        }

        Text {
            id: am_text

            x: (time_metrics.boundingRect.width - am_metrics.boundingRect.width) / 2
            y: time_metrics.boundingRect.height

            text: am ? "am" : "pm"
            color: Constants.clockBorderColor
            font.family: "Helvetica"
            font.pointSize: 14
        }
    }

    TextMetrics {
        id:     time_metrics
        font:   time_text.font
        text:   time_text.text
    }
    TextMetrics {
        id:     am_metrics
        font:   am_text.font
        text:   am_text.text
    }
}
