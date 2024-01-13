#ifndef GAME_H
#define GAME_H

#include <QObject>
#include <QDebug>
#include <QDir>
#include "../common/AppEnum.h"
#include "../common/Define.h"

class Game : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int correct          READ correct        WRITE setCorrect        NOTIFY correctChanged)
    Q_PROPERTY(int incorrect        READ incorrect      WRITE setIncorrect      NOTIFY incorrectChanged)
    Q_PROPERTY(QString question     READ question       WRITE setQuestion       NOTIFY questionChanged)
    Q_PROPERTY(QString answer       READ answer         WRITE setAnswer         NOTIFY answerChanged)
    Q_PROPERTY(bool isPlaying       READ isPlaying      WRITE setIsPlaying      NOTIFY isPlayingChanged)
    Q_PROPERTY(bool isMute          READ isMute         WRITE setIsMute         NOTIFY isMuteChanged)
public:
    explicit Game(QObject *parent = nullptr);

    const int &correct() const;
    void setCorrect(const int newCorrect);

    const int &incorrect() const;
    void setIncorrect(const int newIncorrect);

    const QString &question() const;
    void setQuestion(const QString newQuestion);

    const QString &answer() const;
    void setAnswer(const QString newAnswer);

    const bool &isPlaying() const;
    void setIsPlaying(const bool newIsPlaying);

    const bool &isMute() const;
    void setIsMute(const bool newIsMute);

public slots:
    void play();
    void stop();
    void next();
    void setMute();
    bool check(QString answer);
    void receiveQuestion(QString question, QString answer);

signals:
    void correctChanged();
    void incorrectChanged();
    void questionChanged();
    void answerChanged();
    void isPlayingChanged();
    void isMuteChanged();
    void requestQuestion();
    void requestAudio(QString path);

private:
    int m_correct;
    int m_incorrect;
    QString m_question;
    QString m_answer;
    bool m_isPlaying;
    bool m_isMute;
};

#endif // GAME_H
