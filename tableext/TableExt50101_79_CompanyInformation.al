tableextension 50101 "DOT Company Information" extends "Company Information"
{
    fields
    {
        field(50100; "Donor Authorised"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee where("Donor Authorised" = const(true));
        }
    }
}
