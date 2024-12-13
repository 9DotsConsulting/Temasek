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
}
