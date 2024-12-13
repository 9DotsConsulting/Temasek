tableextension 50102 "DOT Customer" extends Customer
{
    fields
    {
        field(50103; "ID Type No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "DOT ID Type";
        }

        field(50104; "ID No."; Code[12])
        {
            DataClassification = ToBeClassified;
        }

        field(50105; "Indicator No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(50106; "Type No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "DOT Type of Donation";
        }

        field(50107; "Naming No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "DOT Naming Donation";
        }
    }
}
