#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>
#include <QVector>
#include <QMap>
#include <QVariantList>
#include <QVariantMap>

struct UserProfile {
    QString name = ""; // Имя теперь пустое по умолчанию
    QString surname = "";
    QString email = ""; // Новое поле
    QString password = ""; // Новое поле
    QString patronymic = "";
    QString birthDate = "";
    QString iin = "";
    QString phone = "";
    QString city = "";
    int entScore = 0;
};

struct UniversityData {
    QString name;
    QString website;
    QString about;
    QString programs;
    QString admission;
    QString partners;
    QString stats;
    QString history;
    QString city;
    QString popularMajors;
    int avgPassScore;
    bool isFavorite = false;
};

class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr);

    // --- ВУЗЫ ---
    Q_INVOKABLE QStringList getUniversityNames();
    Q_INVOKABLE QString getInfo(int uniIndex, int tabIndex);
    Q_INVOKABLE QString getWebsite(int uniIndex);
    Q_INVOKABLE QVariantMap getUniversityDetails(int uniIndex);
    Q_INVOKABLE QVariantList getComparisonTableData();

    // --- НОВОСТИ И ИЗБРАННОЕ ---
    Q_INVOKABLE QVariantList getNews();
    Q_INVOKABLE void toggleFavorite(int uniIndex);
    Q_INVOKABLE bool isFavorite(int uniIndex);
    Q_INVOKABLE QStringList getFavorites();

    // --- ИИ ---
    Q_INVOKABLE QString askAI(const QString &question);
    Q_INVOKABLE QString getAIWelcomeMessage(const QString &lang); // Обновили: принимает язык

    // --- ПРОФИЛЬ ---
    Q_INVOKABLE void saveProfile(const QString &surname, const QString &name, const QString &patr,
                                 const QString &date, const QString &iin, const QString &phone,
                                 const QString &city, int score);
    Q_INVOKABLE QVariantMap getUserProfile();

    // --- НОВЫЕ МЕТОДЫ: АВТОРИЗАЦИЯ ---
    Q_INVOKABLE bool registerUser(const QString &name, const QString &email, const QString &password);
    Q_INVOKABLE bool loginUser(const QString &email, const QString &password);
    Q_INVOKABLE void logout();
    Q_INVOKABLE bool isUserLoggedIn();

    // --- НОВЫЙ МЕТОД: ЛОКАЛИЗАЦИЯ (ПЕРЕВОДЫ) ---
    Q_INVOKABLE QVariantMap getUiStrings(const QString &lang);

private:
    void initUniversities();
    void initAI();
    void initNews();
    void initTranslations(); // Инициализация словаря

    QVector<UniversityData> m_db;
    QMap<QString, QString> m_aiKnowledge;
    QVariantList m_newsList;
    UserProfile m_profile;

    // Хранилище пользователей (в памяти)
    QVector<UserProfile> m_usersDb;
    bool m_isLoggedIn = false;

    // Хранилище переводов: Язык -> {Ключ -> Значение}
    QMap<QString, QVariantMap> m_translations;
};

#endif // BACKEND_H
