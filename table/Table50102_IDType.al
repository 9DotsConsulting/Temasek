table 50102 "DOT ID Type"
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
        field(50102; "Individual Indicator"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "DOT Individual Indicator";
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