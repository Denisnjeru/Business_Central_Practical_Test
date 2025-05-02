
Page 50010 "Posted Payment Vouchers List"
{
    ApplicationArea = Basic;
    CardPageID = "Posted Payment Header";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Payments Header";
    SourceTableView = WHERE("Payment Type" = FILTER(<> "Petty Cash" & <> "Benevolent Claim"),
                            Posted = CONST(true));
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
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
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755014; Notes)
            {
            }
            systempart(Control1102755015; MyNotes)
            {
            }
            systempart(Control1102755016; Outlook)
            {
            }
            systempart(Control1102755017; Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1102755006>")
            {
                Caption = '&Functions';
                action(Print)
                {
                    Caption = 'Print/Preview';
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

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
                action("Vendor Payment Advise")
                {
                    Caption = 'Vendor Payment Advise';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

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
                    Promoted = true;
                    PromotedCategory = "Report";

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
                separator(Separator1102755019)
                {
                }
            }
            group(Navigate)
            {
                Caption = 'Navigate';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*
                        DocumentType := DocumentType::"Payment Voucher";
                        ApprovalEntries.Setfilters(DATABASE::"Payments Header","Document Type","No.");
                        ApprovalEntries.RUN;
                        */
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)

                    end;
                }
            }
        }
    }


    trigger OnOpenPage()
    begin
    end;

    var
        PayLine: Record "Payment Line";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments: Record "Payments Header";
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Code s";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cash Office User Template";
        LineNo: Integer;
        Temp: Record "Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        //PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        strText: Text[100];
        PVHead: Record "Payments Header";
        BankAcc: Record "Bank Account";
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,Load,Discharge,"Express Pv";
        DocPrint: Codeunit "Document-Print";
        CheckLedger: Record "Check Ledger Entry";
        CheckManagement: Codeunit CheckManagement;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
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
        Text001: Label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        Text000: Label 'Do you want to Void Check No %1';
        Text002: Label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';


    procedure PostPaymentVoucher()
    begin
    end;

    procedure PostHeader(var Payment: Record "Payments Header")
    begin
    end;


    procedure InsertApproval()
    begin
    end;


    procedure CheckPVRequiredItems()
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
}

