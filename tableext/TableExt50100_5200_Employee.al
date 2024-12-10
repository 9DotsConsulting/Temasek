tableextension 50100 "DOT Employee" extends Employee
{
    fields
    {
        field(50100; "Donor Authorised"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "ID Type No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "DOT Organisation ID Type";
        }
        field(50102; "Organisation ID No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
}
