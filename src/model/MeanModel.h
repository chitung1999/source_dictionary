#ifndef MEANMODEL_H
#define MEANMODEL_H

#include <QAbstractListModel>

struct MeanItem {
    MeanItem(){}
    MeanItem(QString p, QString s, QString a, QList<QString> d) {
        part = p;
        synonyms = s;
        antonyms = a;
        definitions = d;
    }
    QString part;
    QString synonyms;
    QString antonyms;
    QList <QString> definitions;
};

class MeanModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit MeanModel(QObject *parent = nullptr);

    enum MeanRoles {
        PartRole = Qt::UserRole + 1,
        SynonymsRole,
        AntonymsRole,
        DefinitionsRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;

    void append(MeanItem item);
    void clear();

protected:
    QHash<int, QByteArray> roleNames() const override;
private:
    QList<MeanItem> m_listMean;
};

#endif // MEANMODEL_H
