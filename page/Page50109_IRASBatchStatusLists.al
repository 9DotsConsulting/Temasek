page 50109 "DOT IRAS Batch Status Lists"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'IRAS Batch Status Lists';
    UsageCategory = Lists;
    SourceTable = "DOT IRAS Batch Status Lists";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Record ID"; Rec."Record ID") { Editable = false; }
                field("Basis Year"; Rec."Basis Year") { }
                field("Receipt Num"; Rec."Receipt Num") { Editable = false; }
                field("Date Of Donation"; Rec."Date Of Donation") { Editable = false; }
                field(Status; Rec.Status) { Editable = false; }
                field(Validate; Rec.Validate) { Editable = false; }
                field("Recent Date Time"; Rec."Recent Date Time") { Editable = false; }
                field("Batch Indicator"; Rec."Batch Indicator") { }
                field("Authorised Person ID No."; Rec."Authorised Person ID No.") { }
                field("ID Type No."; Rec."ID Type No.") { Editable = false; }
                field("ID No."; Rec."ID No.") { Editable = false; }
                field("Indicator No."; Rec."Indicator No.") { Editable = false; }
                field(Name; Rec.Name) { Editable = false; }
                field("Type No."; Rec."Type No.") { }
                field("Naming No."; Rec."Naming No.") { }
                field("Donation Amount"; Rec."Donation Amount") { Editable = false; }
                field(Response; Rec.Response) { Editable = false; }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group(ApplyRecordIds)
            {
                Caption = 'Action';
                Image = Action;
                action(ApplyRecordId)
                {
                    Caption = 'Apply Record ID';
                    Image = "1099Form";
                    trigger OnAction()
                    begin

                    end;
                }

                action(GetValidate)
                {
                    Caption = 'Get Validate';
                    Image = Completed;
                    trigger OnAction()
                    begin

                    end;
                }

                action(GetValidateSubmit)
                {
                    Caption = 'Get Validate & Submit';
                    Image = CarryOutActionMessage;
                    trigger OnAction()
                    begin

                    end;
                }

            }
        }
        area(Promoted)
        {
            group(Category_Category6)
            {
                Caption = 'Apply Record ID';

                actionref(AppyRecordId_Promoted; ApplyRecordId)
                {
                }
                actionref(GetValidate_Promoted; GetValidate)
                {
                }
                actionref(GetValidateSubmit_Promoted; GetValidateSubmit)
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        CustLedgEntries: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        IRASBatchList, IRASBatchList2 : Record "DOT IRAS Batch Status Lists";
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

                    Rec."Record ID" := ListMax + 1;
                    Rec."Entry No." := CustLedgEntries."Entry No.";
                    Rec."Basis Year" := Date2DMY(CustLedgEntries."Document Date", 3);
                    Rec."Receipt Num" := CustLedgEntries."Document No.";
                    Rec."Date Of Donation" := CustLedgEntries."Document Date";
                    Rec."Batch Indicator" := CustLedgEntries."Batch Indicator";
                    Rec."Authorised Person ID No." := CustLedgEntries."Authorised Person ID No.";
                    Rec."ID No." := CustLedgEntries."ID No.";
                    Rec.Name := CustLedgEntries."Customer Name";
                    Rec."Donation Amount" := CustLedgEntries."Remaining IRASAmnt";

                    Customer.Reset();
                    Customer.SetRange("No.", CustLedgEntries."Customer No.");
                    if Customer.FindFirst() then begin
                        IndvIndicator := Customer."Indicator No.";
                        TypeofDonation := Customer."Type No.";
                        NamingNo := Customer."Naming No.";
                        TypeNo := Customer."ID Type No.";
                    end;
                    Rec."Indicator No." := IndvIndicator;
                    Rec."Type No." := TypeofDonation;
                    Rec."Naming No." := NamingNo;
                    Rec."ID Type No." := TypeNo;

                    Rec.Insert();
                end;
            until CustLedgEntries.Next = 0;
        end;
    end;

    trigger OnAfterGetRecord()
    var
        CustLedgEntries: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        IRASBatchList, IRASBatchList2 : Record "DOT IRAS Batch Status Lists";
        EntryNo: Integer;
    begin
        Rec."Recent Date Time" := Rec.SystemCreatedAt;
        Rec.Modify();

        //check if there is any tax e in Customer Ledger Entry that has been changed
        IRASBatchList.Reset();
        IRASBatchList.SetFilter("Donation Amount", '<>%1', 0);
        if IRASBatchList.FindSet() then begin
            repeat
                CustLedgEntries.Reset();
                CustLedgEntries.SetRange("Entry No.", IRASBatchList."Entry No.");
                if CustLedgEntries.FindSet() then begin
                    if CustLedgEntries."Tax E" = false then
                        EntryNo := CustLedgEntries."Entry No.";
                end;

                IRASBatchList2.Reset();
                IRASBatchList2.SetRange("Entry No.", EntryNo);
                if IRASBatchList2.FindFirst() then
                    IRASBatchList2.Delete()
            until IRASBatchList.Next = 0;
        end;

    end;
}