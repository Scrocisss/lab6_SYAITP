import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    property string city
    property int temperature
    property string weatherState
    property int humidity
    property int windSpeed

    ColumnLayout {
        Text {
            text: city
        }

        Text {
            text: "Temperature: " + temperature
        }

        Text {
            text: "Weather: " + weatherState
        }

        Text {
            text: "Humidity: " + humidity
        }

        Text {
            text: "Wind speed: " + windSpeed
        }
    }
}
