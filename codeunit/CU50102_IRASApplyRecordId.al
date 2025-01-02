codeunit 50102 "IRAS Apply Record Id"
{
    TableNo = "DOT IRAS Batch Status Lists";
    trigger OnRun()
    begin
    end;

    // procedure ApplyRecordId(var Rec: Record "DOT IRAS Batch Status Lists"; var InputBasisYear: Integer)
    procedure ApplyRecordId(var InputBasisYear: Integer)
    var
    begin
        rIRASBatchStatus.SetCurrentKey("Entry No.");
        rIRASBatchStatus.SetAscending("Entry No.", true);
        // rIRASBatchStatus.SetFilter("Basis Year", '=%1', InputBasisYear);
        if rIRASBatchStatus.FindSet() then
            repeat
                rIRASBatchStatus."Record ID" := 0;
                rIRASBatchStatus.Modify;
            until rIRASBatchStatus.Next = 0;
        IRASBatch.Reset;
        IRASBatch.SetFilter("Basis Year", '=%1', InputBasisYear);
        if IRASBatch.FindSet() then
            repeat
                RecordId += 1;
                IRASBatch."Record ID" := RecordId;
                IRASBatch.Modify;
            until IRASBatch.Next = 0;

    end;

    var
        myInt: Integer;
        rIRASBatchStatus: Record "DOT IRAS Batch Status Lists";
        IRASBatch: Record "DOT IRAS Batch Status Lists";
        RecordId: Integer;
}