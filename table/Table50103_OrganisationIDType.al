table 50103 "DOT Organisation ID Type"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "ID Type No."; Code[10])
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
        key(Key1; "ID Type No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "ID Type No.", Terms) { }
    }

}