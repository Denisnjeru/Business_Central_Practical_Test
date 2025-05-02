
/// <summary>
/// Page PV Card (ID 52188645).
/// </summary> 
Page 50006 "Payment Voucher Card"
{
    Caption = 'Payment Vouchers';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Approvals,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Payments Header";
    SourceTableView = WHERE("Payment Type" = CONST(Normal));

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = GlobalDimension1CodeEditable;
                    ApplicationArea = all;
                }
                field("Function Name"; Rec."Function Name")
                {
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = ShortcutDimension2CodeEditable;
                    ApplicationArea = all;
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    Caption = 'Description';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Editable = ShortcutDimension3CodeEditable;
                    Visible = false;
                }
                field(Dim3; Rec.Dim3)
                {
                    Caption = 'Description';
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    Editable = ShortcutDimension4CodeEditable;
                    Visible = false;
                }
                field(Dim4; Rec.Dim4)
                {
                    Caption = 'Description';
                    Editable = false;
                    Visible = false;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Editable = PayeeEditable;
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = "Currency CodeEditable";
                    Visible = false;
                }
                field("Paying Account Type"; Rec."Paying Account Type")
                {
                    Editable = PayingBank;
                    ValuesAllowed = "Bank Account", "G/L Account";
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Rec."Paying Bank Account" := '';
                    end;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = all;
                }
                field("Account Name"; Rec."Bank Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Payee; Rec.Payee)
                {
                    Caption = 'Payment to';
                    Editable = PayeeEditable;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ApplicationArea = all;

                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    Editable = OnBehalfEditable;
                    ApplicationArea = all;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    Editable = StatusEditableapproved;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        if Rec."Cheque Type" = Rec."Cheque Type"::"Computer Check" then
                            "Cheque No.Editable" := false
                        else
                            "Cheque No.Editable" := true;
                    end;
                }
                field("Invoice Currency Code"; Rec."Invoice Currency Code")
                {
                    Editable = "Invoice Currency CodeEditable";
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Cashier; Rec.Cashier)
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = all;
                }
                field("Creation Doc No."; Rec."Creation Doc No.")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = all;
                }
                field("Total Payment Amount"; Rec."Total Payment Amount")
                {
                    ApplicationArea = all;
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
                {
                    ApplicationArea = all;
                }
                field("Total VAT Withholding Amount"; Rec."Total VAT Withholding Amount")
                {
                    ApplicationArea = all;
                }
                field("Total Witholding Tax Amount"; Rec."Total Witholding Tax Amount")
                {
                }
                field("Total Retention Amount"; Rec."Total Retention Amount")
                {
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    Caption = 'Cheque/EFT No.';
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //check if the cheque has been inserted
                        Rec.TestField("Paying Bank Account");
                        PVHead.Reset;
                        PVHead.SetRange(PVHead."Paying Bank Account", Rec."Paying Bank Account");
                        PVHead.SetRange(PVHead."Pay Mode", PVHead."Pay Mode"::Cheque);
                        PVHead.SetFilter(PVHead.Status, '<>%1', PVHead.Status::Cancelled);
                        if PVHead.FindFirst then begin
                            repeat
                                if PVHead."Cheque No." = Rec."Cheque No." then begin
                                    if PVHead."No." <> Rec."No." then begin
                                        Error('The Cheque Number has already been utilised by %1', PVHead."No.");
                                    end;
                                end;
                            until PVHead.Next = 0;
                        end;
                    end;
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Editable = StatusEditableapproved;
                    ApplicationArea = All;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
            }
            part(PVLines; "Payment Lines")
            {
                SubPageLink = No = FIELD("No.");
                ApplicationArea = All;
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
                action("Post Payment")
                {
                    Caption = 'Post';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        PHead: Record "Payments Header";
                    begin
                        //check if backdated
                        if Rec."Payment Release Date" > Today then Error('payment release date MUST be Today');

                        //Post PV Entries
                        CurrPage.SaveRecord;
                        CheckPVRequiredItems(Rec);
                        PostPaymentVoucher(Rec);

                        //Print Here
                        // PHead.RESET;

                        // PHead.SETFILTER("No.", Rec."No.");
                        //   REPORT.RUN(Report::"Payment Voucher", TRUE, TRUE, Phead);
                        //  PHead.RESET;
                        // End //Print Here
                    end;
                }
                action("Post PrintPayment")
                {
                    Caption = 'Post/Print';
                    Image = PostPrint;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        PHead: Record "Payments Header";
                    begin
                        //check if backdated
                        if Rec."Payment Release Date" > Today then Error('payment release date MUST be Today');

                        //Post PV Entries
                        CurrPage.SaveRecord;
                        CheckPVRequiredItems(Rec);
                        PostPaymentVoucher(Rec);
                        Commit();
                        //Print Here
                        PHead.RESET;

                        PHead.SETFILTER("No.", Rec."No.");
                        REPORT.RUN(Report::"Payment Voucher", TRUE, TRUE, Phead);
                        PHead.RESET;
                        // End //Print Here
                    end;
                }
                separator(Separator1102755026)
                {
                }

                action("Print preview Member PV")
                {
                    Image = ConfirmAndPrint;
                    ApplicationArea = all;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        Payments.Reset;
                        Payments.SetFilter(Payments."No.", Rec."No.");
                        if Payments.Find('-') then
                            REPORT.Run(51532275, true, false, Payments);
                    end;
                }
                action("Print Cheque")
                {
                    Image = PrintCheck;
                    ApplicationArea = all;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        Payments.Reset;
                        Payments.SetFilter(Payments."No.", Rec."No.");
                        if Payments.Find('-') then
                            REPORT.Run(51532367, true, false, Payments);
                    end;
                }
                separator(Separator1102755009)
                {
                }
                // action("Check Budgetary Availability")
                // {
                //     Caption = 'Check Budgetary Availability';
                //     Image = Balance;
                //     Promoted = true;
                //     ApplicationArea = all;
                //     PromotedCategory = Category5;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     var
                //         BCSetup: Record "Budgetary Control Setup";
                //     begin
                //         if not (Rec.Status = Rec.Status::Open) then begin
                //             Error('Document must be Pending/Open');
                //         end;

                //         BCSetup.Get;
                //         // IF NOT BCSetup.Mandatory THEN
                //         //   EXIT;

                //         if not AllFieldsEntered then
                //             Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                //         if ExtClearancePV then
                //             if Confirm('External Clearance From Loan Detected. Are you sure you want to proceed?') then
                //                 Error('Aborted');
                //         //First Check whether other lines are already committed.
                //         Commitments.Reset;
                //         Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                //         Commitments.SetRange(Commitments."Document No.", Rec."No.");
                //         if Commitments.Find('-') then begin
                //             if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
                //             Commitments.Reset;
                //             Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                //             Commitments.SetRange(Commitments."Document No.", Rec."No.");
                //             Commitments.DeleteAll;
                //         end;

                //         CheckBudgetAvail.CheckPayments(Rec);
                //     end;
                // }
                // action("Cancel Budget Commitment")
                // {
                //     Caption = 'Cancel Budget Commitment';
                //     Image = CancelAllLines;
                //     Promoted = true;
                //     ApplicationArea = all;
                //     PromotedCategory = Category5;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     begin
                //         if not (Rec.Status = Rec.Status::Open) then begin
                //             Error('Document must be Pending/Open');
                //         end;

                //         if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin exit end;

                //         Commitments.Reset;
                //         Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                //         Commitments.SetRange(Commitments."Document No.", Rec."No.");
                //         Commitments.DeleteAll;

                //         PayLine.Reset;
                //         PayLine.SetRange(PayLine.No, Rec."No.");
                //         if PayLine.Find('-') then begin
                //             repeat
                //                 PayLine.Committed := false;
                //                 PayLine.Modify;
                //             until PayLine.Next = 0;
                //         end;
                //     end;
                // }
                separator(Separator1102755033)
                {
                }
                action(Print)
                {
                    Caption = 'Print/Preview';
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //IF Status<>Status::Approved THEN
                        // ERROR('You can only print a Payment Voucher after it is fully Approved');



                        //IF Status=Status::Pending THEN
                        //ERROR('You cannot Print until the document is released for approval');

                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        REPORT.Run(51532234, true, true, Rec);

                        CurrPage.Update;
                        CurrPage.SaveRecord;

                    end;
                }
                action("Vendor Payment Advise")
                {
                    Caption = 'Vendor Payment Advise';
                    Image = "Report";
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Open then
                            Error('You cannot Print until the document is released for approval');
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        REPORT.Run(51532261, true, true, Rec);

                    end;
                }
                action("Cheque Confirmation")
                {
                    Caption = 'Cheque Confirmation';
                    Image = "Report";
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    var
                        FilterbyPayline: Record "Payment Line";
                    begin
                        /*
                        IF Status=Status::Pending THEN
                           ERROR('You cannot Print until the document is released for approval');
                        FilterbyPayline.RESET;
                        FilterbyPayline.SETFILTER(FilterbyPayline.No,"No.");
                        */

                        Bank.Reset;
                        Bank.SetFilter("No.", Rec."Paying Bank Account");
                        if Rec."Payment Release Date" <> 0D then
                            Bank.SetFilter("Date Filter", '%1', Rec."Payment Release Date");
                        REPORT.Run(51532288, true, true, Bank);

                    end;
                }

                separator(Separator1102756005)
                {
                }
                action("ReOpen Document")
                {
                    Caption = 'ReOpen Document';
                    Image = ReOpen;
                    ApplicationArea = all;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if not Confirm('Are you sure you want to reopen this document?') then exit;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
                action("Cancel Document")
                {
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you want to cancel this Document?';
                        Text001: Label 'You have selected not to Cancel the Document';
                    begin
                        if Rec.Status = Rec.Status::Posted then Error('Please reverse this document first');//TESTFIELD(Status,Status::Approved);
                        if Confirm(Text000, true) then begin
                            //Post Reversal Entries for Commitments
                            Doc_Type := Doc_Type::"Payment Voucher";
                            //CheckBudgetAvail.ReverseEntries(Doc_Type, Rec."No.");
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                        end else
                            Error(Text001);
                    end;
                }
            }
            group("Copy Documents")
            {
                Caption = 'Copy Documents';
                action("Copy Invoice")
                {
                    Caption = 'Copy Invoice';
                }
                action("Get Payment Request Lines")
                {
                    Caption = 'Get Payment Request Lines';
                    Image = GetLines;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        RecLines: Record "Payment Line";
                        PaymentsHeader: Record "Payments Header";
                        PaymentsLine: Record "Payment Line";
                    begin


                        CurrPage.Update(true);
                        InsertRequestLines();

                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                // action(SendApprovalRequest)
                // {
                //     Caption = 'Send A&pproval Request';
                //     Enabled = NOT OpenApprovalEntriesExist;
                //     Image = SendApprovalRequest;
                //     Promoted = true;
                //     ApplicationArea = all;
                //     PromotedCategory = Category9;

                //     trigger OnAction()
                //     var
                //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //         CustomApprovals: Codeunit "Custom Approvals Codeunit";
                //     begin
                //         Rec."Payment Release Date" := 0D;
                //         PayLine.Reset;
                //         PayLine.SetRange(No, Rec."No.");
                //         PayLine.SetRange("IsMedical Claim", true);
                //         PayLine.SetRange("Medical Claim No", '');
                //         if PayLine.Find('-') then begin
                //             Error('Medical Claim No Must be selected');
                //         end;

                //         if not LinesExists then
                //             Error('There are no Lines created for this Document');

                //         if not AllFieldsEntered then
                //             Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                //         //Ensure No Items That should be committed that are not
                //         /*if LinesCommitmentStatus then
                //             Error('There are some lines that have not been committed');*/

                //         VarVariant := Rec;
                //         if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                //             CustomApprovals.OnSendDocForApproval(VarVariant);
                //     end;
                // }
                // action(CancelApprovalRequest)
                // {
                //     Caption = 'Cancel Approval Re&quest';
                //     Enabled = OpenApprovalEntriesExist;
                //     Image = Cancel;
                //     Promoted = true;
                //     ApplicationArea = all;
                //     PromotedCategory = Category9;

                //     trigger OnAction()
                //     var
                //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //         CustomApprovals: Codeunit "Custom Approvals Codeunit";
                //     begin
                //         VarVariant := Rec;
                //         CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                //     end;
                // }
            }
            group(Navigate)
            {
                Caption = 'Navigate';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    ApplicationArea = all;
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
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Comment)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    RunPageLink = "Table ID" = CONST(39005498),
                                  "Document No." = FIELD("No.");
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Currpageupdate;
        //CurrPageUpdate;
        UpdateControls;
        SetControlAppearance;
    end;

    trigger OnInit()
    begin
        PVLinesEditable := true;
        DateEditable := true;
        PayeeEditable := true;
        ShortcutDimension2CodeEditable := true;
        ShortcutDimension3CodeEditable := true;
        ShortcutDimension4CodeEditable := true;
        "Payment NarrationEditable" := true;
        GlobalDimension1CodeEditable := true;
        "Currency CodeEditable" := true;
        "Invoice Currency CodeEditable" := true;
        "Cheque TypeEditable" := true;
        "Payment Release DateEditable" := true;
        "Cheque No.Editable" := true;
        UpdateControls;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::Normal;
        //CurrPage.UPDATE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*
         "Responsibility Center" := UserMgt.GetPurchasesFilter();
         //Add dimensions if set by default here
         "Global Dimension 1 Code":=UserMgt.GetSetDimensions(USERID,1);
         VALIDATE("Global Dimension 1 Code");
         "Shortcut Dimension 2 Code":=UserMgt.GetSetDimensions(USERID,2);
         VALIDATE("Shortcut Dimension 2 Code");
         "Shortcut Dimension 3 Code":=UserMgt.GetSetDimensions(USERID,3);
         VALIDATE("Shortcut Dimension 3 Code");
         "Shortcut Dimension 4 Code":=UserMgt.GetSetDimensions(USERID,4);
         VALIDATE("Shortcut Dimension 4 Code");
        */

        //OnAfterGetCurrRecord;
        UpdateControls;

    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        /*
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;
        */

        //UpdatePageControls;
        SetDocNoVisible;

        if Rec.Status = Rec.Status::Approved then
            PayingBank := false
        else
            PayingBank := true;

    end;

    var
        PayLine: Record "Payment Line";
        //PVUsers: Record "W/P Budget Buffer";
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,Loan,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","MSacco Applications","MSacco PinChange","MSacco PhoneChange","MSacco TransChange",BulkSMS,"Payment Voucher","Petty Cash",Imp,Requisition,ImpSurr,Interbank,Receipt,"Staff Claim","Staff Adv",AdvSurr,OT;
        DocPrint: Codeunit "Document-Print";
        CheckLedger: Record "Check Ledger Entry";
        Text001: Label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        CheckManagement: Codeunit CheckManagement;
        Text000: Label 'Do you want to Void Check No %1';
        Text002: Label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';
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
        StatusEditablePending: Boolean;
        PaymodeEditable: Boolean;
        BankEditabl: Boolean;
        OnBehalfEditable: Boolean;
        RespEditabl: Boolean;
        Bank: Record "Bank Account";
        DocNoVisible: Boolean;
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        [InDataSet]
        StatusEditableApproved: Boolean;
        PayingBank: Boolean;
        //Sacco: Codeunit "Sacco Transactions";
        // OtherCommitementsClearance: Record "Other Commitements Clearance";
        ExtClearancePV: Boolean;
        Vendor: Record Vendor;
    //MedicalClaims: Record "HR Medical Claims";

    procedure PostPaymentVoucher(Rec: Record "Payments Header")
    begin
        Temp.Get(UserId);
        JTemplate := Temp."Payment Journal Template";
        JBatch := Temp."Payment Journal Batch";

        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        if GenJnlLine.Find('+') then begin
            LineNo := GenJnlLine."Line No." + 1000;
        end
        else begin
            LineNo := 1000;
        end;
        GenJnlLine.DeleteAll;
        GenJnlLine.Reset;

        Payments.Reset;
        Payments.SetRange(Payments."No.", Rec."No.");
        if Payments.Find('-') then begin
            PayLine.Reset;
            PayLine.SetRange(PayLine.No, Payments."No.");
            PayLine.SetFilter(Amount, '>0');
            if PayLine.Find('-') then begin



                repeat
                    PostHeader(Payments);
                until PayLine.Next = 0;
                //Post Reversal Entries for Commitments
                Doc_Type := Doc_Type::"Payment Voucher";
                //CheckBudgetAvail.ReverseEntries(Doc_Type, Rec."No.");
            end;

        end;
    end;

    /// <summary>
    /// PostHeader.
    /// </summary>
    /// <param name="Payment">VAR Record "Payments Header".</param>
    procedure PostHeader(var Payment: Record "Payments Header")
    begin

        if (Payments."Pay Mode" = Payments."Pay Mode"::Cheque) and (Rec."Cheque Type" = Rec."Cheque Type"::" ") then
            Error('Cheque type has to be specified');

        if Payments."Pay Mode" = Payments."Pay Mode"::Cheque then begin
            if (Payments."Cheque No." = '') and (Rec."Cheque Type" = Rec."Cheque Type"::"Manual Check") then begin
                //ERROR('Please ensure that the cheque number is inserted');
            end;
        end;

        if Payments."Pay Mode" = Payments."Pay Mode"::EFT then begin
            if Payments."Cheque No." = '' then begin
                Error('Please ensure that the EFT number is inserted');
            end;
        end;

        if Payments."Pay Mode" = Payments."Pay Mode"::"Letter of Credit" then begin
            if Payments."Cheque No." = '' then begin
                Error('Please ensure that the Letter of Credit ref no. is entered.');
            end;
        end;

        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        if GenJnlLine.Find('+') then begin
            LineNo := GenJnlLine."Line No." + 1000;
        end
        else begin
            LineNo := 1000;
        end;

        LineNo := LineNo + 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Payment."Payment Release Date";
        GenJnlLine."External Document No." := Payments."Cheque No.";
        GenJnlLine."Document No." := Payments."No.";
#pragma warning disable AL0603
        GenJnlLine."Account Type" := Payments."Paying Account Type";
#pragma warning restore AL0603
        GenJnlLine."Account No." := Payments."Paying Bank Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."Currency Code" := Payments."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        GenJnlLine."Currency Factor" := Payments."Currency Factor";
        GenJnlLine.Validate("Currency Factor");
        Payments.CalcFields("Total Net Amount", "Total VAT Amount", "Total Witholding Tax Amount", "Total VAT Withholding Amount");
        GenJnlLine.Amount := -(Payments."Total Net Amount");
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := Payments."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Payments."Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine."Dimension Set ID" := PayLine."Dimension Set ID";
        GenJnlLine.Description := CopyStr(Rec."Payment Narration", 1, 50);//COPYSTR('Pay To:' + Payments.Payee,1,50);
        GenJnlLine.Validate(GenJnlLine.Description);
        if Rec."Pay Mode" <> Rec."Pay Mode"::Cheque then begin
            GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::" "
        end
        else begin
            if Rec."Cheque Type" = Rec."Cheque Type"::"Computer Check" then
                GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::"Computer Check"
            else
                GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::" "
        end;

        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;


        Payments.CalcFields("Witholding Tax Code", "Vat Witheld Code");
        if (Payments."Total Witholding Tax Amount" > 0) and (Payment."Paying Account Type" <> Payment."Paying Account Type"::"G/L Account") then begin

            //POST W/TAX to Respective W/TAX GL Account
            TarriffCodes.Reset;
            // TarriffCodes.SetRange(Type, TarriffCodes.Type::"W/Tax");
            TarriffCodes.SetRange("Code", Payments."Witholding Tax Code");
            if TarriffCodes.Find('-') then begin
                TarriffCodes.TestField(TarriffCodes."Account No.");
                LineNo := LineNo + 1000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Document No." := Payments."No.";
                GenJnlLine."External Document No." := Payment."Cheque No.";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine."Account No." := TarriffCodes."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");

                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.Validate("Currency Factor");

                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                GenJnlLine."Gen. Bus. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                GenJnlLine.Amount := -Payments."Total Witholding Tax Amount";
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine.Description := CopyStr('W/Tax:' + Format(Payments."Payment Narration"), 1, 50);
                GenJnlLine."Shortcut Dimension 1 Code" := Payments."Global Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := Payments."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");

                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
            end;

        end;




        if (Payments."Total VAT Withholding Amount" > 0) and (Payment."Paying Account Type" <> Payment."Paying Account Type"::"G/L Account") then begin

            ///////////////Post VAT WITHHELD////////////////////////////////////////////////////

            TarriffCodes.Reset;
            //TarriffCodes.SetRange(Type, TarriffCodes.Type::VAT);
            TarriffCodes.SetRange("Code", Payments."Vat Witheld Code");
            if TarriffCodes.Find('-') then begin
                TarriffCodes.TestField(TarriffCodes."Account No.");
                LineNo := LineNo + 1000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";//Payment;
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine."Document No." := Payments."No.";
                //GenJnlLine."External Document No.":=PayLine.No;
                //GenJnlLine."Document No.":=Payments."Cheque No.";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine."Account No." := TarriffCodes."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");
                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                GenJnlLine."Gen. Bus. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                GenJnlLine.Amount := -Payments."Total VAT Withholding Amount";
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Description := CopyStr('W/VAT:' + Format(Payments."Payment Narration"), 1, 50);
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := Payments."Global Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := Payments."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");


                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
            end;


        end;



        PostPV(Payments);
        Rec.Posted := true;
        Rec.Status := Payments.Status::Posted;
        Rec."Posted By" := UserId;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec.Modify;
    end;

    /// <summary>
    /// GetAppliedEntries.
    /// </summary>
    /// <param name="LineNo">VAR Integer.</param>
    /// <returns>Return variable InvText of type Text[100].</returns>
    procedure GetAppliedEntries(var LineNo: Integer) InvText: Text[100]
    begin
        /*
        InvText:='';
        Appl.RESET;
        Appl.SETRANGE(Appl."Document Type",Appl."Document Type"::"0");
        Appl.SETRANGE(Appl."Document No.","No.");
        Appl.SETRANGE(Appl."Line No.",LineNo);
        IF Appl.FINDFIRST THEN
          BEGIN
            REPEAT
              InvText:=COPYSTR(InvText + ',' + Appl."Appl. Doc. No",1,50);
            UNTIL Appl.NEXT=0;
          END;
        */

    end;

    /// <summary>
    /// InsertApproval.
    /// </summary>
    procedure InsertApproval()
    begin
    end;


    /// <summary>
    /// CheckPVRequiredItems.
    /// </summary>
    /// <param name="Rec">Record "Payments Header".</param>
    procedure CheckPVRequiredItems(Rec: Record "Payments Header")
    begin
        if Rec.Posted then begin
            Error('The Document has already been posted');
        end;

        if Rec."Pay Mode" <> Rec."Pay Mode"::"Fosa Account" then
            Rec.TestField("Paying Bank Account");

        Rec.TestField("Pay Mode");
        Rec.TestField("Payment Release Date");
        //Confirm whether Bank Has the Cash
        // if Rec."Pay Mode" = Rec."Pay Mode"::Cash then
        //     CheckBudgetAvail.CheckFundsAvailability(Rec);

        IF Rec."Pay Mode" = Rec."Pay Mode"::Cheque THEN
            Rec.TESTFIELD("Cheque No.");

        //Confirm Payment Release Date is today);
        IF Rec."Pay Mode" = Rec."Pay Mode"::Cash THEN
            Rec.TESTFIELD("Payment Release Date", WORKDATE);

        /*Check if the user has selected all the relevant fields*/
        Temp.Get(UserId);

        JTemplate := Temp."Payment Journal Template";
        JBatch := Temp."Payment Journal Batch";

        if JTemplate = '' then begin
            Error('Ensure the PV Template is set up in Cash Office Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the PV Batch is set up in the Cash Office Setup')
        end;

        if (Rec."Pay Mode" = Rec."Pay Mode"::Cheque) and (Rec."Cheque Type" = Rec."Cheque Type"::"Computer Check") then begin
            if not Confirm(Text002, false) then
                Error('You have selected to Abort PV Posting');
        end;

        //Check whether there is any printed cheques and lines not posted
        CheckLedger.Reset;
        CheckLedger.SetRange(CheckLedger."Document No.", Rec."No.");
        CheckLedger.SetRange(CheckLedger."Entry Status", CheckLedger."Entry Status"::Printed);
        if CheckLedger.Find('-') then begin
            //Ask whether to void the printed cheque
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.FindFirst;
            if Confirm(Text000, false, CheckLedger."Check No.") then
                CheckManagement.VoidCheck(GenJnlLine)
            else
                Error(Text001, Rec."No.", CheckLedger."Check No.");
        end;

    end;

    /// <summary>
    /// PostPV.
    /// </summary>
    /// <param name="Payment">VAR Record "Payments Header".</param>
    procedure PostPV(var Payment: Record "Payments Header")
    var
        PayReqHeader: Record "Payments Header";
    begin
        PayLine.Reset;
        PayLine.SetRange(PayLine.No, Payments."No.");
        if PayLine.Find('-') then begin
            repeat

                strText := GetAppliedEntries(PayLine."Line No.");
                Payment.TestField(Payment.Payee);
                PayLine.TestField(PayLine.Amount);

                //CHEQUE
                LineNo := LineNo + 1000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document No." := Payment."No.";
#pragma warning disable AL0603
                GenJnlLine."Account Type" := PayLine."Account Type";
#pragma warning restore AL0603
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine.Description := CopyStr(PayLine."Account Name", 1, 50);
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.Validate("Currency Factor");
                GenJnlLine.Amount := PayLine.Amount;

                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Job No." := PayLine."Job No.";
                GenJnlLine."Job Task No." := PayLine."Job Task No.";
                if GenJnlLine."Job No." <> '' then
                    GenJnlLine."Job Quantity" := 1;
                GenJnlLine."VAT Prod. Posting Group" := PayLine."VAT Prod. Posting Group";
                GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                // GenJnlLine."Transaction Type" := PayLine."Transaction Type";
                // GenJnlLine."Loan No" := PayLine."Loan No";
                // GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Dimension Set ID" := PayLine."Dimension Set ID";
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Applies-to Doc. No.";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Applies-to ID";
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert();



                ///////////////Post Retentioon////////////////////////////////////////////////////
                if PayLine."Retention  Amount" > 0 then begin

                    TarriffCodes.Reset;
                    TarriffCodes.SetRange(TarriffCodes.Code, PayLine."Retention Code");
                    if TarriffCodes.Find('-') then begin
                        TarriffCodes.TestField(TarriffCodes."Account No.");
                        LineNo := LineNo + 1000;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := JTemplate;
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := JBatch;
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Source Code" := 'PAYMENTJNL';
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Posting Date" := Payment."Payment Release Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";//Payment;
                        GenJnlLine."External Document No." := Payments."Cheque No.";
                        GenJnlLine."Document No." := PayLine.No;
                        // GenJnlLine."Transaction Type" := PayLine."Transaction Type";
                        // GenJnlLine."Loan No" := PayLine."Loan No";
                        // GenJnlLine."External Document No.":=PayLine.No;
                        // GenJnlLine."Document No.":=Payments."Cheque No.";
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                        GenJnlLine."Account No." := TarriffCodes."Account No.";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := Payments."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                        GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine.Amount := -PayLine."Retention  Amount";
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine.Description := CopyStr('RET::' + Format(PayLine."Account Name"), 1, 50);
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    end;
                end;

                //ez
                PayLine."Date Posted" := Today;
                PayLine."Time Posted" := Time;
                PayLine."Posted By" := UserId;
                PayLine.Status := PayLine.Status::Posted;
                PayLine.Modify;



            until PayLine.Next = 0;

            //Post the Journal Lines
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            //Adjust Gen Jnl Exchange Rate Rounding Balances
            AdjustGenJnl.Run(GenJnlLine);
            //End Adjust Gen Jnl Exchange Rate Rounding Balances



            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);

            Post := true;

            if Post then begin
                if PayReqHeader.Get(Rec."Creation Doc No.") then begin
                    PayReqHeader."Date Posted" := Today;
                    PayReqHeader."Time Posted" := Time;
                    PayReqHeader."Posted By" := UserId;
                    PayReqHeader.Status := Rec.Status::Posted;
                    PayReqHeader.Posted := true;
                    PayReqHeader.Modify;
                end;
            end;

        end;

    end;

    procedure UpdatePageControls()
    begin
        if Rec.Status <> Rec.Status::Approved then begin
            "Payment Release DateEditable" := false;
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            //CurrForm."Pay Mode".EDITABLE:=FALSE;
            //CurrForm."Currency Code".EDITABLE:=TRUE;
            "Cheque No.Editable" := false;
            "Cheque TypeEditable" := false;
            "Invoice Currency CodeEditable" := true;
        end else begin
            "Payment Release DateEditable" := true;
            //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
            //CurrForm."Pay Mode".EDITABLE:=TRUE;
            if Rec."Pay Mode" = Rec."Pay Mode"::Cheque then
                "Cheque TypeEditable" := true;
            //CurrForm."Currency Code".EDITABLE:=FALSE;
            if Rec."Cheque Type" <> Rec."Cheque Type"::"Computer Check" then
                "Cheque No.Editable" := true;
            "Invoice Currency CodeEditable" := false;
            PaymodeEditable := true;
            BankEditabl := true;
            OnBehalfEditable := true;
            RespEditabl := true;

        end;
        if Rec.Status = Rec.Status::Open then begin
            "Currency CodeEditable" := true;
            GlobalDimension1CodeEditable := true;
            "Payment NarrationEditable" := true;
            ShortcutDimension2CodeEditable := true;
            PayeeEditable := true;
            ShortcutDimension3CodeEditable := true;
            ShortcutDimension4CodeEditable := true;
            DateEditable := true;
            PaymodeEditable := true;
            BankEditabl := true;
            OnBehalfEditable := true;
            RespEditabl := true;

            PVLinesEditable := true;
        end else begin
            "Currency CodeEditable" := false;
            GlobalDimension1CodeEditable := false;
            "Payment NarrationEditable" := false;
            ShortcutDimension2CodeEditable := false;
            PayeeEditable := true;
            ShortcutDimension3CodeEditable := false;
            ShortcutDimension4CodeEditable := false;
            DateEditable := false;
            PVLinesEditable := false;
        end;

        if Rec.Status = Rec.Status::Posted then begin
            PaymodeEditable := false;
            BankEditabl := false;
            OnBehalfEditable := false;
            RespEditabl := false;
            PVLinesEditable := false;
        end;
    end;

    /// <summary>
    /// LinesExists.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure LinesExists(): Boolean
    var
        PayLines: Record "Payment Line";
    begin
        HasLines := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines.No, Rec."No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;

    /// <summary>
    /// AllFieldsEntered.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Payment Line";
    begin
        AllKeyFieldsEntered := true;
        ExtClearancePV := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines.No, Rec."No.");
        if PayLines.Find('-') then begin
            repeat

                if PayLines."Account Type" = PayLines."Account Type"::Vendor then begin
                    Vendor.Reset;
                    Vendor.SetRange("No.", PayLines."Account No.");

                    /*if Vendor.Find('-') then begin
                        if PayLines."External Clearance Loan No." = '' then Error('External Clearance loan no must be selected');
                        if PayLines."External Clearance Entry" = 0 then Error('External Clearance Entry must be selected');

                    end;*/


                end;
                if (PayLines."Account No." = '') or (PayLines.Amount <= 0) then
                    AllKeyFieldsEntered := false;

                if (PayLines."External Clearance Loan No." <> '') and (PayLines."External Clearance Entry" > 0) then
                    ExtClearancePV := true;

            until PayLines.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    /// <summary>
    /// CustomerPayLinesExist.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure CustomerPayLinesExist(): Boolean
    var
        PayLine: Record "Payment Line";
        PayLine1: Record "Payment Line";
    begin
        PayLine.Reset;
        PayLine.SetRange(PayLine.No, Rec."No.");
        PayLine.SetRange(PayLine."Account Type", PayLine."Account Type"::Customer);
        if PayLine.FindFirst then
            exit(true)
        else begin
            PayLine1.Reset;
            PayLine1.SetRange(PayLine1.No, Rec."No.");
            PayLine1.SetFilter(PayLine1."Net Amount", '<%1', 0);
            if PayLine1.FindFirst then
                exit(true)
            else
                exit(false)
        end
    end;

    local procedure CurrpageupdateOld()
    begin
        xRec := Rec;
        UpdatePageControls();
        CurrPage.Update;
        //Set the filters here
        Rec.SetRange(Posted, false);
        Rec.SetRange("Payment Type", Rec."Payment Type"::Normal);
        Rec.SetFilter(Status, '<>Cancelled');
    end;

    /// <summary>
    /// UpdateControls.
    /// </summary>
    procedure UpdateControls()
    begin
        if Rec.Status = Rec.Status::Open then
            StatusEditablePending := true
        else
            StatusEditablePending := false;

        if Rec.Status = Rec.Status::Approved then
            StatusEditableApproved := true
        else
            StatusEditableApproved := true;
    end;

    /// <summary>
    /// CurrPageUpdate.
    /// </summary>
    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        UpdatePageControls();
        CurrPage.Update;
    end;

    /// <summary>
    /// InsertRequestLines.
    /// </summary>
    procedure InsertRequestLines()
    var
        Counter: Integer;
        Request: Record "Payments Header";
        RequestLines: Record "Payment Line";
        Line: Record "Payment Line";
    begin
        /*
        Request.SETRANGE(Request.Status,Request.Status::Approved);
        IF Request.FINDSET THEN BEGIN
        RequestList.LOOKUPMODE(TRUE);
        RequestList.SETTABLEVIEW(Request);
        IF RequestList.RUNMODAL = ACTION::LookupOK THEN BEGIN
          RequestList.SetSelection(Request);
          Counter := Request.COUNT;
          IF Counter > 0 THEN BEGIN
            IF Request.FINDSET THEN
              REPEAT
                RequestLines.RESET;
                RequestLines.SETRANGE(RequestLines.No,Request."No.");
                RequestLines.FINDSET;
                REPEAT
                  Line.INIT;
                  Line.TRANSFERFIELDS(RequestLines);
                  Line.No:="No.";
                  Line.INSERT(TRUE);
                UNTIL RequestLines.NEXT=0;
               Request.Status:=Status::Posted;
               Request.Posted:=TRUE;
               Request."Date Posted":=TODAY;
               Request."Time Posted":=TIME;
               Request.MODIFY;
             UNTIL Request.NEXT = 0;
          END;
        END;
        END
        */

    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","IB Transfer",EmpTransfer,LeavePlanner,HrAssetTransfer;
    begin
        //DocNoVisible := DocumentNoVisibility.FundsMgtDocumentNoIsVisible(DocType::"Payment Voucher","No.");
    end;

    /// <summary>
    /// CheckReqFields.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure CheckReqFields(): Boolean
    var
        PayLines: Record "Payment Line";
        JobsSetup: Record "Jobs Setup";
        JobPostingGroup: Record "Job Posting Group";
    begin
        AllKeyFieldsEntered := true;
        PayLines.Reset;
        PayLines.SetRange(PayLines.No, Rec."No.");
        if PayLines.Find('-') then begin
            repeat
                if (PayLines."Account No." = '') or (PayLines.Amount <= 0) then
                    AllKeyFieldsEntered := false;

                if JobsSetup.Get then
                    if JobPostingGroup.Get(JobsSetup."Default Job Posting Group") then
                        if PayLines."Account No." = JobPostingGroup."WIP Costs Account" then begin
                            if (PayLines."Job No." = '') or (PayLines."Job Task No." = '') then
                                AllKeyFieldsEntered := false;
                        end

            until PayLines.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

