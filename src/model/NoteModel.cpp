#include "NoteModel.h"

NoteModel::NoteModel(QObject *parent) : QAbstractListModel(parent)
{
}

int NoteModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_listNote.count();
}

QVariant NoteModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_listNote.count())
        return QVariant();

    const NoteItem &item = m_listNote[index.row()];

    switch (role) {
    case IndexRole:
        return item.index;
    case WordsRole:
        return item.words;
    case MeansRole:
        return item.means;
    case NotesRole:
        return item.notes;
    default:
        return QVariant();
    }
}

void NoteModel::append(NoteItem item)
{
    beginInsertRows(QModelIndex(), m_listNote.count(), m_listNote.count());
    m_listNote.append(item);
    endInsertRows();
}

void NoteModel::removeAt(int index)
{
    beginResetModel();
    for(int i = 0; i < m_listNote.length(); i++) {
        if (index == m_listNote[i].index)
            m_listNote.removeAt(i);
    }
    endResetModel();
}

void NoteModel::replace(int index, NoteItem &item)
{
    beginResetModel();
    for(int i = 0; i < m_listNote.length(); i++) {
        if (index == m_listNote[i].index)
            m_listNote.replace(i, item);
    }
    endResetModel();
}

void NoteModel::clear()
{
    beginResetModel();
    m_listNote.clear();
    endResetModel();
}

QHash<int, QByteArray> NoteModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IndexRole] = "index";
    roles[WordsRole] = "words";
    roles[MeansRole] = "means";
    roles[NotesRole] = "notes";
    return roles;
}
