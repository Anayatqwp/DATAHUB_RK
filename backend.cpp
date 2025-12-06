#include "backend.h"
#include <QRandomGenerator>

Backend::Backend(QObject *parent) : QObject(parent)
{
    initUniversities();
    initAI();
    initNews();
    initTranslations();
}


void Backend::initUniversities()
{

    UniversityData kaznu;
    kaznu.name = "КазНУ им. аль-Фараби";
    kaznu.website = "https://kaznu.edu.kz";
    kaznu.about = "Ведущий национальный университет Казахстана. Топ-150 мирового рейтинга QS WUR. Кампус «Казгуград» (100 га).";
    kaznu.programs = "• 16 факультетов\n• Механико-математический, Биологии, Востоковедения.\n• Бакалавриат -> Магистратура -> PhD.";
    kaznu.admission = "• Проходной балл: 110-135\n• Военная кафедра: Есть\n• Общежития: 15 домов студентов.";
    kaznu.partners = "1. МГУ им. Ломоносова\n2. Seoul National University\n3. Microsoft Center";
    kaznu.stats = "📊 QS Rank: #150\n👥 Студентов: 26,000+\n💼 Трудоустройство: 88%\n🏛 Год основания: 1934";
    kaznu.city = "Алматы";
    kaznu.history = "Основан в 1934 году.";
    kaznu.popularMajors = "IT, Право, МО";
    kaznu.avgPassScore = 125;
    m_db.append(kaznu);


    UniversityData kbtu;
    kbtu.name = "КБТУ (KBTU)";
    kbtu.website = "https://kbtu.edu.kz";
    kbtu.about = "Казахстанско-Британский технический университет. Обучение на английском. Здание бывшего Правительства.";
    kbtu.programs = "• IT (FIT)\n• Нефтегазовая индустрия\n• Бизнес-школа\n• Морская академия.";
    kbtu.admission = "• IELTS 5.5+ обязательно\n• Профильные: Физ+Мат / Мат+Инф.";
    kbtu.partners = "1. University of London\n2. Eni, Chevron\n3. HBS (Harvard)";
    kbtu.stats = "📊 IT Rank: #1\n💰 ЗП: Высокая\n👥 Студентов: ~4,500";
    kbtu.city = "Алматы";
    kbtu.history = "Основан в 2001 году.";
    kbtu.popularMajors = "Нефтегаз, IT, Финансы";
    kbtu.avgPassScore = 115;
    m_db.append(kbtu);


    UniversityData enu;
    enu.name = "ЕНУ им. Л.Н. Гумилева";
    enu.website = "https://enu.kz";
    enu.about = "Крупнейший вуз Астаны. Центр евразийской интеграции.";
    enu.programs = "• Архитектурно-строительный\n• Международные отношения\n• Космическая техника.";
    enu.admission = "• Стандартные правила ЕНТ\n• Программа 'Серпін'.";
    enu.partners = "1. МГИМО\n2. Warsaw University\n3. CERN";
    enu.stats = "📊 QS Rank: #277\n👥 Студентов: 20,000+\n🏢 Общежитий: 8";
    enu.city = "Астана";
    enu.history = "Основан в 1996 году.";
    enu.popularMajors = "Архитектура, Физика";
    enu.avgPassScore = 110;
    m_db.append(enu);


    UniversityData satbayev;
    satbayev.name = "Satbayev University";
    satbayev.website = "https://satbayev.university";
    satbayev.about = "Легендарный Политех. Старейший технический вуз страны.";
    satbayev.programs = "• Горно-металлургический\n• Геология и нефтегаз\n• Кибернетика.";
    satbayev.admission = "• Профильные: Мат+Физ\n• Много грантов.";
    satbayev.partners = "1. Colorado School of Mines\n2. Казатомпром\n3. Huawei";
    satbayev.stats = "📊 Статус: Исследовательский\n👥 Студентов: 11,000";
    satbayev.city = "Алматы";
    satbayev.history = "Основан в 1934 году.";
    satbayev.popularMajors = "Геология, Робототехника";
    satbayev.avgPassScore = 100;
    m_db.append(satbayev);
    UniversityData iitu;
    iitu.name = "IITU (МУИТ)";
    iitu.website = "https://iitu.edu.kz";
    iitu.about = "Международный IT-университет. Лидер в подготовке программистов и специалистов по кибербезопасности.";
    iitu.programs = "• Кибербезопасность (CS)\n• Big Data Analysis\n• Журналистика и медиа.";
    iitu.admission = "• Профильные: Мат+Инф\n• Обязательно знание английского.";
    iitu.partners = "1. CISCO Academy\n2. Kaspersky Lab\n3. 1C Kazakhstan";
    iitu.stats = "📊 QS Rank: #Top-200 Asia\n👥 Студентов: 4,000+\n💼 Трудоустройство: 94%\n🏛 Год основания: 2009";
    iitu.city = "Алматы";
    iitu.history = "Основан в 2009 году по поручению Президента.";
    iitu.popularMajors = "CS, Big Data, IT-Management";
    iitu.avgPassScore = 118; // Высокий балл
    m_db.append(iitu);
}


