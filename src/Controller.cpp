#include "Controller.h"

Controller::Controller(QObject *parent) : QObject(parent)
{
    initialize();
    connect(m_voiceChat.tcpClient(),    &TCPClient::sendNtfUI,      this,           &Controller::receiveNtf);

    connect(&m_game,                    &Game::requestAudio,        this,           &Controller::receiveAudio);
    connect(&m_dictionary,              &Dictionary::requestAudio,  this,           &Controller::receiveAudio);

    connect(&m_game,                    &Game::requestQuestion,     &m_noteBook,    &NoteBook::onRequestQuestion);
    connect(&m_noteBook,                &NoteBook::sendQuestion,    &m_game,        &Game::receiveQuestion);
}

Controller *Controller::getInstance()
{
    static Controller _self;
    return &_self;
}

void Controller::initialize()
{
    if(!m_file.readFile(PATH_DATA + QString("/data.json"), m_dataJson))
        return;
    m_grammar.initialize(m_dataJson["grammar"].toArray());
    m_setting.initialize(m_dataJson["setting"].toObject());
    m_noteBook.updateData(m_dataJson["words"].toArray());
    m_noteBook.onChangedRandomKey();

    if(m_setting.language() == AppEnum::LANGUAGE::VIETNAMESE) {
        m_translator.load(":/translate/vi_VN.qm");
        qApp->installTranslator(&m_translator);
    }

    QString path_bg = m_setting.background();
    if(!m_file.checkFileImg(path_bg))
            path_bg = "";

    m_setting.setBackground(path_bg);
}

QString Controller::popupConfirm() const
{
    return m_popupConfirm;
}

void Controller::setPopupConfirm(QString newPopupConfirm)
{
    m_popupConfirm = newPopupConfirm;
    emit popupConfirmChanged();
}

QString Controller::popupNotify() const
{
    return m_popupNotify;
}

void Controller::setPopupNotify(QString newPopupNotify)
{
    m_popupNotify = newPopupNotify;
    emit popupNotifyChanged();
}

QString Controller::translator()
{
    return "";
}

NoteBook *Controller::noteBook()
{
    return &m_noteBook;
}

Grammar *Controller::grammar()
{
    return &m_grammar;
}

Dictionary *Controller::dictionary()
{
    return &m_dictionary;
}

VoiceChat *Controller::voiceChat()
{
    return &m_voiceChat;
}

Game *Controller::game()
{
    return &m_game;
}

Setting *Controller::setting()
{
    return &m_setting;
}

void Controller::setLanguage(int lang)
{
    QJsonObject obj = m_dataJson.value("setting").toObject();
    switch (lang) {
    case AppEnum::LANGUAGE::VIETNAMESE:
        obj["language"] = "vn";
        m_dataJson["setting"] = obj;
        m_translator.load(":/translate/vi_VN.qm");
        qApp->installTranslator(&m_translator);
        break;
    case AppEnum::LANGUAGE::ENGLISH:
        obj["language"] = "eng";
        m_dataJson["setting"] = obj;
        qApp->removeTranslator(&m_translator);
        break;
    default:
        break;
    }

    m_file.writeFileJson(PATH_DATA + QString("/data.json"), m_dataJson);

    emit translatorChanged();
    m_setting.setLanguage(lang);
}

void Controller::setUserName(QString name)
{
    QJsonObject obj = m_dataJson.value("setting").toObject();
    obj["name"] = name;
    m_dataJson["setting"] = obj;
    m_file.writeFileJson(PATH_DATA + QString("/data.json"), m_dataJson);

    m_setting.setUserName(name);
}

void Controller::setIpAddress(QString ip)
{
    QJsonObject obj = m_dataJson.value("setting").toObject();
    obj["IPAddress"] = ip;
    m_dataJson["setting"] = obj;
    m_file.writeFileJson(PATH_DATA + QString("/data.json"), m_dataJson);

    m_setting.setIpAddress(ip);
}

void Controller::setPort(int port)
{
    QJsonObject obj = m_dataJson.value("setting").toObject();
    obj["port"] = port;
    m_dataJson["setting"] = obj;
    m_file.writeFileJson(PATH_DATA + QString("/data.json"), m_dataJson);

    m_setting.setPort(port);
}

void Controller::setBackground(QString path)
{
    if(!m_file.checkFileImg(path)) {
        qDebug() << "Cann't open file: " + path;
        setPopupNotify((QString(tr("Cann't open file: ")) + path));
        return;
    }

    QJsonObject obj = m_dataJson.value("setting").toObject();
    obj["background"] = path;
    m_dataJson["setting"] = obj;
    m_file.writeFileJson(PATH_DATA + QString("/data.json"), m_dataJson);

    m_setting.setBackground(path);
}

