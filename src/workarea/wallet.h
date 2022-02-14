#ifndef WALLET_H
#define WALLET_H

#include <QTabWidget>

namespace Ui {
class Wallet;
}

class Wallet : public QTabWidget
{
    Q_OBJECT

public:
    explicit Wallet(QWidget *parent = nullptr);
    ~Wallet();

private:
    Ui::Wallet *ui;
};

#endif // WALLET_H