void Backend::initAI()
{
    m_aiKnowledge.insert("привет", "Привет! Я DataBot.");
    m_aiKnowledge.insert("грант", "Грант покрывает обучение и дает стипендию. Нужен высокий балл ЕНТ.");
    m_aiKnowledge.insert("ент", "ЕНТ сдается 4 раза в год. Для гранта нужен сертификат за июнь.");
    m_aiKnowledge.insert("документ", "Нужны: Аттестат, сертификат ЕНТ, справка 075у, фото 3х4, копия уд. личности.");
    m_aiKnowledge.insert("военка", "Военная кафедра есть в национальных вузах (КазНУ, ЕНУ, Сатпаев).");
    m_aiKnowledge.insert("общежитие", "Места в общежитии распределяются: сначала сироты/инвалиды, потом 1 курс.");
}


void Backend::initNews()
{
    QVariantMap n1; n1["title"]="Регистрация на ЕНТ"; n1["date"]="06.12.2025"; n1["text"]="Открыта регистрация на январское ЕНТ."; n1["link"]="https://testcenter.kz"; m_newsList.append(n1);
    QVariantMap n2; n2["title"]="Новые гранты"; n2["date"]="01.12.2025"; n2["text"]="Выделено 5000 грантов для инженеров."; n2["link"]="https://gov.kz"; m_newsList.append(n2);
}


