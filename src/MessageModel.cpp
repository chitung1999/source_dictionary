#include "MessageModel.h"

MessageModel::MessageModel(QObject *parent) : QAbstractListModel(parent)
{
}

int MessageModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
        return m_listMessage.count();
}

QVariant MessageModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_listMessage.count())
        return QVariant();

    const MessageItem &msg = m_listMessage[index.row()];

    if (role == NameRole)
        return msg.name;
    else if (role == MessageRole)
        return msg.message;
    else if (role == IsCurrentClientRole) {
        return msg.isCurrentClient;
    }

    return QVariant();
}

void MessageModel::append(MessageItem item)
{
    m_listMessage.append(item);
}

QHash<int, QByteArray> MessageModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[MessageRole] = "message";
    roles[IsCurrentClientRole] = "isCurrentClient";
    return roles;
}
