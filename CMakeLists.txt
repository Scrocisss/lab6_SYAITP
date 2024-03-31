cmake_minimum_required(VERSION 3.16)
project(WeatherApp_v1 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appWeatherApp_v1
    main.cpp
)

qt_add_qml_module(appWeatherApp_v1
    URI WeatherApp_v1
    VERSION 1.0
    QML_FILES Main.qml
    QML_FILES WeatherAPI.js
    QML_FILES
    QML_FILES WeatherCard.qml
    RESOURCES broken_clouds.png clear_sky.png defaultImage.png few_clouds.png mist.png overcast_clouds.png rain.png scattered_clouds.png shower_rain.png snow.png thunderstorm.png




)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appWeatherApp_v1 PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appWeatherApp_v1
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appWeatherApp_v1
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appWeatherApp_v1
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
