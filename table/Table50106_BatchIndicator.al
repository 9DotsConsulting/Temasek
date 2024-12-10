table 50106 "DOT Batch Indicator"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Batch No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';
        }

        field(50101; Terms; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Batch No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

}