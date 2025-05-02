
/// <summary>
/// Page Receipt and Payment Types List (ID 50004).
/// </summary>

Page 50004 "Receipt and Payment Types List"
{
    PageType = List;
    SourceTable = "Receipts and Payment Types";

    layout
    {
        area(content)
        {
            repeater(Control1102758000)
            {
                ShowCaption = false;

                field("Code"; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = all;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("VAT Chargeable"; Rec."VAT Chargeable")
                {
                    ApplicationArea = all;
                }
                field("Withholding Tax Chargeable"; Rec."Withholding Tax Chargeable")
                {
                    ApplicationArea = all;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ApplicationArea = all;
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ApplicationArea = all;
                }
                field("VAT Withholding Code"; Rec."VAT Withholding Code")
                {
                    ApplicationArea = all;
                }
                field("Default Grouping"; Rec."Default Grouping")
                {
                    ApplicationArea = all;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = all;
                }
                field("Pending Voucher"; Rec."Pending Voucher")
                {
                }
                field("Bank Account"; Rec."Bank Account")
                {
                }
                field("Transation Remarks"; Rec."Transation Remarks")
                {
                }
                field("Direct Expense"; Rec."Direct Expense")
                {
                }
                field("Is Medical Claim"; Rec."Is Medical Claim")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}

