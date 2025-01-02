page 50113 "IRAS Apply Record"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Tasks;
    // SourceTable = "DOT IRAS Batch Status Lists";
    SourceTable = "IRAS Apply Record";
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(BasisYear; BasisYear)
                {
                    ApplicationArea = All;
                    Caption = 'Basis Year';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        rIRASBatchStatus: Record "DOT IRAS Batch Status Lists";
                        pIRASBastchStatus: Page "DOT IRAS Batch Status Lists";
                    begin
                        rIRASBatchStatus.Reset();
                        if Page.RunModal(Page::"DOT IRAS Batch Status Lists", rIRASBatchStatus) = Action::LookupOK then begin
                            BasisYear := rIRASBatchStatus."Basis Year";
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
    procedure GetBasisYear(): Integer
    begin
        exit(BasisYear);
    end;

    procedure Setup(_x: Integer)
    begin
        BasisYear := _x;
    end;

    var
        myInt: Integer;
        BasisYear: Integer;
}