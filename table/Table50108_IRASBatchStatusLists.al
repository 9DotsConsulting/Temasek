table 50108 "DOT IRAS Batch Status Lists"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Record ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "Basis Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Receipt Num"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Date Of Donation"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; Status; Enum "DOT IRAS Batch Status")
        {
            DataClassification = ToBeClassified;
        }
        field(50105; Validate; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "Recent Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "Batch Indicator"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Authorised Person ID No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "ID Type No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "DOT ID Type";
        }

        field(50110; "ID No."; Code[12])
        {
            DataClassification = ToBeClassified;
        }

        field(50111; "Indicator No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50112; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "Type No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "DOT Type of Donation";
        }

        field(50114; "Naming No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "DOT Naming Donation";
        }
        field(50115; "Donation Amount"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50116; Response; Text[100])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Basis Year") { }
    }

}