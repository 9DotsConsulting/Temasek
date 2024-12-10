table 50105 "DOT Donor Payment Method"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Payment Method Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';
        }
        field(50101; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Payment Method Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

}