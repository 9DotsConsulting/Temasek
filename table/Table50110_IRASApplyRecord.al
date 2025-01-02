table 50110 "IRAS Apply Record"
{
    DataClassification = ToBeClassified;
    Caption = 'IRAS Apply Record Temporary';

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "DOT IRAS Batch Status Lists"."Entry No.";
        }
        field(2; "Basis Year"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "DOT IRAS Batch Status Lists"."Basis Year";
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Basis Year") { }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}