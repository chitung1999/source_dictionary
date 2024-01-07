#ifndef NOTEMODEL_H
#define NOTEMODEL_H

#include <QAbstractListModel>

struct NoteItem {
    NoteItem(){}
    NoteItem(int i, QStringList w, QStringList m, QString n) {
        index = i;
        words = w;
        means = m;
        notes = n;
    }
    int index;
    QStringList words;
    QStringList means;
    QString notes;
};

class NoteModel: public QAbstractListModel
{
    Q_OBJECT
public:
    explicit NoteModel(QObject *parent = nullptr);

    enum MeanRoles {
        IndexRole = Qt::UserRole + 1,
        WordsRole,
        MeansRole,
        NotesRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;

    void append(NoteItem item);
    void removeAt(int index);
    void replace(int index, NoteItem &item);
    void clear();

protected:
    QHash<int, QByteArray> roleNames() const override;
private:
    QList<NoteItem> m_listNote;
};

#endif // NOTEMODEL_H
