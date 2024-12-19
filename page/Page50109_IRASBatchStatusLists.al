page 50109 "DOT IRAS Batch Status Lists"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'IRAS Batch Status Lists';
    UsageCategory = Lists;
    SourceTable = "DOT IRAS Batch Status Lists";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Basis Year"; Rec."Basis Year") { }
                field("Receipt Num"; Rec."Receipt Num") { }
                field("Date Of Donation"; Rec."Date Of Donation") { }
                field(Status; Rec.Status) { }
                field(Validate; Rec.Validate) { }
                field("Recent Date Time"; Rec."Recent Date Time") { }
                field("Batch Indicator"; Rec."Batch Indicator") { }
                field("Authorised Person ID No."; Rec."Authorised Person ID No.") { }
                field("ID Type No."; Rec."ID Type No.") { }
                field("ID No."; Rec."ID No.") { }
                field("Indicator No."; Rec."Indicator No.") { }
                field(Name; Rec.Name) { }
                field("Type No."; Rec."Type No.") { }
                field("Naming No."; Rec."Naming No.") { }
                field("Donation Amount"; Rec."Donation Amount") { }
                field(Response; Rec.Response) { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        CustLedgEntries: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        IRASBatchList, IRASBatchList2 : Record "DOT IRAS Batch Status Lists";
        ListMax: Integer;
    begin
        CustLedgEntries.Reset();
        CustLedgEntries.SetFilter(IRASAmt, '<>%1', 0);
        CustLedgEntries.SetFilter("Customer No.", '@DNO*');
        CustLedgEntries.SetRange("Tax E", true);
        CustLedgEntries.SetRange("Batch Indicator", 'O');
        if CustLedgEntries.FindSet() then begin
            IRASBatchList.Reset();
            IRASBatchList.SetRange("Entry No.", CustLedgEntries."Entry No.");
            if not IRASBatchList.FindSet() then begin
                repeat
                    IRASBatchList2.Reset();
                    IRASBatchList.SetFilter("List No.", '<>%1', 0);
                    if IRASBatchList2.FindLast() then begin
                        ListMax := IRASBatchList2."List No.";
                    end;

                    Rec."List No." := ListMax + 1;
                    Rec."Entry No." := CustLedgEntries."Entry No.";
                    Rec."Basis Year" := Date2DMY(CustLedgEntries."Document Date", 3);
                    Rec."Receipt Num" := CustLedgEntries."Document No.";
                    Rec."Date Of Donation" := CustLedgEntries."Document Date";
                    Rec."Batch Indicator" := CustLedgEntries."Batch Indicator";
                    Rec."Authorised Person ID No." := CustLedgEntries."Authorised Person ID No.";
                    Rec."ID No." := CustLedgEntries."ID No.";
                    Rec.Name := CustLedgEntries."Customer Name";
                    Rec."Recent Date Time" := CustLedgEntries.SystemModifiedAt;
                    Rec."Donation Amount" := CustLedgEntries."Remaining IRASAmnt";

                    Customer.Reset();
                    Customer.SetRange("No.", CustLedgEntries."Customer No.");
                    if Customer.FindFirst() then begin
                        Rec."ID Type No." := Customer."ID Type No.";
                        Rec."Indicator No." := Customer."Indicator No.";
                    end;

                    Rec.Insert();
                until CustLedgEntries.Next = 0;
            end;
        end;
    end;
}