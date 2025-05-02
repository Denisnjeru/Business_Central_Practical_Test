namespace DalaDala.DalaDala;

page 50015 "Cash Office User Template"
{
    ApplicationArea = All;
    Caption = 'Cash Office User Template';
    PageType = List;
    SourceTable = "Cash Office User Template";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(UserID; Rec.UserID)
                {
                    ToolTip = 'Specifies the value of the UserID field.', Comment = '%';
                }
                field("Advance  Batch"; Rec."Advance  Batch")
                {
                    ToolTip = 'Specifies the value of the Advance  Batch field.', Comment = '%';
                }
                field("Advance Surr Batch"; Rec."Advance Surr Batch")
                {
                    ToolTip = 'Specifies the value of the Advance Surr Batch field.', Comment = '%';
                }
                field("Advance Surr Template"; Rec."Advance Surr Template")
                {
                    ToolTip = 'Specifies the value of the Advance Surr Template field.', Comment = '%';
                }
                field("Advance Template"; Rec."Advance Template")
                {
                    ToolTip = 'Specifies the value of the Advance Template field.', Comment = '%';
                }
                field("Bank Pay In Journal Batch"; Rec."Bank Pay In Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Bank Pay In Journal Batch field.', Comment = '%';
                }
                field("Bank Pay In Journal Template"; Rec."Bank Pay In Journal Template")
                {
                    ToolTip = 'Specifies the value of the Bank Pay In Journal Template field.', Comment = '%';
                }
                field("Claim  Batch"; Rec."Claim  Batch")
                {
                    ToolTip = 'Specifies the value of the Claim  Batch field.', Comment = '%';
                }
                field("Claim Template"; Rec."Claim Template")
                {
                    ToolTip = 'Specifies the value of the Claim Template field.', Comment = '%';
                }
                field("Default Cash Sale Customer"; Rec."Default Cash Sale Customer")
                {
                    ToolTip = 'Specifies the value of the Default Cash Sale Customer field.', Comment = '%';
                }
                field("Default Payment Bank"; Rec."Default Payment Bank")
                {
                    ToolTip = 'Specifies the value of the Default Payment Bank field.', Comment = '%';
                }
                field("Default Petty Cash Bank"; Rec."Default Petty Cash Bank")
                {
                    ToolTip = 'Specifies the value of the Default Petty Cash Bank field.', Comment = '%';
                }
                field("Default Receipts Bank"; Rec."Default Receipts Bank")
                {
                    ToolTip = 'Specifies the value of the Default Receipts Bank field.', Comment = '%';
                }
                field("Dim Change Journal Batch"; Rec."Dim Change Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Dim Change Journal Batch field.', Comment = '%';
                }
                field("Dim Change Journal Template"; Rec."Dim Change Journal Template")
                {
                    ToolTip = 'Specifies the value of the Dim Change Journal Template field.', Comment = '%';
                }
                field("Imprest  Batch"; Rec."Imprest  Batch")
                {
                    ToolTip = 'Specifies the value of the Imprest  Batch field.', Comment = '%';
                }
                field("Imprest Template"; Rec."Imprest Template")
                {
                    ToolTip = 'Specifies the value of the Imprest Template field.', Comment = '%';
                }
                field("Inter Bank Batch Name"; Rec."Inter Bank Batch Name")
                {
                    ToolTip = 'Specifies the value of the Inter Bank Batch Name field.', Comment = '%';
                }
                field("Inter Bank Template Name"; Rec."Inter Bank Template Name")
                {
                    ToolTip = 'Specifies the value of the Inter Bank Template Name field.', Comment = '%';
                }
                field("Journal Voucher Batch"; Rec."Journal Voucher Batch")
                {
                    ToolTip = 'Specifies the value of the Journal Voucher Batch field.', Comment = '%';
                }
                field("Journal Voucher Template"; Rec."Journal Voucher Template")
                {
                    ToolTip = 'Specifies the value of the Journal Voucher Template field.', Comment = '%';
                }
                field("Max. Cash Collection"; Rec."Max. Cash Collection")
                {
                    ToolTip = 'Specifies the value of the Max. Cash Collection field.', Comment = '%';
                }
                field("Max. Cheque Collection"; Rec."Max. Cheque Collection")
                {
                    ToolTip = 'Specifies the value of the Max. Cheque Collection field.', Comment = '%';
                }
                field("Max. Deposit Slip Collection"; Rec."Max. Deposit Slip Collection")
                {
                    ToolTip = 'Specifies the value of the Max. Deposit Slip Collection field.', Comment = '%';
                }
                field("Payment Journal Batch"; Rec."Payment Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Payment Journal Batch field.', Comment = '%';
                }
                field("Payment Journal Template"; Rec."Payment Journal Template")
                {
                    ToolTip = 'Specifies the value of the Payment Journal Template field.', Comment = '%';
                }
                field("Petty Cash Batch"; Rec."Petty Cash Batch")
                {
                    ToolTip = 'Specifies the value of the Petty Cash Batch field.', Comment = '%';
                }
                field("Petty Cash Template"; Rec."Petty Cash Template")
                {
                    ToolTip = 'Specifies the value of the Petty Cash Template field.', Comment = '%';
                }
                field("Receipt Journal Batch"; Rec."Receipt Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Receipt Journal Batch field.', Comment = '%';
                }
                field("Receipt Journal Template"; Rec."Receipt Journal Template")
                {
                    ToolTip = 'Specifies the value of the Receipt Journal Template field.', Comment = '%';
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ToolTip = 'Specifies the value of the Supervisor ID field.', Comment = '%';
                }
                field("Surrender  Batch"; Rec."Surrender  Batch")
                {
                    ToolTip = 'Specifies the value of the Surrender  Batch field.', Comment = '%';
                }
                field("Surrender Template"; Rec."Surrender Template")
                {
                    ToolTip = 'Specifies the value of the Surrender Template field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }

            }
        }
    }
}
