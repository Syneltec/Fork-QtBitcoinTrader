//  This file is part of Qt Bitcoin Trader
//      https://github.com/JulyIGHOR/QtBitcoinTrader
//  Copyright (C) 2013-2021 July Ighor <julyighor@gmail.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  In addition, as a special exception, the copyright holders give
//  permission to link the code of portions of this program with the
//  OpenSSL library under certain conditions as described in each
//  individual source file, and distribute linked combinations including
//  the two.
//
//  You must obey the GNU General Public License in all respects for all
//  of the code used other than OpenSSL. If you modify file(s) with this
//  exception, you may extend this exception to your version of the
//  file(s), but you are not obligated to do so. If you do not wish to do
//  so, delete this exception statement from your version. If you delete
//  this exception statement from all source files in the program, then
//  also delete it here.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

#include "july/julylightchanges.h"
#include <QApplication>
#include "main.h"

JulyLightChanges::JulyLightChanges(QDoubleSpinBox* parent)
    : QObject()
{
    lastValue = 0.0;
    parentSpinBox = parent;
    setParent(parentSpinBox);
    changeTimer = new QTimer;
    connect(changeTimer, SIGNAL(timeout()), this, SLOT(changeTimerSlot()));
    changeTimer->setSingleShot(true);
    valueChanged(parentSpinBox->value());
    connect(parent, SIGNAL(valueChanged(double)), this, SLOT(valueChanged(double)));
}

JulyLightChanges::~JulyLightChanges()
{
    
        delete changeTimer;
}

void JulyLightChanges::changeTimerSlot()
{
    parentSpinBox->setStyleSheet("");
}

void JulyLightChanges::valueChanged(double val)
{
    changeTimer->stop();

    if (lastValue <= val)
        parentSpinBox->setStyleSheet("QDoubleSpinBox:disabled{color:" + baseValues.appTheme.black.name() + "; background: \"" +
                                     baseValues.appTheme.lightGreen.name() + "\";} QDoubleSpinBox {color:" + baseValues.appTheme.black.name() +
                                     ";background: \"" + baseValues.appTheme.lightGreen.name() + "\";}");
    else
        parentSpinBox->setStyleSheet("QDoubleSpinBox:disabled{color:" + baseValues.appTheme.black.name() + "; background: \"" +
                                     baseValues.appTheme.lightRed.name() + "\";} QDoubleSpinBox {color:" + baseValues.appTheme.black.name() +
                                     ";background: \"" + baseValues.appTheme.lightRed.name() + "\";}");

    lastValue = val;
    changeTimer->start(2000);
}
