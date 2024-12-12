pageextension 50130 "DOT Gen. Journal Batches" extends "General Journal Batches"
{
    layout
    {
        addafter("Reason Code")
        {
            field("DOT Donor Used"; Rec."DOT Donor Used") { ApplicationArea = basic; }
            field("DOT Batch Indicator"; Rec."DOT Batch Indicator") { ApplicationArea = basic; }
            field("DOT Authorized Id"; Rec."DOT Authorized Id") { ApplicationArea = basic; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}