void Backend::initTranslations()
{
    // === РУССКИЙ ===
    QVariantMap ru;
    ru["app_title"] = "DataHub ВУЗов РК";
    // Меню
    ru["menu_about"] = "О ВУЗЕ";
    ru["menu_progs"] = "ПРОГРАММЫ";
    ru["menu_adm"] = "ПОСТУПЛЕНИЕ";
    ru["menu_compare"] = "СРАВНЕНИЕ";
    ru["menu_3d"] = "3D ТУР";
    ru["menu_partner"] = "ПАРТНЕРЫ";
    ru["menu_stats"] = "СТАТИСТИКА";
    ru["menu_popular"] = "ПОПУЛЯРНЫЕ";
    // Дровер
    ru["drawer_lk"] = "ЛИЧНЫЙ КАБИНЕТ";
    ru["guest_name"] = "Гость";
    ru["btn_login"] = "ВОЙТИ";
    ru["btn_signup"] = "РЕГИСТРАЦИЯ";
    ru["btn_logout"] = "ВЫЙТИ";
    ru["lbl_profile"] = "Мой Профиль";
    ru["lbl_fav"] = "Избранное";
    ru["lbl_news"] = "Новости ВУЗов";
    ru["lbl_comp"] = "Сравнить ВУЗы";
    ru["lbl_top"] = "Топ ВУЗы";
    // Попапы входа
    ru["pop_log_title"] = "ВХОД В СИСТЕМУ";
    ru["pop_sign_title"] = "СОЗДАНИЕ АККАУНТА";
    ru["f_email"] = "Email";
    ru["f_pass"] = "Пароль";
    ru["f_name"] = "Имя";
    ru["btn_enter"] = "ВОЙТИ";
    ru["btn_create"] = "СОЗДАТЬ";
    ru["err_fail"] = "Ошибка входа";
    ru["err_exist"] = "Пользователь существует";
    // ИИ
    ru["ai_welcome"] = "Привет! Я DataBot. Чем могу помочь?";
    ru["ai_promo"] = "Ты уже минуту здесь! Есть вопросы про гранты?";


    QVariantMap en;
    en["app_title"] = "DataHub Universities RK";
    en["menu_about"] = "ABOUT";
    en["menu_progs"] = "PROGRAMS";
    en["menu_adm"] = "ADMISSION";
    en["menu_compare"] = "COMPARE";
    en["menu_3d"] = "3D TOUR";
    en["menu_partner"] = "PARTNERS";
    en["menu_stats"] = "STATS";
    en["menu_popular"] = "POPULAR";
    en["drawer_lk"] = "DASHBOARD";
    en["guest_name"] = "Guest";
    en["btn_login"] = "LOG IN";
    en["btn_signup"] = "SIGN UP";
    en["btn_logout"] = "LOG OUT";
    en["lbl_profile"] = "My Profile";
    en["lbl_fav"] = "Favorites";
    en["lbl_news"] = "Uni News";
    en["lbl_comp"] = "Compare Unis";
    en["lbl_top"] = "Top Unis";
    en["pop_log_title"] = "LOGIN";
    en["pop_sign_title"] = "REGISTER";
    en["f_email"] = "Email";
    en["f_pass"] = "Password";
    en["f_name"] = "Name";
    en["btn_enter"] = "ENTER";
    en["btn_create"] = "CREATE";
    en["err_fail"] = "Login failed";
    en["err_exist"] = "User exists";
    en["ai_welcome"] = "Hello! I am DataBot.";
    en["ai_promo"] = "Need help with admission?";

    // === KAZAKH ===
    QVariantMap kz;
    kz["app_title"] = "DataHub ҚР ЖОО-лары";
    kz["menu_about"] = "ЖОО ТУРАЛЫ";
    kz["menu_progs"] = "БАҒДАРЛАМАЛАР";
    kz["menu_adm"] = "ТҮСУ";
    kz["menu_compare"] = "САЛЫСТЫРУ";
    kz["menu_3d"] = "3D ТУР";
    kz["menu_partner"] = "СЕРІКТЕСТЕР";
    kz["menu_stats"] = "СТАТИСТИКА";
    kz["menu_popular"] = "ТАНЫМАЛ";
    kz["drawer_lk"] = "ЖЕКЕ КАБИНЕТ";
    kz["guest_name"] = "Қонақ";
    kz["btn_login"] = "КІРУ";
    kz["btn_signup"] = "ТІРКЕЛУ";
    kz["btn_logout"] = "ШЫҒУ";
    kz["lbl_profile"] = "Менің Профилім";
    kz["lbl_fav"] = "Таңдаулылар";
    kz["lbl_news"] = "Жаңалықтар";
    kz["lbl_comp"] = "Салыстыру";
    kz["lbl_top"] = "Үздік ЖОО";
    kz["pop_log_title"] = "ЖҮЙЕГЕ КІРУ";
    kz["pop_sign_title"] = "ТІРКЕЛУ";
    kz["f_email"] = "Email";
    kz["f_pass"] = "Құпия сөз";
    kz["f_name"] = "Есім";
    kz["btn_enter"] = "КІРУ";
    kz["btn_create"] = "ТІРКЕЛУ";
    kz["err_fail"] = "Қате";
    kz["err_exist"] = "Пайдаланушы бар";
    kz["ai_welcome"] = "Сәлем! Мен DataBot-пын.";
    kz["ai_promo"] = "Сұрақтарыңыз бар ма?";

    m_translations.insert("ru", ru);
    m_translations.insert("en", en);
    m_translations.insert("kz", kz);
}

QVariantMap Backend::getUiStrings(const QString &lang)
{
    if (m_translations.contains(lang)) return m_translations[lang];
    return m_translations["ru"];
}


bool Backend::registerUser(const QString &name, const QString &email, const QString &password)
{
    for(const auto &u : std::as_const(m_usersDb)) {
        if(u.email == email) return false;
    }
    UserProfile newUser; newUser.name = name; newUser.email = email; newUser.password = password;
    m_usersDb.append(newUser);
    m_profile = newUser;
    m_isLoggedIn = true;
    return true;
}

bool Backend::loginUser(const QString &email, const QString &password)
{
    for(const auto &u : m_usersDb) {
        if(u.email == email && u.password == password) {
            m_profile = u;
            m_isLoggedIn = true;
            return true;
        }
    }
    return false;
}

