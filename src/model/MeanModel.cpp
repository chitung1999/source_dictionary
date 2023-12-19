#include "MeanModel.h"

MeanModel::MeanModel(QObject *parent) : QAbstractListModel(parent)
{
}

int MeanModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_listMean.count();
}

QVariant MeanModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_listMean.count())
        return QVariant();

    const MeanItem &item = m_listMean[index.row()];

    switch (role) {
    case PartRole:
        return item.part;
    case SynonymsRole:
        return item.synonyms;
    case AntonymsRole:
        return item.antonyms;
    case DefinitionsRole:
        return QVariant::fromValue(item.definitions);
    default:
        return QVariant();
    }
}

void MeanModel::append(MeanItem item)
{
    beginInsertRows(QModelIndex(), m_listMean.count(), m_listMean.count());
    m_listMean.append(item);
    endInsertRows();
}

void MeanModel::clear()
{
    beginResetModel();
    m_listMean.clear();
    endResetModel();
}

QHash<int, QByteArray> MeanModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[PartRole] = "part";
    roles[SynonymsRole] = "synonyms";
    roles[AntonymsRole] = "antonyms";
    roles[DefinitionsRole] = "definitions";
    return roles;
}
