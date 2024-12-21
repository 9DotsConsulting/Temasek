pageextension 50133 "DOT Customer Ledger Entries" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Remaining Amt. (LCY)")
        {
            field("Batch Indicator"; Rec."Batch Indicator")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(IRASAmt; Rec.IRASAmt)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Remaining IRASAmnt"; Rec."Remaining IRASAmnt")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("ID No."; Rec."ID No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Authorised Person ID No."; Rec."Authorised Person ID No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Tax E"; Rec."Tax E")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
        modify("Customer Name")
        {
            Caption = 'Name';
        }
    }

    trigger OnAfterGetRecord()
    var
        Customer: Record Customer;
        GenJnlBatch: Record "Gen. Journal Batch";
    begin
        Rec.IRASAmt := Round(-Rec.Amount, 1, '>');
        Rec."Remaining IRASAmnt" := Round(-Rec."Remaining Amount", 1, '>');
        Rec.Modify();
    end;

    trigger OnAfterGetCurrRecord()
    var
        CustLedgEntries: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        IRASBatchList, IRASBatchList2, IRASBatchList3 : Record "DOT IRAS Batch Status Lists";
        ListMax: Integer;
        TypeNo, NamingNo, IndvIndicator, TypeofDonation : Code[10];
    begin

        //input records to IRAS Batch Status List
        CustLedgEntries.Reset();
        CustLedgEntries.SetFilter(IRASAmt, '<>%1', 0);
        CustLedgEntries.SetFilter("Customer No.", '@DNO*');
        CustLedgEntries.SetRange("Tax E", true);
        CustLedgEntries.SetRange("Batch Indicator", 'O');
        if CustLedgEntries.FindSet() then begin
            repeat
                IRASBatchList.Reset();
                IRASBatchList.SetRange("Entry No.", CustLedgEntries."Entry No.");
                if not IRASBatchList.FindFirst() then begin
                    IRASBatchList2.Reset();
                    IRASBatchList.SetFilter("Record ID", '<>%1', 0);
                    if IRASBatchList2.FindLast() then begin
                        ListMax := IRASBatchList2."Record ID";
                    end;

                    IRASBatchList3."Record ID" := ListMax + 1;
                    IRASBatchList3."Entry No." := CustLedgEntries."Entry No.";
                    IRASBatchList3."Basis Year" := Date2DMY(CustLedgEntries."Document Date", 3);
                    IRASBatchList3."Receipt Num" := CustLedgEntries."Document No.";
                    IRASBatchList3."Date Of Donation" := CustLedgEntries."Document Date";
                    IRASBatchList3."Batch Indicator" := CustLedgEntries."Batch Indicator";
                    IRASBatchList3."Authorised Person ID No." := CustLedgEntries."Authorised Person ID No.";
                    IRASBatchList3."ID No." := CustLedgEntries."ID No.";
                    IRASBatchList3.Name := CustLedgEntries."Customer Name";
                    IRASBatchList3."Donation Amount" := CustLedgEntries."Remaining IRASAmnt";

                    Customer.Reset();
                    Customer.SetRange("No.", CustLedgEntries."Customer No.");
                    if Customer.FindFirst() then begin
                        IndvIndicator := Customer."Indicator No.";
                        TypeofDonation := Customer."Type No.";
                        NamingNo := Customer."Naming No.";
                        TypeNo := Customer."ID Type No.";
                    end;
                    IRASBatchList3."Indicator No." := IndvIndicator;
                    IRASBatchList3."Type No." := TypeofDonation;
                    IRASBatchList3."Naming No." := NamingNo;
                    IRASBatchList3."ID Type No." := TypeNo;

                    IRASBatchList3.Insert();
                end;
            until CustLedgEntries.Next = 0;
        end;
    end;
}
