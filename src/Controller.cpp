#include "Controller.h"

Controller::Controller(QObject *parent) : QObject(parent)
{
    initialize();
    connect(m_voiceChat.tcpClient(),&TCPClient::sendNtfUI, this, &Controller::receiveNtf);
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
        m_translator.load(PATH_DATA + QString("/vi_VN.qm"));
        qApp->installTranslator(&m_translator);
    }

    QString path_bg = m_setting.background();
    if(!m_file.checkFileImg(path_bg))
            path_bg = "";

    m_setting.setBackground(path_bg);
}

QString Controller::notifyMsg() const
{
    return m_notifyMsg;
}

void Controller::setNotifyMsg(QString newNotifyMsg)
{
    m_notifyMsg = newNotifyMsg;
    emit notifyMsgChanged();
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
        m_translator.load(PATH_DATA + QString("/vi_VN.qm"));
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
        setNotifyMsg((QString(tr("Cann't open file: ")) + path));
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
        setNotifyMsg((QString(tr("Invalid color: ")) + color));
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
        setNotifyMsg((QString(tr("Invalid color: ")) + color));
        return;
    }

    QJsonObject obj = m_dataJson.value("setting").toObject();
    obj["borderColor"] = color;
    m_dataJson["setting"] = obj;
    m_file.writeFileJson(PATH_DATA + QString("/data.json"), m_dataJson);

    m_setting.setBorderColor(color);
}

void Controller::removeItemNote(int index)
{
    QJsonArray arr = m_dataJson["words"].toArray();
    arr.removeAt(index);
    for(int i = 0; i < arr.size(); i++) {
        QJsonObject obj = arr.at(i).toObject();
        obj["index"] = i;
        arr.replace(i,obj);
    }
    m_dataJson["words"] = arr;
    m_file.writeFileJson(PATH_DATA + QString("/data.json"), m_dataJson);
    m_noteBook.updateData(arr);
    m_noteBook.notes()->removeAt(index);
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
        setNotifyMsg(tr("The keys or means are empty!"));
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

void Controller::removeItemGrammar(int index)
{
    QJsonArray arr = m_dataJson["grammar"].toArray();
    arr.removeAt(index);

    m_dataJson["grammar"] = arr;
    m_file.writeFileJson(PATH_DATA + QString("/data.json"), m_dataJson);

    m_grammar.removeAt(index);
}

void Controller::changedItemGrammar(int index, QString form, QString structure)
{
    if (form.isEmpty() || structure.isEmpty()) {
        m_grammar.removeAt(index);
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

    GrammarItem item;
    item.form = form;
    item.structure = structure;
    m_grammar.modify(index, item);
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
    setNotifyMsg(ntf);
}
