tableextension 50104 "Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {

        field(50100; "AuthorisedPersonIDNo"; Text[12])
        {
            //Editable = false;
            Caption = 'Authorised Person ID No.';
            DataClassification = ToBeClassified;
        }
        field(50101; "AuthorisedPersonName"; Text[30])
        {
            //Editable = false;
            Caption = 'Authorised Person Name';
            DataClassification = ToBeClassified;
        }
        field(50102; "Telephone"; Text[20])
        {
            //Editable = false;
            Caption = 'Telephone';
            DataClassification = ToBeClassified;
        }
        field(50103; "AuthorisedPersonEmail"; Text[50])
        {
            //Editable = false;
            Caption = 'Authorised Person Email';
            DataClassification = ToBeClassified;
        }
        field(50104; "IRASAmt"; Integer)
        {
            Caption = 'IRASAmt';
            DataClassification = ToBeClassified;
        }
        field(50105; "Donor Payment Method Code"; Code[10])
        {
            Caption = 'Donor Payment Method Code';
            DataClassification = ToBeClassified;
            TableRelation = "DOT Donor Payment Method";
        }
        field(50106; "Tax E"; Boolean)
        {
            InitValue = false;
            Caption = 'Tax E';
            DataClassification = ToBeClassified;
        }
        field(50107; "Donor Email"; Text[50])
        {
            Caption = 'Donor Email';
            DataClassification = ToBeClassified;
        }
        field(50108; "Email Status"; Enum "Donor Email Status")
        {
            InitValue = ' ';
            Caption = 'Email Status';
            DataClassification = ToBeClassified;
        }
    }

    trigger OnAfterModify()
    var
    begin
        //getDonorInfo();
    end;

    procedure getDonorInfo()
    var
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        DonorInfo: Record Employee;
    begin

        GenJnlBatch.Reset();
        GenJnlBatch.SetRange("DOT Donor Used", true);
        if GenJnlBatch.FindSet() then begin
            repeat

                GenJnlLine.Reset();
                GenJnlLine.SetRange("Journal Template Name", GenJnlBatch."Journal Template Name");
                GenJnlLine.SetRange("Journal Batch Name", GenJnlBatch.Name);
                GenJnlLine.SetRange("Line No.");
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

            until GenJnlBatch.Next() = 0;

        end;

    end;
}
