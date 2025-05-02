
/// <summary>
/// Page Payment Line (ID 50008).
/// </summary>

Page 50008 "Payment Lines"
{
    PageType = ListPart;
    SourceTable = "Payment Line";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Caption = 'Description';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Medical Claim No"; Rec."Medical Claim No")
                {
                }
                field("Payment Account"; Rec."Payment Account")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Payment Account Name"; Rec."Payment Account Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Account Payment Type"; Rec."Account Payment Type")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //check if the payment reference is for farmer purchase
                        if Rec."Payment Reference" = Rec."Payment Reference"::"Farmer Purchase" then begin
                            if Rec.Amount <> xRec.Amount then begin
                                Error('Amount cannot be modified');
                            end;
                        end;

                        Rec."Amount With VAT" := Rec.Amount;


                    end;
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("VAT Withholding Code"; Rec."VAT Withholding Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Withholding Amount"; Rec."VAT Withholding Amount")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    ApplicationArea = All;
                }
                field("Retention Code"; Rec."Retention Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Retention  Amount"; Rec."Retention  Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                }

                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = all;
                }
                field("Budgetary Control A/C"; Rec."Budgetary Control A/C")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    ShowCaption = false;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    ShowCaption = false;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    ShowCaption = false;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    ShowCaption = false;
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    ShowCaption = false;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    ShowCaption = false;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    Visible = false;
                    ApplicationArea = all;
                }

                field(Narration; Rec.Narration)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    var
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Code s";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        CustLedger: Record "Vendor Ledger Entry";
        CustLedger1: Record "Vendor Ledger Entry";
        Amt: Decimal;
        TotAmt: Decimal;
        ApplyInvoice: Codeunit "Purchase Header Apply";
        VendEntries: Record "Vendor Ledger Entry";
        PInv: Record "Purch. Inv. Header";
        VATPaid: Decimal;
        VATToPay: Decimal;
        PInvLine: Record "Purch. Inv. Line";
        VATBase: Decimal;
        ShortcutDimCode: array[8] of Code[20];
}

