namespace DalaDala.DalaDala;
using Microsoft.FixedAssets.Reports;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Budget;
using Microsoft.Finance.FinancialReports;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.FixedAssets.Journal;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Purchases.Reports;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Reports;
using Microsoft.Sales.History;
using System.Environment;
using Microsoft.Inventory.Item;
using System.Visualization;
using Microsoft.Finance.RoleCenters;
using Microsoft.Intercompany;
using Microsoft.Foundation.Task;
using System.Email;
using System.Automation;
using Microsoft.RoleCenters;
using Microsoft.Sales.Analysis;
using System.Threading;
using Microsoft.CashFlow.Forecast;
using Microsoft.EServices.EDocument;
using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
using Microsoft.Bank.Reconciliation;
using Microsoft.Bank.BankAccount;
using Microsoft.Finance.GeneralLedger.Journal;

page 50000 "Finance Management"
{
    ApplicationArea = All;
    Caption = 'Finance Management';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control99; "Finance Performance")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control1902304208; "Accountant Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Intercompany Activities"; "Intercompany Activities")
            {
                ApplicationArea = Intercompany;
            }
            part("User Tasks Activities"; "User Tasks Activities")
            {
                ApplicationArea = Suite;
            }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            part(Control123; "Team Member Activities")
            {
                ApplicationArea = Suite;
            }
            part(Control1907692008; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control103; "Trailing Sales Orders Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control106; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control9; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control100; "Cash Flow Forecast Chart")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control108; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Basic, Suite;
            }

            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(reporting)
        {

        }

        area(sections)
        {

            group(Action157)
            {
                Caption = 'Sales Processing';

                group(Sales)
                {
                    Caption = 'Sales';

                    action(Action639)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Customers';
                        Image = "Order";
                        RunObject = Page "Customer List";
                    }

                    action("Sales Orders")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Sales Orders';
                        Image = Reminder;
                        RunObject = Page "Sales Order List";
                    }

                    action("Delivery Instruction Logs")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Delivery Instruction Log List';
                        Image = Reminder;
                        RunObject = Page "Delivery Instruction Log List";
                    }


                }
            }
        }

        area(processing)
        {
        }
    }
}
