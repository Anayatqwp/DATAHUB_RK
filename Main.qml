import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick3D

Window {
    id: appWindow
    width: 1280
    height: 800
    visible: true
    title: uiStrings.app_title
    color: "#121212"

    // --- СТИЛИ ---
    property color cBlack: "#121212"
    property color cDarkGray: "#1E1E1E"
    property color cYellow: "#FFD700"

    // --- СОСТОЯНИЕ ---
    property int currentUniIndex: 0
    property int currentTabId: 0
    property bool isCurrentFav: false
    property bool isLoggedIn: false

    // --- ЛОКАЛИЗАЦИЯ ---
    property string currentLanguage: "ru"
    property var uiStrings: backend.getUiStrings(currentLanguage)

    // --- МОДЕЛИ ---
    ListModel {
        id: chatModel
        Component.onCompleted: chatModel.append({
            msg: backend.getAIWelcomeMessage(currentLanguage),
            isUser: false
        })
    }
    ListModel { id: favListModel }

    ListModel {
        id: menuItems
        ListElement { mId: 1; icon: "🏛️"; key: "menu_about" }
        ListElement { mId: 2; icon: "📚"; key: "menu_progs" }
        ListElement { mId: 3; icon: "🎓"; key: "menu_adm" }
        ListElement { mId: 8; icon: "⚖️"; key: "menu_compare" }
        ListElement { mId: 4; icon: "🧊"; key: "menu_3d" }
        ListElement { mId: 5; icon: "🌍"; key: "menu_partner" }
        ListElement { mId: 7; icon: "📊"; key: "menu_stats" }
        ListElement { mId: 9; icon: "🔥"; key: "menu_popular" }
    }

    function checkFavoriteStatus() {
        if (typeof backend !== "undefined") isCurrentFav = backend.isFavorite(currentUniIndex)
    }
    Component.onCompleted: {
        checkFavoriteStatus()
        isLoggedIn = backend.isUserLoggedIn()
    }

    // --- ТАЙМЕР ИИ ---
    Timer {
        id: aiTimer
        interval: 60000
        running: true
        repeat: false
        onTriggered: {
            if (chatDrawer.x === appWindow.width) {
                chatDrawer.x = appWindow.width - chatDrawer.width
                chatModel.append({msg: uiStrings.ai_promo, isUser: false})
            }
        }
    }

    // ==========================================
    // ВЕРХНЯЯ ПАНЕЛЬ
    // ==========================================
    Rectangle {
        id: topBar
        width: parent.width; height: 80; color: cDarkGray; z: 50
        RowLayout {
            anchors.fill: parent; anchors.margins: 20; spacing: 20

            Button {
                text: "☰"; Layout.preferredWidth: 50; Layout.preferredHeight: 50
                background: Rectangle { color: "transparent"; border.color: cYellow; radius: 8 }
                contentItem: Text { text: parent.text; color: cYellow; font.pixelSize: 30; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                onClicked: leftDrawer.x = 0
            }

            Text {
                text: "DATAHUB RK"; color: cYellow; font.pointSize: 22; font.bold: true; font.family: "Impact"
                Rectangle { width: parent.width; height: 3; color: cYellow; anchors.bottom: parent.bottom; anchors.bottomMargin: -5 }
            }

            RowLayout {
                spacing: 5
                Text { text: "RU"; color: currentLanguage === "ru" ? cYellow : "gray"; font.bold: true; MouseArea { anchors.fill: parent; onClicked: currentLanguage = "ru" } }
                Text { text: "EN"; color: currentLanguage === "en" ? cYellow : "gray"; font.bold: true; MouseArea { anchors.fill: parent; onClicked: currentLanguage = "en" } }
                Text { text: "KZ"; color: currentLanguage === "kz" ? cYellow : "gray"; font.bold: true; MouseArea { anchors.fill: parent; onClicked: currentLanguage = "kz" } }
            }

            Item { Layout.fillWidth: true }

            Button {
                Layout.preferredWidth: 50; Layout.preferredHeight: 50
                text: isCurrentFav ? "⭐" : "☆"
                background: Rectangle { color: "transparent"; border.color: isCurrentFav ? cYellow : "gray"; radius: 8 }
                contentItem: Text { text: parent.text; color: isCurrentFav ? cYellow : "gray"; font.pixelSize: 32; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                onClicked: { backend.toggleFavorite(currentUniIndex); checkFavoriteStatus() }
            }

            ComboBox {
                id: uniSelector; Layout.preferredWidth: 350; Layout.preferredHeight: 50
                model: backend.getUniversityNames(); currentIndex: 0
                onCurrentIndexChanged: {
                    currentUniIndex = currentIndex; checkFavoriteStatus()
                    if (mainStack.currentIndex === 1 && currentTabId > 0) {
                        var details = backend.getUniversityDetails(currentUniIndex)
                        var tabKey = menuItems.get(currentTabId > 0 ? currentTabId - 1 : 0).key
                        infoPage.sectionTitle = uiStrings[tabKey] ? uiStrings[tabKey] : "Info"
                        infoPage.sectionText = backend.getInfo(currentUniIndex, currentTabId)
                        infoPage.uniWebsite = details.website; infoPage.uniDetails = details
                    } else if (mainStack.currentIndex === 3) comparePage.updateUni(0, currentUniIndex)
                }
                contentItem: Text { leftPadding: 15; text: uniSelector.displayText; font.pixelSize: 18; font.bold: true; color: cYellow; verticalAlignment: Text.AlignVCenter }
                background: Rectangle { color: uniSelector.pressed ? "#2A2A2A" : "transparent"; border.color: cYellow; border.width: 2; radius: 8 }
                popup: Popup { y: uniSelector.height - 1; width: uniSelector.width; implicitHeight: contentItem.implicitHeight; padding: 1; contentItem: ListView { clip: true; implicitHeight: contentHeight; model: uniSelector.popup.visible ? uniSelector.delegateModel : null; currentIndex: uniSelector.highlightedIndex; ScrollIndicator.vertical: ScrollIndicator { } } background: Rectangle { color: "#1E1E1E"; border.color: cYellow; radius: 8 } }
                delegate: ItemDelegate { width: uniSelector.width; height: 50; contentItem: Text { text: modelData; color: hovered ? "black" : "white"; font.pixelSize: 16; font.bold: true; verticalAlignment: Text.AlignVCenter; leftPadding: 15 } background: Rectangle { color: hovered ? cYellow : "transparent"; radius: 4 } }
            }
        }
    }

    // ==========================================
    // ЛЕВОЕ МЕНЮ
    // ==========================================
    Rectangle {
        id: leftDrawer
        width: 320; height: parent.height; color: "#181818"; x: -width; z: 101
        Behavior on x { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
        Rectangle { width: 5; height: parent.height; anchors.left: parent.right; color: "black"; opacity: 0.3 }

        ColumnLayout {
            anchors.fill: parent; anchors.margins: 20; spacing: 20

            RowLayout {
                Text { text: uiStrings.drawer_lk; color: cYellow; font.bold: true; font.pointSize: 18; Layout.fillWidth: true }
                Button { text: "✕"; background: null; contentItem: Text { text: parent.text; color: "gray"; font.pixelSize: 20 } onClicked: leftDrawer.x = -leftDrawer.width }
            }
            Rectangle { Layout.fillWidth: true; height: 1; color: "#333" }

            ColumnLayout {
                Layout.fillWidth: true; spacing: 10

                // УБРАЛ ТУТ ПРИВЕТСТВИЕ, ОНО БУДЕТ НИЖЕ С ИКОНКОЙ

                // КНОПКИ ВХОДА (Если не вошел)
                RowLayout {
                    visible: !isLoggedIn
                    Layout.fillWidth: true; Layout.alignment: Qt.AlignHCenter; spacing: 15
                    Button {
                        text: uiStrings.btn_login
                        background: Rectangle { color: cYellow; radius: 5 }
                        contentItem: Text { text: parent.text; color: "black"; font.bold: true }
                        onClicked: loginPopup.open()
                    }
                    Button {
                        text: uiStrings.btn_signup
                        background: Rectangle { color: "transparent"; border.color: cYellow; radius: 5 }
                        contentItem: Text { text: parent.text; color: cYellow; font.bold: true }
                        onClicked: signupPopup.open()
                    }
                }

                // КНОПКА ВЫХОДА (Если вошел)
                Button {
                    visible: isLoggedIn
                    text: uiStrings.btn_logout
                    Layout.alignment: Qt.AlignHCenter
                    background: Rectangle { color: "#333"; border.color: "red"; radius: 5 }
                    contentItem: Text { text: parent.text; color: "red"; font.bold: true }
                    onClicked: { backend.logout(); isLoggedIn = false; drawerName.text = uiStrings.guest_name }
                }
            }

            Rectangle { width: 100; height: 100; radius: 50; color: "#333"; border.color: cYellow; border.width: 2; anchors.horizontalCenter: parent.horizontalCenter; Text { text: "👤"; font.pointSize: 40; anchors.centerIn: parent } }

            // ИМЯ ПОЛЬЗОВАТЕЛЯ ТЕПЕРЬ ТУТ
            Text { id: drawerName; text: backend.getUserProfile().name === "" ? uiStrings.guest_name : backend.getUserProfile().name; color: "white"; font.pointSize: 16; font.bold: true; anchors.horizontalCenter: parent.horizontalCenter }

            ListView {
                Layout.fillWidth: true; Layout.fillHeight: true
                model: ListModel {
                    ListElement { key: "lbl_profile"; icon: "⚙️"; type: "profile" }
                    ListElement { key: "lbl_fav"; icon: "⭐"; type: "wishlist" }
                    ListElement { key: "lbl_news"; icon: "📢"; type: "news" }
                    ListElement { key: "lbl_comp"; icon: "⚖️"; type: "compare" }
                    ListElement { key: "lbl_top"; icon: "🔥"; type: "topunis" }
                }
                delegate: Item {
                    width: parent.width; height: 80
                    RowLayout {
                        anchors.fill: parent; spacing: 15
                        Rectangle { width: 60; height: 60; radius: 30; color: itemMouse.containsMouse ? cYellow : "#333"; border.color: cYellow; border.width: 1; Text { text: icon; font.pointSize: 24; anchors.centerIn: parent } }
                        Text { text: uiStrings[key]; color: itemMouse.containsMouse ? cYellow : "white"; font.pointSize: 16; font.bold: true; Layout.fillWidth: true }
                    }
                    MouseArea {
                        id: itemMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            leftDrawer.x = -leftDrawer.width
                            if (type === "news") newsPopup.open()
                            else if (type === "wishlist") { favListModel.clear(); var favs = backend.getFavorites(); for(var i=0; i<favs.length; i++) favListModel.append({uniName: favs[i]}); favPopup.open() }
                            else if (type === "profile") { var p = backend.getUserProfile(); pSurname.text = p.surname; pName.text = p.name; pPatr.text = p.patronymic; pDate.text = p.birthDate; pIIN.text = p.iin; pPhone.text = p.phone; pCity.text = p.city; pScore.text = p.entScore; profilePopup.open() }
                            else if (type === "compare") mainStack.currentIndex = 3
                            else if (type === "topunis") topUnisPopup.open()
                        }
                    }
                }
            }
        }
    }

    // ==========================================
    // POPUPS
    // ==========================================

    LoginPopup {
        id: loginPopup

        backend: backend
        uiStrings: appWindow.uiStrings
        cYellow: appWindow.cYellow
        onLoginSuccess: {
            isLoggedIn = true
            leftDrawer.x = -leftDrawer.width
        }
    }

    SignupPopup {
        id: signupPopup
        backend: backend
        uiStrings: appWindow.uiStrings
        cYellow: appWindow.cYellow
        onSignupSuccess: {
            isLoggedIn = true
            leftDrawer.x = -leftDrawer.width
        }
    }

    // ... (Profile, Fav, News Popups - оставь как есть или скопируй из прошлого кода, если нужно) ...
    // ВНИМАНИЕ: Для краткости я не дублировал Profile/Fav/News, так как они не менялись.
    // Если ты стер их в прошлый раз, верни код для них из предыдущего ответа.
    // Я продублирую только измененный TopUnisPopup.

    Popup {
        id: topUnisPopup; anchors.centerIn: parent; width: 500; height: 500; modal: true; focus: true; closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        background: Rectangle { color: "#121212"; border.color: cYellow; border.width: 2; radius: 10 }
        ColumnLayout {
            anchors.fill: parent; anchors.margins: 25; spacing: 20
            Text { text: "🔥 " + uiStrings.lbl_top; color: cYellow; font.pointSize: 24; font.bold: true; Layout.alignment: Qt.AlignHCenter }
            ListView {
                Layout.fillWidth: true; Layout.fillHeight: true; clip: true
                // РАСШИРЕННЫЙ СПИСОК ВУЗОВ
                model: ListModel {
                    ListElement { rank: 1; uniName: "КазНУ (KazNU)"; reason: "Лидер рейтинга QS WUR" }
                    ListElement { rank: 2; uniName: "КБТУ (KBTU)"; reason: "Лучший IT и Нефтегаз" }
                    ListElement { rank: 3; uniName: "Satbayev Univ."; reason: "Главный технический вуз" }
                    ListElement { rank: 4; uniName: "ЕНУ (ENU)"; reason: "Вуз в столице, связи" }
                    ListElement { rank: 5; uniName: "КазНМУ (Med)"; reason: "Медицина №1" }
                    ListElement { rank: 6; uniName: "SDU / IITU"; reason: "Сильные IT школы" }
                }
                delegate: Rectangle {
                    width: parent.width; height: 50; color: "transparent"
                    RowLayout {
                        anchors.fill: parent
                        Text { text: "#" + model.rank; color: cYellow; font.bold: true; font.pointSize: 18; Layout.preferredWidth: 40 }
                        ColumnLayout {
                            Text { text: model.uniName; color: "white"; font.bold: true; font.pointSize: 16 }
                            Text { text: model.reason; color: "gray"; font.pointSize: 12 }
                        }
                    }
                }
            }
            Button { text: "ЗАКРЫТЬ"; Layout.alignment: Qt.AlignHCenter; background: Rectangle { color: cYellow; radius: 5 } contentItem: Text { text: parent.text; color: "black"; font.bold: true } onClicked: topUnisPopup.close() }
        }
    }

    // НЕ ЗАБУДЬ ВСТАВИТЬ СЮДА POPUPS ДЛЯ PROFILE, FAV, NEWS ИЗ ПРЕДЫДУЩЕГО ОТВЕТА, ЕСЛИ ОНИ ПРОПАЛИ.
    // Если они у тебя есть - отлично.
    ProfilePopup {
            id: profilePopup
            backend: appWindow.backend
            uiStrings: appWindow.uiStrings
            cYellow: appWindow.cYellow
            // Алиасы (surnameText и т.д.) уже настроены внутри ProfilePopup
        }

        // 2. Попап Избранного
        FavPopup {
            id: favPopup
            uiStrings: appWindow.uiStrings
            cYellow: appWindow.cYellow
            favModel: favListModel // Ссылка на ListModel, который объявлен выше в Main.qml
        }

        // 3. Попап Новостей (Простой, чтобы кнопка работала)
        Popup {
            id: newsPopup
            anchors.centerIn: parent
            width: 500; height: 400
            modal: true; focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
            background: Rectangle { color: "#181818"; border.color: cYellow; radius: 10 }
            ColumnLayout {
                anchors.fill: parent; anchors.margins: 20
                Text { text: "📢 " + uiStrings.lbl_news; color: cYellow; font.pointSize: 22; font.bold: true; Layout.alignment: Qt.AlignHCenter }
                ListView {
                    Layout.fillWidth: true; Layout.fillHeight: true; clip: true
                    model: backend.getNews() // Берем новости из C++
                    delegate: ColumnLayout {
                        width: parent.width; spacing: 5
                        Text { text: modelData.date + " | " + modelData.title; color: cYellow; font.bold: true; font.pointSize: 16 }
                        Text { text: modelData.text; color: "white"; wrapMode: Text.WordWrap; Layout.fillWidth: true }
                        Rectangle { Layout.fillWidth: true; height: 1; color: "#333"; Layout.topMargin: 10; Layout.bottomMargin: 10 }
                    }
                }
            }
        }

    // ==========================================
    // ОСНОВНОЙ КОНТЕНТ
    // ==========================================
    Rectangle { anchors.fill: parent; color: "black"; z: 100; opacity: (leftDrawer.x === 0 || chatDrawer.x < parent.width) ? 0.5 : 0.0; visible: opacity > 0; MouseArea { anchors.fill: parent; onClicked: { leftDrawer.x = -leftDrawer.width; chatDrawer.x = parent.width } } Behavior on opacity { NumberAnimation { duration: 200 } } }

    StackLayout {
        id: mainStack; anchors.fill: parent; anchors.topMargin: 80; currentIndex: 0

        // [0] МЕНЮ
        Item {
            GridLayout {
                anchors.centerIn: parent; columns: 3; rowSpacing: 30; columnSpacing: 30
                Repeater {
                    model: menuItems
                    delegate: Rectangle {
                        width: 350; height: 220; color: cDarkGray; border.color: ma.containsMouse ? cYellow : "#333"; border.width: ma.containsMouse ? 3 : 1; radius: 12
                        MouseArea {
                            id: ma; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                currentTabId = mId
                                if (mId === 4) mainStack.currentIndex = 2
                                else if (mId === 8) { mainStack.currentIndex = 3; comparePage.updateUni(0, uniSelector.currentIndex) }
                                else if (mId === 9) topUnisPopup.open()
                                else {
                                    infoPage.sectionTitle = uiStrings[key]; var details = backend.getUniversityDetails(currentUniIndex); infoPage.sectionText = backend.getInfo(currentUniIndex, mId); infoPage.uniWebsite = details.website; infoPage.uniDetails = details; mainStack.currentIndex = 1
                                }
                            }
                        }
                        scale: ma.containsMouse ? 1.05 : 1.0; Behavior on scale { NumberAnimation { duration: 200; easing.type: Easing.OutBack } }
                        Column {
                            anchors.centerIn: parent; spacing: 10
                            Text { text: icon; font.pointSize: 42; anchors.horizontalCenter: parent.horizontalCenter }
                            Text { text: uiStrings[key]; color: ma.containsMouse ? cYellow : "white"; font.bold: true; font.pointSize: 18 }
                        }
                    }
                }
            }
        }

        // [1] ИНФО (Без изменений)
        Item {
            id: infoPage
            property string sectionTitle: ""; property string sectionText: ""; property string uniWebsite: ""; property var uniDetails: backend.getUniversityDetails(currentUniIndex)
            Button {
                text: "← " + uiStrings.app_title; anchors.left: parent.left; anchors.top: parent.top; anchors.margins: 30; background: Rectangle { color: "transparent"; border.color: cYellow; radius: 4 }
                contentItem: Text { text: parent.text; color: cYellow; font.bold: true } onClicked: { mainStack.currentIndex = 0; currentTabId = 0 }
            }
            ColumnLayout {
                anchors.centerIn: parent; width: 900; spacing: 15
                Text { text: backend.getUniversityNames()[currentUniIndex]; color: "gray"; font.pointSize: 16; Layout.alignment: Qt.AlignHCenter }
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter; spacing: 30
                    Text { text: "📍 " + uniDetails.city; color: "white"; font.pointSize: 14 }
                    Text { text: "💯 " + uniDetails.avgPassScore; color: "white"; font.pointSize: 14 }
                }
                Text { text: infoPage.sectionTitle; color: cYellow; font.pointSize: 36; font.bold: true; Layout.alignment: Qt.AlignHCenter }
                Rectangle {
                    Layout.alignment: Qt.AlignHCenter; width: 350; height: 50; radius: 25; color: "#0088CC"
                    MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: Qt.openUrlExternally(infoPage.uniWebsite) }
                    Text { text: "🔗 Site"; color: "white"; font.pointSize: 14; font.bold: true; anchors.centerIn: parent }
                }
                ScrollView { Layout.fillWidth: true; Layout.preferredHeight: 400; clip: true; TextArea { text: infoPage.sectionText; color: "white"; font.pointSize: 18; wrapMode: Text.WordWrap; width: parent.width; readOnly: true; background: null } }
            }
        }

        // [2] 3D ТУР
        Item {
             Node { id: sceneNode; Model { source: "#Cube"; materials: [ DefaultMaterial { diffuseColor: "red" } ] eulerRotation.y: 0; NumberAnimation on eulerRotation.y { from: 0; to: 360; duration: 5000; loops: Animation.Infinite } } }
             PerspectiveCamera { z: 200 } DirectionalLight { eulerRotation.x: -30 }
             Text { text: uiStrings.menu_3d; color: "white"; anchors.centerIn: parent; font.pointSize: 30 }
             Button { text: "← BACK"; anchors.top: parent.top; anchors.left: parent.left; onClicked: mainStack.currentIndex = 0 }
        }

        // [3] СРАВНЕНИЕ (Здесь используются наши новые карты)
        // [3] СРАВНЕНИЕ
                Item {
                    id: comparePage
                    property int uniIndex1: uniSelector.currentIndex
                    property int uniIndex2: 1
                    property bool isTableMode: false // <-- ПЕРЕКЛЮЧАТЕЛЬ РЕЖИМА

                    function updateUni(i, n) {
                        if(i===0) uniIndex1=n
                        else if(i===1) uniIndex2=n
                    }

                    // Верхняя панель
                    RowLayout {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 60
                        z: 10

                        Button {
                            text: "←";
                            background: Rectangle { color: cYellow; radius: 4 }
                            onClicked: mainStack.currentIndex = 0
                        }

                        Item { Layout.fillWidth: true }

                        Text {
                            text: comparePage.isTableMode ? "ВСЕ ВУЗЫ (6 критериев)" : uiStrings.menu_compare
                            color: cYellow
                            font.pointSize: 24
                            font.bold: true
                        }

                        Item { Layout.fillWidth: true }

                        // КНОПКА ПЕРЕКЛЮЧЕНИЯ
                        Button {
                            text: comparePage.isTableMode ? "🆚 КАРТОЧКИ" : "📋 ТАБЛИЦА"
                            background: Rectangle { color: "#333"; border.color: cYellow; radius: 4 }
                            contentItem: Text { text: parent.text; color: cYellow; font.bold: true }
                            onClicked: comparePage.isTableMode = !comparePage.isTableMode
                        }
                    }

                    // КОНТЕНТ (Меняется в зависимости от режима)
                    Item {
                        anchors.top: parent.top
                        anchors.topMargin: 70
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right

                        // 1. Режим карточек (Старый)
                        RowLayout {
                            anchors.centerIn: parent
                            spacing: 40
                            visible: !comparePage.isTableMode // Скрываем, если включена таблица

                            CompareUniCard {
                                id: compareUni1
                                uniIndex: comparePage.uniIndex1
                                onUniIndexChanged: comparePage.uniIndex1 = uniIndex
                                backend: appWindow.backend
                                cYellow: appWindow.cYellow
                                allUnis: appWindow.backend.getUniversityNames()
                            }

                            CompareUniCard {
                                id: compareUni2
                                uniIndex: comparePage.uniIndex2
                                onUniIndexChanged: comparePage.uniIndex2 = uniIndex
                                backend: appWindow.backend
                                cYellow: appWindow.cYellow
                                allUnis: appWindow.backend.getUniversityNames()
                            }
                        }

                        // 2. Режим таблицы (Новый)
                        CompareTable {
                            anchors.fill: parent
                            anchors.margins: 20
                            visible: comparePage.isTableMode // Виден только в режиме таблицы
                            backend: appWindow.backend
                            cYellow: appWindow.cYellow
                        }
                    }
                }
    // ==========================================
    // ЧАТ (AI)
    // ==========================================
    Rectangle { width: 60; height: 60; radius: 30; color: cYellow; anchors.right: parent.right; anchors.bottom: parent.bottom; anchors.margins: 30; z: 100; Text { text: "🤖"; font.pointSize: 24; anchors.centerIn: parent } MouseArea { anchors.fill: parent; onClicked: { chatDrawer.x = (chatDrawer.x===parent.width)?parent.width-chatDrawer.width:parent.width; aiTimer.stop() } } }
    Rectangle {
        id: chatDrawer; width: 400; height: parent.height; color: "#1a1a1a"; x: parent.width; z: 101; Behavior on x { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
        ColumnLayout {
            anchors.fill: parent; anchors.margins: 20
            RowLayout { Text { text: "AI BOT"; color: cYellow; font.bold: true; font.pointSize: 18; Layout.fillWidth: true } Button { text: "✖"; background: null; onClicked: chatDrawer.x = parent.width } }
            ListView {
                id: chatList; Layout.fillWidth: true; Layout.fillHeight: true; clip: true; model: chatModel; spacing: 10;
                delegate: Rectangle { width: Math.min(msgTxt.implicitWidth+20, 300); height: msgTxt.implicitHeight+20; color: isUser?"#333":cYellow; radius: 8; anchors.right: isUser?parent.right:undefined; Text { id: msgTxt; text: msg; color: isUser?"white":"black"; anchors.centerIn: parent; width: parent.width-20; wrapMode: Text.WordWrap } }
            }
            RowLayout { TextField { id: chatInput; Layout.fillWidth: true; placeholderText: "..."; onAccepted: sendBtn.clicked() } Button { id: sendBtn; text: "➤"; background: Rectangle{color:cYellow} onClicked: { if(chatInput.text==="")return; chatModel.append({msg:chatInput.text, isUser:true}); chatModel.append({msg:backend.askAI(chatInput.text), isUser:false}); chatInput.text="" } } }
        }
    }
}
}
