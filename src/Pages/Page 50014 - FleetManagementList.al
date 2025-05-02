namespace DalaDala.DalaDala;

page 50014 "Fleet Management List"
{
    ApplicationArea = All;
    Caption = 'Fleet Management List';
    PageType = List;
    SourceTable = "Fleet Management Header";
    CardPageID = "fleet management card";
    DeleteAllowed = false;
    Editable = false;

    SourceTableView = where(Posted = const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(PostingDate; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Cashier; Cashier)
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; "Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field(AmountRecieved; "Amount Recieved")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque/Deposit Slip No"; "Cheque/Deposit Slip No")
                {
                    ApplicationArea = Basic;
                }

            }
        }
    }

    actions
    {
    }
    trigger OnOPenPage()
    var
        myInt: Integer;
    begin
        SetRange(Cashier, UserId);
    end;
}


