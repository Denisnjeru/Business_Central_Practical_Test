namespace DalaDala.DalaDala;

page 50013 "Fleet Management Lines"
{
    ApplicationArea = All;
    Caption = 'Fleet Management Lines';
    PageType = ListPart;
    SourceTable = "Document Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Receipts and Payment Types" where(Type = const("Fleet Mgt"));
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Vehicle No.';
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(TaxableAmount; Rec."Taxable Amount")
                {
                    ApplicationArea = Basic;
                }

                field(TaxAmount; Rec."Tax Amount")
                {
                    ApplicationArea = Basic;
                }
                field(WithholdingTax; Rec."Withholding Tax")
                {
                    ApplicationArea = Basic;
                }
                field(VATAmount; Rec."VAT Amount")
                {
                    ApplicationArea = Basic;
                }
                field(WithholdingVAT; Rec."Withholding VAT")
                {
                    ApplicationArea = Basic;
                }

                field(NetAmount; Rec."Net Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var

        ReceiptHeader: Record "Receipt Header";
}


