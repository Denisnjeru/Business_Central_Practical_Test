/// <summary>
/// Unknown DalaDala.
/// </summary>

namespace DalaDala.DalaDala;

using Microsoft.Finance.GeneralLedger.Account;

tableextension 50003 "G/L Account" extends "G/L Account"
{
    fields
    {
        field(51532000; "Budget Controlled"; Boolean)
        {
            Caption = 'Budget Controlled';
            DataClassification = ToBeClassified;

        }
        field(51532001; "Expense Code"; Code[20])
        {
            Caption = 'Expense Code';
            DataClassification = ToBeClassified;
        }
        field(51532002; "Budget Control Account"; Code[20])
        {
            Caption = 'Budget Control Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51532003; "Allow Cashier Transactions"; Boolean)
        {
        }
    }
}