void Backend::logout() { m_isLoggedIn = false; m_profile = UserProfile(); }
bool Backend::isUserLoggedIn() { return m_isLoggedIn; }


QStringList Backend::getUniversityNames() { QStringList n; for(auto& u:m_db) n<<u.name; return n; }
QString Backend::getWebsite(int i) { return (i>=0 && i<m_db.size()) ? m_db[i].website : ""; }
QVariantList Backend::getNews() { return m_newsList; }
void Backend::toggleFavorite(int i) { if(i>=0 && i<m_db.size()) m_db[i].isFavorite = !m_db[i].isFavorite; }
bool Backend::isFavorite(int i) { return (i>=0 && i<m_db.size()) ? m_db[i].isFavorite : false; }
QStringList Backend::getFavorites() { QStringList l; for(auto& u:m_db) if(u.isFavorite) l<<u.name; return l; }

QString Backend::getInfo(int i, int t) {
    if(i<0||i>=m_db.size())return "";
    const auto &u=m_db[i];
    if(t==1)return u.about; if(t==2)return u.programs; if(t==3)return u.admission;
    if(t==5)return u.partners; if(t==7)return u.stats; return "";
}

QVariantMap Backend::getUniversityDetails(int i) {
    QVariantMap m;
    if(i>=0 && i<m_db.size()){
        const auto &u=m_db[i];
        m["name"]=u.name; m["city"]=u.city; m["about"]=u.about;
        m["website"]=u.website; m["avgPassScore"]=u.avgPassScore;
        m["popularMajors"]=u.popularMajors; m["stats"]=u.stats; m["partners"]=u.partners;
    }
    return m;
}

QString Backend::askAI(const QString &q) {
    QString low = q.toLower();
    QMapIterator<QString, QString> i(m_aiKnowledge);
    while (i.hasNext()) { i.next(); if (low.contains(i.key())) return i.value(); }
    return "Я пока учусь. Спроси про 'гранты' или 'общежитие'.";
}
QString Backend::getAIWelcomeMessage(const QString &lang) {
    return getUiStrings(lang)["ai_welcome"].toString();
}

void Backend::saveProfile(const QString &s, const QString &n, const QString &p, const QString &d, const QString &iin, const QString &ph, const QString &c, int sc) {
    m_profile.surname=s; m_profile.name=n; m_profile.patronymic=p; m_profile.birthDate=d;
    m_profile.iin=iin; m_profile.phone=ph; m_profile.city=c; m_profile.entScore=sc;
}
QVariantMap Backend::getUserProfile() {
    QVariantMap m; m["name"]=m_profile.name; m["surname"]=m_profile.surname;
    m["patronymic"]=m_profile.patronymic; m["birthDate"]=m_profile.birthDate;
    m["iin"]=m_profile.iin; m["phone"]=m_profile.phone; m["city"]=m_profile.city; m["entScore"]=m_profile.entScore;
    return m;
}
QVariantList Backend::getComparisonTableData()
{
    QVariantList list;

    for (const auto &u : m_db) {
        QVariantMap row;
        row["name"] = u.name;
        row["city"] = u.city;
        row["score"] = QString::number(u.avgPassScore);

        // 1. Парсим Рейтинг из строки stats (ищем "Rank: #150")
        QString rank = "-";
        if (u.stats.contains("Rank:")) {
            int start = u.stats.indexOf("Rank:") + 5;
            int end = u.stats.indexOf("\n", start);
            if (end == -1) end = u.stats.length();
            rank = u.stats.mid(start, end - start).trimmed();
        }
        row["rank"] = rank;

        // 2. Парсим Трудоустройство (ищем "%")
        QString job = "-";
        if (u.stats.contains("Трудоустройство:")) {
            // Простой поиск процента
            int percIdx = u.stats.indexOf("%");
            if (percIdx != -1) {
                job = u.stats.mid(percIdx - 3, 4).trimmed(); // Берем "88%"
            }
        }
        row["job"] = job;

        // 3. Общежитие (проверяем текст admission)
        QString dorm = "Нет данных";
        if (u.admission.toLower().contains("общежити") || u.about.toLower().contains("кампус")) {
            dorm = "Есть";
        }
        row["dorm"] = dorm;

        list.append(row);
    }
    return list;
}
