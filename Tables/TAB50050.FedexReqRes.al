table 50050 FedexReqRes
{
    DataClassification = CustomerContent;
    Caption = 'FedexReqRes';

    fields
    {
        field(1; "Serial No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Serial No.';
        }
        field(2; "WS Status"; code[5])
        {
            DataClassification = CustomerContent;
            Caption = 'WS Status';
        }
        field(3; "WS Message"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'WS Message';
        }
        field(4; "File Extension"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'File Extension';
        }
        field(5; "SOAP Request"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'SOAP Request';
        }
        field(6; "SOAP Response"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'SOAP Response';
        }
        field(7; "SOAP Response DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'SOAP Response DateTime';
        }
        field(8; "SOAP Request DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'SOAP Request DateTime';
        }
        field(9; "SOAP Response without NS"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'SOAP Response without NS';
        }
    }

    keys
    {
        key(PK; "Serial No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    procedure ViewResponse()
    var
        FileTxt: Text;
        NVInStream: InStream;
    begin
        CALCFIELDS("SOAP Response");
        IF NOT "SOAP Response".HASVALUE() THEN
            EXIT;

        //if UploadIntoStream('Select XML file', '', 'XML files (*.XML)|*.XML|All files (*.*)|*.*', FileTxt, NVInStream) then begin
        FileTxt := Format("Serial No.") + ' Response.xml';
        Clear(NVInStream);
        "SOAP Response".CREATEINSTREAM(NVInStream);
        DOWNLOADFROMSTREAM(NVInStream, '', '', 'XML files (*.XML)|*.XML|All files (*.*)|*.*', FileTxt);
        //end;
    end;

    procedure ViewResponseNoNS()
    var
        FileTxt: Text;
        NVInStream: InStream;
    begin
        CALCFIELDS("SOAP Response without NS");
        IF NOT "SOAP Response without NS".HASVALUE() THEN
            EXIT;

        //if UploadIntoStream('Select XML file', '', 'XML files (*.XML)|*.XML|All files (*.*)|*.*', FileTxt, NVInStream) then begin
        FileTxt := FORMAT("Serial No.") + ' NONSResponse.xml';
        Clear(NVInStream);
        "SOAP Response without NS".CREATEINSTREAM(NVInStream);
        DOWNLOADFROMSTREAM(NVInStream, '', '', 'XML files (*.XML)|*.XML|All files (*.*)|*.*', FileTxt);
        //end;
    end;

    procedure ViewRequest()
    var
        FileTxt: Text;
        NVInStream: InStream;
    begin
        CALCFIELDS("SOAP Request");
        IF NOT "SOAP Request".HASVALUE() THEN
            EXIT;

        //if UploadIntoStream('Select XML file', '', 'XML files (*.XML)|*.XML|All files (*.*)|*.*', FileTxt, NVInStream) then begin
        FileTxt := FORMAT("Serial No.") + ' Request.xml';
        Clear(NVInStream);
        "SOAP Request".CREATEINSTREAM(NVInStream);
        DOWNLOADFROMSTREAM(NVInStream, '', '', 'XML files (*.XML)|*.XML|All files (*.*)|*.*', FileTxt);
        //end;
    end;

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