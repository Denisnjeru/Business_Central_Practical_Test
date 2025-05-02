/// <summary>
/// Unknown DalaDala.
/// </summary>

namespace DalaDala.DalaDala;
using Microsoft.Finance.GeneralLedger.Ledger;

page 50011 "Posted Payment Header"
{
    ApplicationArea = All;
    Caption = 'Posted Payment Header';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Payments Header";
    SourceTableView = WHERE("Payment Type" = FILTER(<> "Petty Cash"),
                            Posted = CONST(true));

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Editable = DateEditable;
                    Importance = Promoted;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = GlobalDimension1CodeEditable;
                }
                field("Function Name"; Rec."Function Name")
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = ShortcutDimension2CodeEditable;
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Editable = ShortcutDimension3CodeEditable;
                    Visible = false;
                }
                field(Dim3; Rec.Dim3)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    Editable = ShortcutDimension4CodeEditable;
                    Visible = false;
                }
                field(Dim4; Rec.Dim4)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    Editable = false;
                    Visible = false;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = All;
                    Editable = PaymodeEditable;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Editable = "Currency CodeEditable";
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = All;
                    Editable = bankeditabl;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = All;
                    Caption = 'Payment to';
                    Editable = PayeeEditable;
                    Importance = Promoted;
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ApplicationArea = All;
                    Editable = OnBehalfEditable;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    ApplicationArea = All;
                    Editable = "Cheque TypeEditable";
                }
                field("Invoice Currency Code"; Rec."Invoice Currency Code")
                {
                    ApplicationArea = All;
                    Editable = "Invoice Currency CodeEditable";
                    Visible = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Payment Amount"; Rec."Total Payment Amount")
                {
                    ApplicationArea = All;
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("Total VAT Withholding Amount"; Rec."Total VAT Withholding Amount")
                {
                    ApplicationArea = All;
                }
                field("Total Witholding Tax Amount"; Rec."Total Witholding Tax Amount")
                {
                    ApplicationArea = All;
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    ApplicationArea = All;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = All;
                    Caption = 'Cheque/EFT No.';
                    Editable = "Cheque No.Editable";
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    ApplicationArea = All;
                    Editable = "Payment Release DateEditable";
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
            }
            part(PVLines; "Payment Lines")
            {
                ApplicationArea = All;
                SubPageLink = No = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action(Print)
                {
                    Caption = 'Print/Preview';
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // IF Status<>Status::Approved THEN
                        //   ERROR('You can only print a Payment Voucher after it is fully Approved');



                        //IF Status=Status::Pending THEN
                        //ERROR('You cannot Print until the document is released for approval');
                        PVHead.Reset;
                        PVHead.SetFilter("No.", Rec."No.");
                        REPORT.Run(51532234, true, true, PVHead);
                    end;
                }
                action(PrintCheque)
                {
                    Caption = 'Print Cheque';
                    Image = PrintCheck;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        PVHead.Reset;
                        PVHead.SetFilter("No.", Rec."No.");
                        REPORT.Run(51532367, true, true, PVHead);
                    end;
                }
                action("Vendor Payment Advise")
                {
                    Caption = 'Vendor Payment Advise';
                    Image = "Report";
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Open then
                            Error('You cannot Print until the document is released for approval');
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        REPORT.Run(51532261, true, true, Rec);
                        Rec.Reset;
                    end;
                }
                action("Cheque Confirmation")
                {
                    Caption = 'Cheque Confirmation';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";

                    trigger OnAction()
                    var
                        FilterbyPayline: Record "Payment Line";
                    begin
                        if Rec.Status = Rec.Status::Open then
                            Error('You cannot Print until the document is released for approval');
                        /*
                        FilterbyPayline.RESET;
                        FilterbyPayline.SETFILTER(FilterbyPayline.No,"No.");
                        */
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        REPORT.Run(51532288, true, true, Rec);
                        Rec.Reset;

                    end;
                }

                separator(Separator1102756005)
                {
                }
                action("Cancel Document")
                {
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you want to cancel this Document?';
                        Text001: Label 'You have selected not to Cancel the Document';
                        GLEntry: Record "G/L Entry";
                    begin
                        /*
                        TESTFIELD(Status,Status::Approved);
                        IF CONFIRM(Text000,TRUE) THEN  BEGIN
                        //Post Reversal Entries for Commitments
                        Doc_Type:=Doc_Type::"Payment Voucher";
                        CheckBudgetAvail.ReverseEntries(Doc_Type,"No.");
                        Status:=Status::Cancelled;
                        MODIFY;
                        END ELSE
                          ERROR(Text001);
                        */
                        if not Confirm(Text000, true) then exit;
                        //check if reversals exist
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."Document No.", Rec."No.");
                        GLEntry.SetRange(GLEntry.Reversed, true);
                        if not GLEntry.FindSet then
                            Error('Reverse The document entries first')
                        else begin
                            //Post Committment Reversals
                            Doc_Type := Doc_Type::"Payment Voucher";
                            //CheckBudgetAvail.ReverseEntries(Doc_Type, Rec."No.");
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                        end

                    end;
                }
            }
            group("Copy Documents")
            {
                Caption = 'Copy Documents';
                action("Copy Loan")
                {
                    Caption = 'Copy Loan';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        /*prAssignEmp.RESET;
                        prAssignEmp.SETRANGE(prAssignEmp.Status,prAssignEmp.Status::"3");
                        IF prAssignEmp.FINDSET THEN
                        IF PAGE.RUNMODAL(39005545,prAssignEmp)=ACTION::LookupOK THEN
                        InsertPvLine(prAssignEmp);
                         */

                    end;
                }
                action("Copy Invoice")
                {
                    Caption = 'Copy Invoice';
                }
            }
            group(Navigate)
            {
                Caption = 'Navigate';
            }
        }
    }

    var
        PayLine: Record "Payment Line";
        //PVUsers: Record "W/P Budget Buffer";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments: Record "Payments Header";
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Code s";
        CashierLinks: Record "Cash Office User Template";
        LineNo: Integer;
        Temp: Record "Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        //PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        strText: Text[100];
        PVHead: Record "Payments Header";
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,Load,Discharge,"Express Pv";
        Text001: Label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        Text000: Label 'Do you want to Void Check No %1';
        Text002: Label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        [InDataSet]
        "Cheque No.Editable": Boolean;
        [InDataSet]
        "Payment Release DateEditable": Boolean;
        [InDataSet]
        "Cheque TypeEditable": Boolean;
        [InDataSet]
        "Invoice Currency CodeEditable": Boolean;
        [InDataSet]
        "Currency CodeEditable": Boolean;
        [InDataSet]
        GlobalDimension1CodeEditable: Boolean;
        [InDataSet]
        "Payment NarrationEditable": Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        [InDataSet]
        PayeeEditable: Boolean;
        [InDataSet]
        ShortcutDimension3CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension4CodeEditable: Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        PVLinesEditable: Boolean;
        StatusEditable: Boolean;
        PaymodeEditable: Boolean;
        BankEditabl: Boolean;
        OnBehalfEditable: Boolean;
        RespEditabl: Boolean;

    procedure PostPaymentVoucher(Rec: Record "Payments Header")
    begin
    end;

    procedure PostHeader(var Payment: Record "Payments Header")
    begin
    end;

    procedure GetAppliedEntries(var LineNo: Integer) InvText: Text[100]
    begin
    end;

    procedure InsertApproval()
    begin
    end;

    procedure LinesCommitmentStatus() Exists: Boolean

    begin
    end;

    procedure CheckPVRequiredItems(Rec: Record "Payments Header")
    begin
    end;

    procedure PostPV(var Payment: Record "Payments Header")
    begin
    end;

    procedure UpdatePageControls()
    begin
    end;

    procedure LinesExists(): Boolean
    var
        PayLines: Record "Payment Line";
    begin
    end;

    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Payment Line";
    begin
    end;

    procedure CustomerPayLinesExist(): Boolean
    var
        PayLine: Record "Payment Line";
    begin
    end;

    local procedure CurrpageupdateOld()
    begin
    end;

    procedure UpdateControls()
    begin
    end;

    procedure CurrPageUpdate()
    begin
    end;
}
