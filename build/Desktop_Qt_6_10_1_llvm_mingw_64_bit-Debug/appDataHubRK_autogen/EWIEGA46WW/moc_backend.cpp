/****************************************************************************
** Meta object code from reading C++ file 'backend.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.10.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../backend.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'backend.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 69
#error "This file was generated using the moc from 6.10.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {
struct qt_meta_tag_ZN7BackendE_t {};
} // unnamed namespace

template <> constexpr inline auto Backend::qt_create_metaobjectdata<qt_meta_tag_ZN7BackendE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "Backend",
        "getUniversityNames",
        "",
        "getInfo",
        "uniIndex",
        "tabIndex",
        "getWebsite",
        "getUniversityDetails",
        "QVariantMap",
        "getComparisonTableData",
        "QVariantList",
        "getNews",
        "toggleFavorite",
        "isFavorite",
        "getFavorites",
        "askAI",
        "question",
        "getAIWelcomeMessage",
        "lang",
        "saveProfile",
        "surname",
        "name",
        "patr",
        "date",
        "iin",
        "phone",
        "city",
        "score",
        "getUserProfile",
        "registerUser",
        "email",
        "password",
        "loginUser",
        "logout",
        "isUserLoggedIn",
        "getUiStrings"
    };

    QtMocHelpers::UintData qt_methods {
        // Method 'getUniversityNames'
        QtMocHelpers::MethodData<QStringList()>(1, 2, QMC::AccessPublic, QMetaType::QStringList),
        // Method 'getInfo'
        QtMocHelpers::MethodData<QString(int, int)>(3, 2, QMC::AccessPublic, QMetaType::QString, {{
            { QMetaType::Int, 4 }, { QMetaType::Int, 5 },
        }}),
        // Method 'getWebsite'
        QtMocHelpers::MethodData<QString(int)>(6, 2, QMC::AccessPublic, QMetaType::QString, {{
            { QMetaType::Int, 4 },
        }}),
        // Method 'getUniversityDetails'
        QtMocHelpers::MethodData<QVariantMap(int)>(7, 2, QMC::AccessPublic, 0x80000000 | 8, {{
            { QMetaType::Int, 4 },
        }}),
        // Method 'getComparisonTableData'
        QtMocHelpers::MethodData<QVariantList()>(9, 2, QMC::AccessPublic, 0x80000000 | 10),
        // Method 'getNews'
        QtMocHelpers::MethodData<QVariantList()>(11, 2, QMC::AccessPublic, 0x80000000 | 10),
        // Method 'toggleFavorite'
        QtMocHelpers::MethodData<void(int)>(12, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 4 },
        }}),
        // Method 'isFavorite'
        QtMocHelpers::MethodData<bool(int)>(13, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 4 },
        }}),
        // Method 'getFavorites'
        QtMocHelpers::MethodData<QStringList()>(14, 2, QMC::AccessPublic, QMetaType::QStringList),
        // Method 'askAI'
        QtMocHelpers::MethodData<QString(const QString &)>(15, 2, QMC::AccessPublic, QMetaType::QString, {{
            { QMetaType::QString, 16 },
        }}),
        // Method 'getAIWelcomeMessage'
        QtMocHelpers::MethodData<QString(const QString &)>(17, 2, QMC::AccessPublic, QMetaType::QString, {{
            { QMetaType::QString, 18 },
        }}),
        // Method 'saveProfile'
        QtMocHelpers::MethodData<void(const QString &, const QString &, const QString &, const QString &, const QString &, const QString &, const QString &, int)>(19, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 20 }, { QMetaType::QString, 21 }, { QMetaType::QString, 22 }, { QMetaType::QString, 23 },
            { QMetaType::QString, 24 }, { QMetaType::QString, 25 }, { QMetaType::QString, 26 }, { QMetaType::Int, 27 },
        }}),
        // Method 'getUserProfile'
        QtMocHelpers::MethodData<QVariantMap()>(28, 2, QMC::AccessPublic, 0x80000000 | 8),
        // Method 'registerUser'
        QtMocHelpers::MethodData<bool(const QString &, const QString &, const QString &)>(29, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::QString, 21 }, { QMetaType::QString, 30 }, { QMetaType::QString, 31 },
        }}),
        // Method 'loginUser'
        QtMocHelpers::MethodData<bool(const QString &, const QString &)>(32, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::QString, 30 }, { QMetaType::QString, 31 },
        }}),
        // Method 'logout'
        QtMocHelpers::MethodData<void()>(33, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'isUserLoggedIn'
        QtMocHelpers::MethodData<bool()>(34, 2, QMC::AccessPublic, QMetaType::Bool),
        // Method 'getUiStrings'
        QtMocHelpers::MethodData<QVariantMap(const QString &)>(35, 2, QMC::AccessPublic, 0x80000000 | 8, {{
            { QMetaType::QString, 18 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
    };
    QtMocHelpers::UintData qt_enums {
    };
    return QtMocHelpers::metaObjectData<Backend, qt_meta_tag_ZN7BackendE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject Backend::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN7BackendE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN7BackendE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN7BackendE_t>.metaTypes,
    nullptr
} };

void Backend::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<Backend *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: { QStringList _r = _t->getUniversityNames();
            if (_a[0]) *reinterpret_cast<QStringList*>(_a[0]) = std::move(_r); }  break;
        case 1: { QString _r = _t->getInfo((*reinterpret_cast<std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<int>>(_a[2])));
            if (_a[0]) *reinterpret_cast<QString*>(_a[0]) = std::move(_r); }  break;
        case 2: { QString _r = _t->getWebsite((*reinterpret_cast<std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast<QString*>(_a[0]) = std::move(_r); }  break;
        case 3: { QVariantMap _r = _t->getUniversityDetails((*reinterpret_cast<std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast<QVariantMap*>(_a[0]) = std::move(_r); }  break;
        case 4: { QVariantList _r = _t->getComparisonTableData();
            if (_a[0]) *reinterpret_cast<QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 5: { QVariantList _r = _t->getNews();
            if (_a[0]) *reinterpret_cast<QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 6: _t->toggleFavorite((*reinterpret_cast<std::add_pointer_t<int>>(_a[1]))); break;
        case 7: { bool _r = _t->isFavorite((*reinterpret_cast<std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast<bool*>(_a[0]) = std::move(_r); }  break;
        case 8: { QStringList _r = _t->getFavorites();
            if (_a[0]) *reinterpret_cast<QStringList*>(_a[0]) = std::move(_r); }  break;
        case 9: { QString _r = _t->askAI((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])));
            if (_a[0]) *reinterpret_cast<QString*>(_a[0]) = std::move(_r); }  break;
        case 10: { QString _r = _t->getAIWelcomeMessage((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])));
            if (_a[0]) *reinterpret_cast<QString*>(_a[0]) = std::move(_r); }  break;
        case 11: _t->saveProfile((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[4])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[5])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[6])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[7])),(*reinterpret_cast<std::add_pointer_t<int>>(_a[8]))); break;
        case 12: { QVariantMap _r = _t->getUserProfile();
            if (_a[0]) *reinterpret_cast<QVariantMap*>(_a[0]) = std::move(_r); }  break;
        case 13: { bool _r = _t->registerUser((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[3])));
            if (_a[0]) *reinterpret_cast<bool*>(_a[0]) = std::move(_r); }  break;
        case 14: { bool _r = _t->loginUser((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2])));
            if (_a[0]) *reinterpret_cast<bool*>(_a[0]) = std::move(_r); }  break;
        case 15: _t->logout(); break;
        case 16: { bool _r = _t->isUserLoggedIn();
            if (_a[0]) *reinterpret_cast<bool*>(_a[0]) = std::move(_r); }  break;
        case 17: { QVariantMap _r = _t->getUiStrings((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])));
            if (_a[0]) *reinterpret_cast<QVariantMap*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

const QMetaObject *Backend::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Backend::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN7BackendE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Backend::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 18)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 18;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 18)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 18;
    }
    return _id;
}
QT_WARNING_POP
