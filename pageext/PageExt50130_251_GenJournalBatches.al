pageextension 50130 "DOT Gen. Journal Batches" extends "General Journal Batches"
{
    layout
    {
        addafter("Reason Code")
        {
            field("DOT Donor Used"; Rec."DOT Donor Used")
            {
                ApplicationArea = basic;
                trigger OnValidate()
                var
                    CompInfo: Record "Company Information";
                begin
                    if Rec."DOT Donor Used" then begin
                        if CompInfo.Get() then begin
                            Rec."DOT Authorized Id" := CompInfo."Donor Authorised";
                        end;
                    end else
                        Rec."DOT Authorized Id" := '';
                end;
            }
            field("DOT Batch Indicator"; Rec."DOT Batch Indicator") { ApplicationArea = basic; }
            field("DOT Authorized Id"; Rec."DOT Authorized Id")
            {
                ApplicationArea = basic;
                trigger OnValidate()
                var
                    GenJnlBatch: Record "Gen. Journal Batch";
                    GenJnlLine: Record "Gen. Journal Line";
                    DonorInfo: Record Employee;
                begin

                    GenJnlBatch.Reset();
                    GenJnlBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJnlBatch.SetRange(Name, Rec.Name);

                    //"Journal Template Name", "Journal Batch Name", "Line No."
                    GenJnlLine.Reset();
                    GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJnlLine.SetRange("Journal Batch Name", Rec.Name);
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
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}