pageextension 50131 "Cash Receipt Journal Extension" extends "Cash Receipt Journal"
{
    layout
    {
        modify("Account No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Customer: Record Customer;
            begin
                Customer.SetFilter("No.", '*DNO*');
                if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then
                    Rec."Account No." := Customer."No.";
            end;
        }
        addafter("Account No.")
        {
            field(AuthorisedPersonIDNo; Rec.AuthorisedPersonIDNo)
            {
                Editable = false;
                ApplicationArea = Basic, Suite;
            }
            field(AuthorisedPersonName; Rec.AuthorisedPersonName)
            {
                Editable = false;
                ApplicationArea = Basic, Suite;
            }
            field(Telephone; Rec.Telephone)
            {
                Editable = false;
                ApplicationArea = Basic, Suite;
            }
            field(AuthorisedPersonEmail; Rec.AuthorisedPersonEmail)
            {
                Editable = false;
                ApplicationArea = Basic, Suite;
            }
        }

        addafter("Amount (LCY)")
        {
            field(IRASAmt; Rec.IRASAmt)
            {
                //Round(-Rec.Amount, 1, '>')
                //Editable = false;
                ApplicationArea = Basic, Suite;
            }
            field("Donor Payment Method Code"; Rec."Donor Payment Method Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Tax E"; Rec."Tax E")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Donor Email"; Rec."Donor Email")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Email Status"; Rec."Email Status")
            {
                ApplicationArea = Basic, Suite;
            }
        }

        modify(Amount)
        {
            trigger OnAfterValidate()
            begin
                //setIRASAmt();
            end;
        }
        modify("Amount (LCY)")
        {
            trigger OnAfterValidate()
            begin
                //setIRASAmt();
            end;

        }
    }
    //Modify a field that initialize other field
    // trigger OnAfterGetRecord()
    // var
    //     GenJnlLine: Record "Gen. Journal Line";
    // begin
    //     //"Journal Template Name", "Journal Batch Name", "Line No."
    //     GenJnlLine.Reset();
    //     GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
    //     GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
    //     GenJnlLine.SetRange("Line No.");
    //     if GenJnlLine.FindSet() then begin
    //         repeat
    //             GenJnlLine.IRASAmt := Abs(Round(GenJnlLine.Amount, 1, '>'));
    //             GenJnlLine.Modify();
    //         until GenJnlLine.Next() = 0;
    //     end;
    // end;

    trigger OnAfterGetRecord()
    var
    begin
        getDonorInfo();
        //setIRASAmt();
    end;


    local procedure getDonorInfo()
    var
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        DonorInfo: Record Employee;
    begin

        GenJnlBatch.Reset();
        GenJnlBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenJnlBatch.SetRange(Name, Rec."Journal Batch Name");

        //"Journal Template Name", "Journal Batch Name", "Line No."
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        GenJnlLine.SetRange("Line No.");
        if GenJnlBatch.FindFirst() then begin
            if GenJnlLine.FindSet() then begin
                repeat
                    DonorInfo.Reset();
                    DonorInfo.SetRange("No.", GenJnlBatch."DOT Authorized Id");
                    if DonorInfo.FindFirst() then begin
                        GenJnlLine.AuthorisedPersonIDNo := DonorInfo."No.";
                        GenJnlLine.AuthorisedPersonName := DonorInfo."First Name";
                        GenJnlLine.Telephone := DonorInfo."Phone No.";
                        GenJnlLine.AuthorisedPersonEmail := DonorInfo."E-Mail";
                    end else begin
                        GenJnlLine.AuthorisedPersonIDNo := GenJnlBatch."DOT Authorized Id";
                        GenJnlLine.AuthorisedPersonName := '';
                        GenJnlLine.Telephone := '';
                        GenJnlLine.AuthorisedPersonEmail := '';
                    end;
                    GenJnlLine.Modify();
                until GenJnlLine.Next() = 0;
            end;
        end;

    end;

    // local procedure getDonorInfo(ID: Code[20]): Record Employee
    // var
    //     DonorInfo: Record Employee;
    // begin
    //     DonorInfo.Reset();
    //     DonorInfo.SetRange("No.", ID);
    //     if DonorInfo.FindFirst() then
    //         exit(DonorInfo);
    // end;

    local procedure setIRASAmt()
    var
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
    begin

        GenJnlBatch.Reset();
        GenJnlBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenJnlBatch.SetRange(Name, Rec."Journal Batch Name");

        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        GenJnlLine.SetRange("Line No.");
        if GenJnlBatch.FindFirst() then begin
            if GenJnlLine.FindSet() then begin
                repeat

                    GenJnlLine.IRASAmt := Round(-GenJnlLine.Amount, 1, '>');

                    GenJnlLine.Modify();
                until GenJnlLine.Next() = 0;
            end;
        end;
    end;

}
