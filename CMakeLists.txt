cmake_minimum_required(VERSION 3.16)

project(DataHubRK VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 1. ВАЖНО: Добавлено Quick3D в список компонентов
find_package(Qt6 6.2 REQUIRED COMPONENTS Quick Quick3D)

qt_standard_project_setup()

qt_add_executable(appDataHubRK
    main.cpp
    backend.h
    backend.cpp
    CompareUniCard.qml
    LoginPopup.qml
    SignupPopup.qml
    InfoBox.qml
    ProfilePopup.qml
    FavPopup.qml
    CompareTable.qml
)

qt_add_qml_module(appDataHubRK
    URI Main
    VERSION 1.0
    QML_FILES
        Main.qml
        InfoBox.qml
        CompareUniCard.qml
        LoginPopup.qml
        SignupPopup.qml
        ProfilePopup.qml
        FavPopup.qml
        CompareTable.qml
)

# 2. ВАЖНО: Связываем проект с библиотекой 3D
target_link_libraries(appDataHubRK
    PRIVATE Qt6::Quick Qt6::Quick3D
)
