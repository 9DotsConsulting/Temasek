tableextension 50101 "Company Information Extension" extends "Company Information"
{
    fields
    {
        field(50100; "Donor Authorised"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
    }
}
