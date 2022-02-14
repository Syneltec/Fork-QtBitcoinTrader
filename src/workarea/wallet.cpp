#include "wallet.h"
#include "ui_wallet.h"

Wallet::Wallet(QWidget *parent) :
    QTabWidget(parent),
    ui(new Ui::Wallet)
{
    ui->setupUi(this);
}

Wallet::~Wallet()
{
    delete ui;
}
