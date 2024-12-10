table 50100 "DOT Type of Donation"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Type No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';

        }

        field(50101; Terms; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Type No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Type No.", Terms) { }
    }

}
