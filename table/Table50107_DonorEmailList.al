table 50107 "DOT Donor Email List"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Email ID"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; Email; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email';
        }
        field(50102; Default; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Email ID")
        {
            Clustered = true;
        }
    }

}