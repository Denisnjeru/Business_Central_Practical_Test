namespace DalaDala.DalaDala;
using Microsoft.FixedAssets.FixedAsset;

page 50012 "Fleet Management Card"
{
    ApplicationArea = All;
    Caption = 'Fleet Management Card';
    PageType = Card;
    SourceTable = "Fleet Management Header";
    PromotedActionCategories = 'New,Process,Report,Post Receipt,Suggest,Send Notification,Print';


    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                }

                field("Date Created"; "Date Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(PostingDate; "Posting Date")
                {
                    ApplicationArea = Basic;

                }
                field(MemberNo; "Customer No.")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Fixed Asset List";
                }

                field(CustomerName; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(Narration; Narration)
                {
                    ApplicationArea = Basic;
                }
                field("Received From"; "Received From")
                {
                    ApplicationArea = Basic;
                }

                field("External Document No"; "External Document No")
                {
                    ApplicationArea = Basic;
                }

                field(AmountRecieved; "Amount Recieved")
                {
                    ApplicationArea = Basic;
                }
                field(TotalAmount; "Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(BankCode; "Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field(BankName; "Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field(PayMode; "Pay Mode")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        SlipMandatory := false;
                        if "Pay Mode" <> "Pay Mode"::Cash then SlipMandatory := true
                    end;
                }
                field(ChequeNo; "Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit Slip No"; "Cheque/Deposit Slip No")
                {
                    ApplicationArea = Basic;
                    Caption = 'EFT/Deposit Slip No.';
                    ShowMandatory = SlipMandatory;
                    //From the table, cheque No is also the deposit/slip no.
                }
                field("ChequeDate"; "Cheque/Deposit Slip Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque Date';
                }

                field(GlobalDimension1Code; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(CreatedBy; "Created By")
                {
                    ApplicationArea = Basic;
                }
                field(CreatedDateTime; "Created Date Time")
                {
                    ApplicationArea = Basic;
                }
                field(Cashier; Cashier)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; "Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(TimePosted; "Time Posted")
                {
                    ApplicationArea = Basic;
                }


                field(PostedBy; "Posted By")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control18; "Receipt Line")
            {
                Caption = 'Fleet Management Lines';
                SubPageLink = "Header No." = field("No.");
            }
        }

    }

    actions
    {
        area(processing)
        {
            action("Suggest Receipt Lines")
            {
                ApplicationArea = Basic;
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Visible = false;


            }
            action("Post Receipt")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    DocLine: Record "Document Line";
                begin
                    if Confirm('Are you sure you want to Post this Receipt?') then begin
                        // "Posting Date" := Today;
                        Rec.Modify();

                        // SaccoActivities.PostReceipt("No.");

                        ReceiptHeader.Reset;
                        ReceiptHeader.SetRange("No.", "No.");
                        if ReceiptHeader.FindFirst then
                            Report.Run(Report::Receipt, true, false, ReceiptHeader);
                    end;
                end;
            }


            action("Receipt")
            {
                ApplicationArea = Basic;
                Image = Receipt;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var

                begin

                    ReceiptHeader.Reset;
                    ReceiptHeader.SetRange("No.", "No.");
                    if ReceiptHeader.FindFirst then
                        Report.Run(Report::"Bosa Receipting Report", true, false, ReceiptHeader);
                end;
            }

            action(Print)
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TestField(Posted, true);

                    ReceiptHeader.Reset;
                    ReceiptHeader.SetRange("No.", "No.");
                    if ReceiptHeader.FindFirst then begin

                        ReceiptHeader.Reset;
                        ReceiptHeader.SetRange("No.", "No.");
                        if ReceiptHeader.FindFirst then
                            Report.Run(Report::"Bosa Receipting Report", true, false, ReceiptHeader);

                    end;
                end;
            }
            action("Send Notification")
            {
                ApplicationArea = Basic;
                Image = Email;
                Promoted = true;
                PromotedCategory = category6;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Send Notification to this member?') then begin
                        TestField(Posted, true);
                        // SaccoActivities.SendReceiptNotifications(Rec."No.");
                    end;
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        if ("Received From" = '') And ("No." <> '') then begin
            Rec."Received From" := "Member Name";
            Rec.Modify();
        end;

    end;



    var
        // SaccoActivities: Codeunit "Sacco Activities";
        ReceiptHeader: Record "Receipt Header";
        SlipMandatory: Boolean;
}


