cmake_minimum_required(VERSION 3.16)

project(QMLTest VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.8)

# =====================================================
# تنظیمات Android
# =====================================================
if(ANDROID)
    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android" CACHE INTERNAL "")
    set(QT_ANDROID_PACKAGE_NAME "org.verya.QMLTest" CACHE INTERNAL "")
    set(QT_ANDROID_VERSION_NAME "1.0.0" CACHE INTERNAL "")
    set(QT_ANDROID_VERSION_CODE "1" CACHE INTERNAL "")
    set(QT_ANDROID_TARGET_SDK_VERSION "35" CACHE INTERNAL "")
    set(QT_ANDROID_MIN_SDK_VERSION "28" CACHE INTERNAL "")

    set(ANDROID_EXTRA_FILES
        "${CMAKE_CURRENT_SOURCE_DIR}/android/AndroidManifest.xml"
        "${CMAKE_CURRENT_SOURCE_DIR}/android/build.gradle"
        "${CMAKE_CURRENT_SOURCE_DIR}/android/gradle.properties"
        "${CMAKE_CURRENT_SOURCE_DIR}/android/gradlew"
        "${CMAKE_CURRENT_SOURCE_DIR}/android/gradlew.bat"
    )

    message(STATUS "Android build detected")
    message(STATUS "Android package source: ${ANDROID_PACKAGE_SOURCE_DIR}")
    message(STATUS "Android package name: ${QT_ANDROID_PACKAGE_NAME}")
endif()

qt_add_executable(QMLTest
    main.cpp
)

qt_add_qml_module(QMLTest
    URI QMLTest
    QML_FILES
        Main.qml
        QML_FILES TestButton.qml
        SOURCES mybackend.h mybackend.cpp
        SOURCES mylistmodel.h mylistmodel.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(QMLTest PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.QMLTest
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(QMLTest
    PRIVATE Qt6::Quick
)
target_link_libraries(QMLTest PRIVATE Qt6::Core)
target_link_libraries(QMLTest PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS QMLTest
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# =====================================================
# تنظیمات اضافی Android
# =====================================================
if(ANDROID)
    set_property(TARGET QMLTest APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
        ${ANDROID_PACKAGE_SOURCE_DIR}
    )

    if(NOT ANDROID_ABI)
        set(ANDROID_ABI "arm64-v8a")
    endif()

    message(STATUS "Building for Android ABI: ${ANDROID_ABI}")

    add_custom_command(TARGET QMLTest POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E echo "Android files configured in: ${ANDROID_PACKAGE_SOURCE_DIR}"
    )
endif()
