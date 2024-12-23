page 50112 EditEmailDialogBox
{
    ApplicationArea = All;
    Caption = 'EditEmailDialogBox';
    //PageType = Document;
    //PageType = StandardDialog;
    PageType = StandardDialog;
    //PageType = Card;
    SourceTable = "Gen. Journal Line";


    layout
    {
        area(Content)
        {
            // repeater(General)
            // {
            // }

            field(ResetBool; ResetBool)
            {
                ApplicationArea = All;
                Caption = 'Reset Statement';
                trigger OnValidate()
                var
                    CompInfo: Record "Company Information";
                begin

                    if ResetBool then begin

                        if CompInfo.Get() then begin
                            Rec."Donor Statement" := CompInfo."Donor Statement";
                            Statement := Rec."Donor Statement";
                            Rec.Modify();
                        end;
                        Sleep(500);
                        ResetBool := false;
                    end;

                end;

            }

            field("Printed Statement"; Statement)
            {
                ApplicationArea = All;
                Caption = 'Printed Statement';
                Editable = true;
                MultiLine = true;

                trigger OnValidate()
                var
                begin
                    Rec."Donor Statement" := Statement;
                    Rec.Modify();
                end;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Reset)
            {
                ApplicationArea = All;
                Caption = 'Reset statement';
                Image = Restore;

                trigger OnAction()
                var
                    CompInfo: Record "Company Information";
                begin
                    if CompInfo.Get() then begin
                        Rec."Donor Statement" := CompInfo."Donor Statement";
                        Rec.Modify();
                    end;
                end;
            }
        }

    }

    // trigger OnOpenPage()
    // var
    //     CompInfo: Record "Company Information";
    // begin
    //     CompInfo.Reset();

    //     if Rec."Donor Statement" <> '' then
    //         Statement := Rec."Donor Statement"
    //     else if CompInfo.Get() then
    //         Statement := CompInfo."Donor Statement";
    // end;

    trigger OnAfterGetRecord()
    var
        CompInfo: Record "Company Information";
    begin
        CompInfo.Reset();

        if Rec."Donor Statement" <> '' then
            Statement := Rec."Donor Statement"
        else if CompInfo.Get() then
            Statement := CompInfo."Donor Statement";
    end;

    trigger OnClosePage()
    var
    begin
        Rec."Donor Statement" := Statement;
        Rec.Modify();
    end;

    var

        Statement: Text;
        ResetBool: Boolean;
}
