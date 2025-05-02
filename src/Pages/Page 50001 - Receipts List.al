
/// <summary>
/// Page Receipts List (ID 50001).
/// </summary>

Page 50001 "Receipts List"
{
    ApplicationArea = Basic;
    CardPageID = "Receipt Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Receipt Header";
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
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(AmountRecieved; Rec."Amount Recieved")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque/Deposit Slip No"; Rec."Cheque/Deposit Slip No")
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

    begin
        Rec.SetRange(Cashier, UserId);
    end;
}

