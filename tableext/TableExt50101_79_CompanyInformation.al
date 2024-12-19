tableextension 50101 "DOT Company Information" extends "Company Information"
{
    fields
    {
        field(50100; "Donor Authorised"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee where("Donor Authorised" = const(true));
        }

        //FDD 4.3
        field(50200; "Donor Statement"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }
}
