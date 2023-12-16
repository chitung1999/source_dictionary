#ifndef MESSAGEMODEL_H
#define MESSAGEMODEL_H

#include <QAbstractListModel>

struct MessageItem {
    MessageItem(QString n, QString m, bool c) {
        name = n;
        message = m;
        isCurrentClient = c;
    }
    QString name;
    QString message;
    bool isCurrentClient;
};

class MessageModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit MessageModel(QObject *parent = nullptr);

    enum MessageRoles {
        NameRole = Qt::UserRole + 1,
        MessageRole,
        IsCurrentClientRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;

    void append(MessageItem item);
    int length();

protected:
    QHash<int, QByteArray> roleNames() const override;
private:
    QList<MessageItem> m_listMessage;
};

#endif // MESSAGEMODEL_H
