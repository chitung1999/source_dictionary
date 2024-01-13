#include "Game.h"

Game::Game(QObject *parent) : QObject(parent)
{
    m_isPlaying = false;
    m_isMute = false;
}

const int &Game::correct() const
{
    return m_correct;
}

void Game::setCorrect(const int newCorrect)
{
    if (m_correct == newCorrect)
        return;
    m_correct = newCorrect;
    emit correctChanged();
}

const int &Game::incorrect() const
{
    return m_incorrect;
}

void Game::setIncorrect(const int newIncorrect)
{
    if (m_incorrect == newIncorrect)
        return;
    m_incorrect = newIncorrect;
    emit incorrectChanged();
}

const QString &Game::question() const
{
    return m_question;
}

void Game::setQuestion(const QString newQuestion)
{
    if (m_question == newQuestion)
        return;
    m_question = newQuestion;
    emit questionChanged();
}

const QString &Game::answer() const
{
    return m_answer;
}

void Game::setAnswer(const QString newAnswer)
{
    if (m_answer == newAnswer)
        return;
    m_answer = newAnswer;
    emit answerChanged();
}

const bool &Game::isPlaying() const
{
    return m_isPlaying;
}

void Game::setIsPlaying(const bool newIsPlaying)
{
    if (m_isPlaying == newIsPlaying)
        return;
    m_isPlaying = newIsPlaying;
    emit isPlayingChanged();
}

const bool &Game::isMute() const
{
    return m_isMute;
}

void Game::setIsMute(const bool newIsMute)
{
    if (m_isMute == newIsMute)
        return;
    m_isMute = newIsMute;
    emit isMuteChanged();
}

void Game::play()
{
    setIsPlaying(true);
    emit requestQuestion();
}

void Game::stop()
{
    setCorrect(0);
    setIncorrect(0);
    setIsPlaying(false);
}

void Game::next()
{
    emit requestQuestion();
}

void Game::setMute()
{
    setIsMute(!m_isMute);
}

bool Game::check(QString answer)
{
    bool isTrue = (answer == m_answer);
    isTrue ? setCorrect(m_correct + 1) : setIncorrect(m_incorrect + 1);
    if(!m_isMute)
        emit requestAudio(PATH_HOME + "/audio/" + (isTrue ? "" : "in") + "correct.mp3");
    return isTrue;
}

void Game::receiveQuestion(QString question, QString answer)
{
    setQuestion(question);
    setAnswer(answer);
}
