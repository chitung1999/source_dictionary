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
public:
    explicit Grammar(QObject *parent = nullptr);

    void initialize(const QJsonArray &data);

    enum GrammarRoles {
        FormRole = Qt::UserRole + 1,
        StructureRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;

    void requestAppend();
    void removeAt(int index);
    void modify(int index, GrammarItem item);
    void update();

protected:
    QHash<int, QByteArray> roleNames() const override;
private:
    QList<GrammarItem> m_listGrammar;
};

#endif // GRAMMAR_H