void Controller::setThemeColor(QString color)
{
    QColor check(color);
    if (!check.isValid()) {
        qDebug() << "Invalid color: " << color;
        setPopupNotify((QString(tr("Invalid color: ")) + color));
        return;
    }

    QJsonObject obj = m_dataJson.value("setting").toObject();
    obj["themeColor"] = color;
    m_dataJson["setting"] = obj;
    m_file.writeFileJson(PATH_DATA + QString("/data.json"), m_dataJson);

    m_setting.setThemeColor(color);
}

void Controller::setBorderColor(QString color)
{
    QColor check(color);
    if (!check.isValid()) {
        qDebug() << "Invalid color: " << color;
        setPopupNotify((QString(tr("Invalid color: ")) + color));
        return;
    }

    QJsonObject obj = m_dataJson.value("setting").toObject();
    obj["borderColor"] = color;
    m_dataJson["setting"] = obj;
    m_file.writeFileJson(PATH_DATA + QString("/data.json"), m_dataJson);

    m_setting.setBorderColor(color);
}

void Controller::removeItemNote()
{
    QJsonArray arr = m_dataJson["words"].toArray();
    arr.removeAt(m_indexRemove);
    for(int i = 0; i < arr.size(); i++) {
        QJsonObject obj = arr.at(i).toObject();
        obj["index"] = i;
        arr.replace(i,obj);
    }
    m_dataJson["words"] = arr;
    m_file.writeFileJson(PATH_DATA + QString("/data.json"), m_dataJson);
    m_noteBook.updateData(arr);
    m_noteBook.notes()->removeAt(m_indexRemove);
}

void Controller::changeItemNote(QStringList keys, QStringList means, QString notes)
{
    QJsonArray arr = m_dataJson["words"].toArray();

    QJsonObject obj;
    QJsonArray arrKey;
    foreach(auto &value, keys) {
        if(!value.isEmpty())
            arrKey.append(value);
    }
    obj["words"] = arrKey;

    QJsonArray arrMean;
    foreach(auto &value, means) {
        if(!value.isEmpty())
            arrMean.append(value);
    }
    obj["means"] = arrMean;

    obj["notes"] = notes;

    if(arrKey.isEmpty() || arrMean.isEmpty()) {
        setPopupNotify(tr("The keys or means are empty!"));
        return;
    }

    if(m_noteBook.newData()->isNewData()) {
        obj["index"] = arr.size();
        arr.append(obj);
    } else {
        obj["index"] = m_noteBook.newData()->index();
        arr.replace(m_noteBook.newData()->index(), obj);
    }

    m_dataJson["words"] = arr;
    m_file.writeFileJson(PATH_DATA + QString("/data.json"), m_dataJson);
    m_noteBook.updateData(arr);
    m_noteBook.updateCurrentData();
}

void Controller::appendItemGrammar()
{
    m_grammar.requestAppend();
}

void Controller::removeItemGrammar()
{
    QJsonArray arr = m_dataJson["grammar"].toArray();
    arr.removeAt(m_indexRemove);

    m_dataJson["grammar"] = arr;
    m_file.writeFileJson(PATH_DATA + QString("/data.json"), m_dataJson);

    m_grammar.removeAt(m_indexRemove);
}

void Controller::changedItemGrammar(int index, QString form, QString structure)
{
    if (form.isEmpty() || structure.isEmpty()) {
        m_grammar.update();
        setPopupNotify(tr("The form or structure is empty!"));
        return;
    }

    QJsonArray arr = m_dataJson["grammar"].toArray();
    QJsonObject obj;
    obj["form"] = form;
    obj["structure"] = structure;

    if(index >= arr.size()) {
        arr.append(obj);
    } else {
        arr.replace(index, obj);
    }

    m_dataJson["grammar"] = arr;
    m_file.writeFileJson(PATH_DATA + QString("/data.json"), m_dataJson);

    m_grammar.modify(index, GrammarItem(form, structure));
}

void Controller::doConnect()
{
    m_voiceChat.doConnect(m_setting.ipAddress(), m_setting.port());
}

void Controller::disconnect()
{
    m_voiceChat.disconnect();
}

void Controller::sendMessage(QString msg)
{
    m_voiceChat.sendMessage(m_setting.userName(), msg);
}


void Controller::receiveNtf(QString ntf)
{
    setPopupNotify(ntf);
}

void Controller::receiveConf(int index)
{
    m_indexRemove = index;
    setPopupConfirm(tr("Are you sure you want to delete this item?"));
}

void Controller::receiveAudio(QString path)
{
    m_audio.setMedia(QUrl(path));
    m_audio.play();
}
