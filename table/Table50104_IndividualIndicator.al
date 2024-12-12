table 50104 "DOT Individual Indicator"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Indicator No."; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(50101; Terms; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Indicator No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Indicator No.", Terms) { }
    }

}
