lessThan(QT_MAJOR_VERSION, 5) {
    error("Qt 4 is no longer supported. In order to compile Qt Bitcoin Trader you need update to Qt5 http://qt.io/download-open-source/ or use pre-compiled binaries https://sourceforge.net/projects/bitcointrader/files/");
}

lessThan(QT_MAJOR_VERSION, 6) {
    lessThan(QT_MINOR_VERSION, 9) {
        error("Qt $${QT_VERSION} is no longer supported. In order to compile Qt Bitcoin Trader you need update at least to Qt 5.9 http://qt.io/download-open-source/ or use pre-compiled binaries https://sourceforge.net/projects/bitcointrader/files/");
    }
}

TARGET      = QtBitcoinTrader

TEMPLATE    = app
LANGUAGE    = C++
DEPENDPATH += .
INCLUDEPAT += .

QT += network script widgets texttospeech

unix:!macx { QT += multimedia }
macx       { QT += multimedia }

LIBS    += -lssl -lcrypto -lz
DEFINES += QTBUILDTARGETLINUX64

linux {
    contains(QMAKE_TARGET.arch, x86_64) {
        DEFINES += QTBUILDTARGETLINUX64
    }
}

win32 {
    LIBS    += -lgdi32 -lws2_32 -lole32 -lwinmm

    contains(QMAKE_TARGET.arch, x86_64) {
        DEFINES += QTBUILDTARGETWIN64
    }

    DEFINES += SAPI_ENABLED
    checkFRAMEWORKDIR=$$(FRAMEWORKDIR)
    isEmpty(checkFRAMEWORKDIR) {
        LIBS += -lsapi
    }
}

macx {
    LIBS += -dead_strip
    LIBS += -framework CoreFoundation
    LIBS += -framework ApplicationServices
}

CONFIG(static) {
linux: 
    QTPLUGIN.platforms+=qvnc qxcb
    QTPLUGIN.mediaservice=-
    QTPLUGIN.playlistformats=-
    QTPLUGIN.position=-
    QTPLUGIN.printsupport=-
    QTPLUGIN.bearer=-
    QTPLUGIN.accessible=-
    QTPLUGIN.sensors=-
    QTPLUGIN.sqldrivers=-
    QTPLUGIN.qmltooling=-
    QTPLUGIN.designer=-
    QTPLUGIN.iconengines=-
    QTPLUGIN.imageformats=-
    QTPLUGIN.geoservices=-
    QTPLUGIN.position=-
    QTPLUGIN.qmltooling=-
    QTPLUGIN.sensorgestures=-
}

#
# Headers
#
HEADERS +=                  \
    $${PWD}/tabbedwins/*.h  \
    \
    $${PWD}/charts/*.h      \
    $${PWD}/components/*.h  \
    $${PWD}/config/*.h      \
    $${PWD}/dock/*.h        \
    $${PWD}/exchange/*.h    \
    $${PWD}/july/*.h        \
    $${PWD}/login/*.h       \
    $${PWD}/menu/*.h        \
    $${PWD}/platform/*.h    \
    $${PWD}/script/*.h      \
    $${PWD}/settings/*.h    \
    $${PWD}/sysadmutils/*.h \
    $${PWD}/systranslate/*.h\
    $${PWD}/trademodels/*.h \
    $${PWD}/utils/*.h       \
    $${PWD}/*.h              \
    tabbedwins/tabwidget.h
#   $${PWD}/news/*.h        \


FORMS   +=                   \
    $${PWD}/tabbedwins/*.ui  \
    \
    $${PWD}/charts/*.ui      \
    $${PWD}/components/*.ui  \
    $${PWD}/config/*.ui      \
    $${PWD}/login/*.ui       \
    $${PWD}/menu/*.ui        \
    $${PWD}/script/*.ui      \
    $${PWD}/settings/*.ui    \
    $${PWD}/sysadmutils/*.ui \
    $${PWD}/systranslate/*.ui\
    $${PWD}/*.ui             \
    tabbedwins/tabwidget.ui
#   $${PWD}/news/*.ui        \

SOURCES +=                    \
    $${PWD}/tabbedwins/*.cpp  \
    \
    $${PWD}/charts/*.cpp      \
    $${PWD}/components/*.cpp  \
    $${PWD}/config/*.cpp      \
    $${PWD}/dock/*.cpp        \
    $${PWD}/exchange/*.cpp    \
    $${PWD}/july/*.cpp        \
    $${PWD}/login/*.cpp       \
    $${PWD}/menu/*.cpp        \
    $${PWD}/platform/*.cpp    \
    $${PWD}/script/*.cpp      \
    $${PWD}/settings/*.cpp    \
    $${PWD}/sysadmutils/*.cpp \
    $${PWD}/systranslate/*.cpp\
    $${PWD}/trademodels/*.cpp \
    $${PWD}/utils/*.cpp       \
    $${PWD}/*.cpp              \
    tabbedwins/tabwidget.cpp
#   $${PWD}/news/*.cpp        \

#
# Resources
# 
RESOURCES += $${PWD}/QtResource.qrc

#
# Platform dependent stuff
#
unix:!macx {
    UI_DIR = .ui
    MOC_DIR = .moc
    OBJECTS_DIR = .obj
    isEmpty( PREFIX ) {
        PREFIX=/usr
    }
    isEmpty( DESKTOPDIR ) {
        DESKTOPDIR=/usr/share/applications
    }
    isEmpty( ICONDIR ) {
        ICONDIR=/usr/share/pixmaps
    }

    target.path = $${PREFIX}/bin

    INSTALLS = target

    desktop.path = $${DESKTOPDIR}

    desktop.files = QtBitcoinTrader.desktop
    INSTALLS += desktop

    icon.path = $${ICONDIR}

    icon.files = QtBitcoinTrader.png
    INSTALLS += icon
}
################################
win32:RC_FILE = $${PWD}/WinResource.rc

macx:ICON = $${PWD}/QtBitcoinTrader.icns
macx:QMAKE_INFO_PLIST = $${PWD}/QtBitcoinTrader.plist
