#include "Grammar.h"

Grammar::Grammar(QObject *parent) : QAbstractListModel(parent)
{
}

void Grammar::initialize(const QJsonArray &data)
{
    if(data.isEmpty())
        return;

    beginResetModel();
    foreach (QJsonValue value, data) {
        GrammarItem item;
        item.form = value.toObject()["form"].toString();
        item.structure = value.toObject()["structure"].toString();
        m_listGrammar.append(item);
    }
    endResetModel();
}

int Grammar::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_listGrammar.count();
}

QVariant Grammar::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_listGrammar.count())
        return QVariant();

    const GrammarItem &item = m_listGrammar[index.row()];

    switch (role) {
    case FormRole:
        return item.form;
    case StructureRole:
        return item.structure;
    default:
        return QVariant();
    }
}

void Grammar::requestAppend() {
    beginInsertRows(QModelIndex(), m_listGrammar.count(), m_listGrammar.count());
    m_listGrammar.append(GrammarItem());
    endInsertRows();
}

void Grammar::removeAt(int index)
{
    if(index < 0 || index >= m_listGrammar.length())
        return;
    beginRemoveRows(QModelIndex(), index, index);
    m_listGrammar.removeAt(index);
    endRemoveRows();
}

void Grammar::modify(int index, GrammarItem item)
{
    if(index < 0 || index > m_listGrammar.length()) {
        return;
    }

    if (index == m_listGrammar.length()) {
        m_listGrammar.replace(m_listGrammar.length() - 1, item);
    } else {
        m_listGrammar.replace(index, item);
    }
}

void Grammar::update()
{
    endResetModel();
}

QHash<int, QByteArray> Grammar::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[FormRole] = "form";
    roles[StructureRole] = "structure";
    return roles;
}
