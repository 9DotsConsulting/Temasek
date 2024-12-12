tableextension 50103 "DOT Gen. Journal Batch" extends "Gen. Journal Batch"
{
    fields
    {
        field(50100; "DOT Donor Used"; Boolean)
        {
            Caption = 'Donor Used';
            trigger OnValidate()
            var
                CI: Record "Company Information";
                GJB: Record "Gen. Journal Batch";
            begin
                CI.Get;
                if "DOT Donor Used" then
                    "DOT Authorized Id" := CI."Donor Authorised"
                else
                    "DOT Authorized Id" := '';
            end;
        }
        field(50101; "DOT Batch Indicator"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Batch Indicator';
            TableRelation = "DOT Batch Indicator";

        }
        field(50102; "DOT Authorized Id"; Code[20])
        {

            Caption = 'Authorized ID';
        }
    }
    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}