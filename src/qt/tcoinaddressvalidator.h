// Copyright (c) 2011-2014 The Tcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef TCOIN_QT_TCOINADDRESSVALIDATOR_H
#define TCOIN_QT_TCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class TcoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit TcoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Tcoin address widget validator, checks for a valid tcoin address.
 */
class TcoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit TcoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // TCOIN_QT_TCOINADDRESSVALIDATOR_H
