#ifndef GRAMMAR_H
#define GRAMMAR_H

#include <QAbstractListModel>
#include <QDebug>
#include <QJsonArray>
#include <QJsonObject>
#include "../common/Define.h"

struct GrammarItem {
    GrammarItem() {}
    GrammarItem(QString f, QString s) {
        form = f;
        structure = s;
    }
    QString form;
    QString structure;
};

class Grammar : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int result       READ result         WRITE setResult         NOTIFY resultChanged)
    Q_PROPERTY(double posScroll READ posScroll      WRITE setPosScroll    NOTIFY posScrollChanged)
public:
    explicit Grammar(QObject *parent = nullptr);

    void initialize(const QJsonArray &data);

    enum GrammarRoles {
        FormRole = Qt::UserRole + 1,
        StructureRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;

    const int &result() const;
    void setResult(const int newResult);

    const double &posScroll() const;
    void setPosScroll(const double newPosScroll);

    void requestAppend();
    void removeAt(int index);
    void modify(int index, GrammarItem item);
    void update();

signals:
    void resultChanged();
    void posScrollChanged();

public slots:
    QList<int> search(QString str);

protected:
    QHash<int, QByteArray> roleNames() const override;
private:
    QList<GrammarItem> m_listGrammar;
    double m_posScroll;
    int m_result;
};

#endif // GRAMMAR_H
