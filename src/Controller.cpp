#include "Controller.h"

Controller::Controller(QObject *parent) : QObject(parent)
{
    initialize();

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
    QJsonObject configData;
    if(!FileControl::readFile(PATH_DATA + QString("/config.json"), configData))
        return;
    m_setting.initialize(configData);
    QString path = m_setting.background();
    if(!FileControl::checkFileImg(path))
            path = PATH_DATA + "/bg.jpg";
    m_setting.setBackground(path);

    path = m_setting.pathData();
    if(!FileControl::checkFileJson(path))
            path = PATH_DATA + QString("/data.json");
    m_setting.setPathData(path);

    if(m_setting.language() == AppEnum::LANGUAGE::VIETNAMESE) {
        m_translator.load(":/translate/vi_VN.qm");
        qApp->installTranslator(&m_translator);
    }

    if(!FileControl::readFile(m_setting.pathData(), m_dataJson))
        return;
    m_grammar.initialize(m_dataJson["grammar"].toArray());
    m_noteBook.updateData(m_dataJson["words"].toArray());
    m_noteBook.onChangedRandomKey();
}

QString Controller::popupConfirm() const
{
    return m_popupConfirm;
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
    QJsonObject configData;
    if(!FileControl::readFile(PATH_DATA + QString("/config.json"), configData))
        return;

    switch (lang) {
    case AppEnum::LANGUAGE::VIETNAMESE:
        configData["language"] = "vn";
        m_translator.load(":/translate/vi_VN.qm");
        qApp->installTranslator(&m_translator);
        break;
    case AppEnum::LANGUAGE::ENGLISH:
        configData["language"] = "eng";
        qApp->removeTranslator(&m_translator);
        break;
    default:
        break;
    }

    FileControl::writeFileJson(PATH_DATA + QString("/config.json"), configData);

    emit translatorChanged();
    m_setting.setLanguage(lang);
}

void Controller::setBackground(QString path)
{
    if(!FileControl::checkFileImg(path)) {
        qDebug() << "Cann't open file: " + path;
        setPopupNotify((QString(tr("Cann't open file: ")) + path));
        return;
    }

    QJsonObject configData;
    if(!FileControl::readFile(PATH_DATA + QString("/config.json"), configData))
        return;

    configData["background"] = path;
    FileControl::writeFileJson(PATH_DATA + QString("/config.json"), configData);

    m_setting.setBackground(path);
}

void Controller::setPathData(QString path)
{

    if(!FileControl::checkFileJson(path)) {
        qDebug() << "Cann't open file: " + path;
        setPopupNotify((QString(tr("Cann't open file: ")) + path));
        return;
    }

    QJsonObject configData;
    if(!FileControl::readFile(PATH_DATA + QString("/config.json"), configData))
        return;

    configData["pathData"] = path;
    FileControl::writeFileJson(PATH_DATA + QString("/config.json"), configData);

    //m_setting.setPathData(path);
    initialize();
}

void Controller::setTheme(bool isLight)
{
    QJsonObject configData;
    if(!FileControl::readFile(PATH_DATA + QString("/config.json"), configData))
        return;

    configData["theme"] = isLight;
    FileControl::writeFileJson(PATH_DATA + QString("/config.json"), configData);

    m_setting.setIsThemeLight(isLight);
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
    FileControl::writeFileJson(m_setting.pathData(), m_dataJson);
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
    FileControl::writeFileJson(m_setting.pathData(), m_dataJson);
    m_noteBook.updateData(arr);
    m_noteBook.updateCurrentData();
}

void Controller::setPosNote(double position)
{
    m_noteBook.setPosScroll(position);
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
    FileControl::writeFileJson(m_setting.pathData(), m_dataJson);

    m_grammar.removeAt(index);
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
    FileControl::writeFileJson(m_setting.pathData(), m_dataJson);

    m_grammar.modify(index, GrammarItem(form, structure));
}

void Controller::setPosGrammar(double position)
{
    m_grammar.setPosScroll(position);
}

void Controller::removeItem(int item, int index)
{
    switch (item) {
    case AppEnum::NOTEITEM:
        removeItemNote(index);
        break;
    case AppEnum::GRAMMARITEM:
        removeItemGrammar(index);
        break;
    default:
        break;
    }
}

void Controller::receiveNtf(QString ntf)
{
    setPopupNotify(ntf);
}

void Controller::receiveConf(int item, int index)
{
    m_popupConfirm = tr("Delete this item?");
    emit popupConfirmChanged(item, index);
}

void Controller::receiveAudio(QString path)
{
    m_audio.setMedia(QUrl(path));
    m_audio.play();
}
