import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtQuick.Window 2.15
import Qt.labs.folderlistmodel 2.15
import Qt.labs.settings 1.1
import QtQml.Models 2.15
import Qt.labs.settings 1.0
ApplicationWindow {
    visible: true
    width: 400
    height: 400
    title: qsTr("WeatherApp")
    property string temperature: ""
    property string weatherCondition: ""
    property string humidity: ""
    property string windSpeed: ""
    property string lastCity: ""
    property var cityTranslations: {
            "Москва": "Moscow",
            "Лондон": "London"
        }

    function translateCityName(cityName) {
        return cityTranslations[cityName] ? cityTranslations[cityName] : cityName;
    }
    FolderListModel {
        id: translationsModel
        folder: "translations"
        nameFilters: ["*.qm"]
        onCountChanged: {
            for (var i = 0; i < translationsModel.count; i++) {
                var locale = translationsModel.get(i).name.replace(".qm", "")
                Qt.locale.save(locale, i18n.load(translationsModel.get(i).filePath))
                lastCity = localStorage.getItem("lastCity") || "";
            }
        }
    }
    Settings {
        id: appSettings
        property string lastCitySetting: lastCity
    }
    // При загрузке приложения установить значение последнего просмотренного города из настроек
    Component.onCompleted: {
        lastCity = appSettings.lastCitySetting
    }
    Rectangle {
        id: weatherInfo
        color: "lightblue"
        border.color: "steelblue"
        radius: 10
        anchors.centerIn: parent
        width: 300
        height: 250
        Column {
            anchors.fill: parent
            spacing: 10
            RowLayout {
                spacing: 10
                Image {
                    source: {
                        if (weatherCondition === "few clouds") {
                            return "qrc:/WeatherApp_v1/few_clouds.png";
                        } else if (weatherCondition === "clear sky") {
                            return "qrc:/WeatherApp_v1/clear_sky.png";
                        } else if (weatherCondition === "overcast clouds") {
                            return "qrc:/WeatherApp_v1/overcast_clouds.png";
                        } else if (weatherCondition === "rain") {
                            return "qrc:/WeatherApp_v1/rain.png";
                        } else if (weatherCondition === "shower rain") {
                            return "qrc:/WeatherApp_v1/shower_rain.png";
                        } else if (weatherCondition === "light rain") {
                            return "qrc:/WeatherApp_v1/shower_rain.png";
                        } else if (weatherCondition === "scattered clouds") {
                            return "qrc:/WeatherApp_v1/scattered_clouds.png";
                        } else if (weatherCondition === "snow") {
                            return "qrc:/WeatherApp_v1/snow.png";
                        } else if (weatherCondition === "broken clouds") {
                            return "qrc:/WeatherApp_v1/broken_clouds.png";
                        } else if (weatherCondition === "mist") {
                            return "qrc:/WeatherApp_v1/mist.png";
                        } else {
                            return "qrc:/WeatherApp_v1/defaultImage.png";
                        }
                    }
                    width: 50
                    height: 50
                }
                Text {
                    text: qsTr("Погода в ") + cityName.text
                    font.pixelSize: 16
                }
            }

            Text {
                text: qsTr("Temperature: ") + temperature + "°C"
                font.pixelSize: 14
            }
            Text {
                text: qsTr("Weather: ") + weatherCondition
                font.pixelSize: 14
            }
            Text {
                text: qsTr("Humidity: ") + humidity + "%"
                font.pixelSize: 14
            }
            Text {
                text: qsTr("Wind Speed: ") + windSpeed + " km/h"
                font.pixelSize: 14
            }
        }
    }
    RowLayout {
        anchors.bottom: parent.bottom
        spacing: 10
        TextField {
            id: cityName
            placeholderText: qsTr("Введите город,код_страны")
            Layout.alignment: Qt.AlignLeft
            text: lastCity
            onTextChanged: {
                lastCity = cityName.text;
                appSettings.lastCitySetting = lastCity;
            }
        }
        Button {
            text: qsTr("Обновить погоду")
            Layout.alignment: Qt.AlignRight
            onClicked: {
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            var response = JSON.parse(xhr.responseText);
                            temperature = (response.main.temp - 273.15).toFixed(2);
                            weatherCondition = response.weather[0].description;
                            humidity = response.main.humidity;
                            windSpeed = response.wind.speed;
                        } else {
                            console.error(qsTr("Не удалось найти данные: ") + xhr.statusText);
                        }
                    }
                };
                xhr.open("GET", "https://api.openweathermap.org/data/2.5/weather?q=" + cityName.text + "&APPID=d53591817ca78fc2df369434dc339ac0");
                xhr.send();
            }
        }
}
 }



