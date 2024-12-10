table 50101 "DOT Naming Donation"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Naming No."; Code[10])
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
        key(Key1; "Naming No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Naming No.", Terms) { }
    }

}