table 50107 "DOT Donor Email List"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50102; Email; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email';
        }
        field(50103; Default; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Email")
        {
            Clustered = true;
        }
    }

}