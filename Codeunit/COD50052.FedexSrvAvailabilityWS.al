codeunit 50052 FedexSrvAvailabilityWS
{
    trigger OnRun()
    begin

    end;

    procedure SrvExecute()
    var
        lXmlDocument: XmlDocument;
        lEnvolopeXmlNode: XmlNode;
        lHeaderXmlNode: XmlNode;
        lBodyXmlNode: XmlNode;
        MyHttpClient: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        Content: HttpContent;
        lXMLText: Text;
        ResponseXMLText: Text;


    begin
        Url := 'https://wsbeta.fedex.com:443/web-services/ValidationAvailabilityAndCommitment HTTP/1.1';
        CreateEnvelope(lXmlDocument, lEnvolopeXmlNode);
        CreateHeader(lEnvolopeXmlNode, lHeaderXmlNode);
        CreateBody(lEnvolopeXmlNode, lBodyXmlNode);
        //>>Sending to Web Service Request 
        RequestMessage.SetRequestUri(URL);

        RequestMessage.Method('POST');
        lXmlDocument.WriteTo(lXMLText);
        Content.WriteFrom(lXMLText);
        Content.GetHeaders(Headers);
        Headers.Remove('Content-Type');
        Headers.Add('Content-Type', 'text/xml');

        RequestMessage.Content := Content;

               
        //MyHttpClient.Send(RequestMessage, ResponseMessage);

        MyHttpClient.Post(URL,Content,ResponseMessage);
        if ResponseMessage.IsSuccessStatusCode then
          Message('200');  
         ResponseMessage.Content().ReadAs(ResponseXMLText);

        InsertXMLReqRes(lXmlDocument, ResponseXMLText);
    end;

    procedure CreateEnvelope(var pXmlDocument: XmlDocument; var pEnvelopeXmlNode: XmlNode);
    begin
        pXmlDocument := XmlDocument.Create();
        With XMLDomMgt do begin
            //AddDeclaration(pXmlDocument, '1.0', 'UTF-8', 'No');
            AddRootElementWithPrefix(pXmlDocument, 'Envelope', 'soapenv', SOAPNamespaceLbl, pEnvelopeXmlNode);
            AddPrefix(pEnvelopeXmlNode, 'v13', XSDNamespaceLbl);
        end;
    end;

    procedure CreateHeader(var pEnvelopeXmlNode: XmlNode; var pHeaderXmlNode: XmlNode);
    begin
        XMLDOMMgt.AddElement(pEnvelopeXmlNode, 'Header', 'soapenv', SOAPNamespaceLbl, pHeaderXmlNode);
    end;

    procedure CreateBody(var pSoapEnvelope: XmlNode; var pSoapBody: XmlNode);
    var
        WebAuthNode: XmlNode;
        UserCredentialNode: XmlNode;
        KeyNode: XmlNode;
        PasswordNode: XmlNode;
        AccNode: XmlNode;
        LocalizeNode: XmlNode;
        LanguageNode: XmlNode;
        LocaleNode: XmlNode;
        TransactionDetailNode: XmlNode;
        CustomerTransactionIdNode: XmlNode;
        VersionNode: XmlNode;
        SrvIDNOde: XmlNode;
        MajorNode: XmlNode;
        MinorNode: XmlNode;
        IntermediateNode: XmlNode;
        OriginNode: XmlNode;
        PostalNode: XmlNode;
        CountryCodenode: XmlNode;
        DestinationNode: XmlNode;
        ShipDateNode: XmlNode;
        CarrierCodeNode: XmlNode;
    begin
        XMLDOMMgt.AddElement(pSoapEnvelope, 'Body', 'soapenv', SOAPNamespaceLbl, pSoapBody);
        XMLDOMMgt.AddElement(pSoapBody, 'ServiceAvailabilityRequest', '', XSDNamespaceLbl, SrvAvReqNode);
        XMLDOMMgt.AddElement(SrvAvReqNode, 'WebAuthenticationDetail', '', XSDNamespaceLbl, WebAuthNode);
        XMLDOMMgt.AddElement(WebAuthNode, 'UserCredential', '', XSDNamespaceLbl, UserCredentialNode);
        XMLDOMMgt.AddElementwithValue(UserCredentialNode, 'Key', 'biup8qh4BjICtpRi', XSDNamespaceLbl, KeyNode);
        XMLDOMMgt.AddElementwithValue(UserCredentialNode, 'Password', 'L0BK7eUzMb75xlLInWRdaH4nI', XSDNamespaceLbl, PasswordNode);

        XMLDOMMgt.AddElement(SrvAvReqNode, 'ClientDetail', '', XSDNamespaceLbl, WebAuthNode);
        XMLDOMMgt.AddElementwithValue(WebAuthNode, 'AccountNumber', '510087720', XSDNamespaceLbl, AccNode);
        XMLDOMMgt.AddElementwithValue(WebAuthNode, 'MeterNumber', '114035650', XSDNamespaceLbl, AccNode);

        XMLDOMMgt.AddElement(WebAuthNode, 'Localization', '', XSDNamespaceLbl, LocalizeNode);
        XMLDOMMgt.AddElementwithValue(LocalizeNode, 'LanguageCode', 'EN', XSDNamespaceLbl, LanguageNode);
        XMLDOMMgt.AddElementwithValue(LocalizeNode, 'LocaleCode', 'US', XSDNamespaceLbl, LocaleNode);

        XMLDOMMgt.AddElement(SrvAvReqNode, 'TransactionDetail', '', XSDNamespaceLbl, TransactionDetailNode);
        XMLDOMMgt.AddElementwithValue(TransactionDetailNode, 'CustomerTransactionId', 'ServiceAvailabilityRequest', XSDNamespaceLbl, CustomerTransactionIdNode);
        XMLDOMMgt.AddElement(TransactionDetailNode, 'Localization', '', XSDNamespaceLbl, LocalizeNode);
        XMLDOMMgt.AddElementwithValue(LocalizeNode, 'LanguageCode', 'EN', XSDNamespaceLbl, LanguageNode);
        XMLDOMMgt.AddElementwithValue(LocalizeNode, 'LocaleCode', 'US', XSDNamespaceLbl, LocaleNode);

        XMLDOMMgt.AddElement(SrvAvReqNode, 'Version', '', XSDNamespaceLbl, VersionNode);
        XMLDOMMgt.AddElementwithValue(VersionNode, 'ServiceId', 'vacs', XSDNamespaceLbl, SrvIDNOde);
        XMLDOMMgt.AddElementwithValue(VersionNode, 'Major', '13', XSDNamespaceLbl, MajorNOde);
        XMLDOMMgt.AddElementwithValue(VersionNode, 'Intermediate', '0', XSDNamespaceLbl, IntermediateNOde);
        XMLDOMMgt.AddElementwithValue(VersionNode, 'Minor', '0', XSDNamespaceLbl, MinorNOde);

        XMLDOMMgt.AddElement(SrvAvReqNode, 'Origin', '', XSDNamespaceLbl, OriginNode);
        XMLDOMMgt.AddElementwithValue(OriginNode, 'PostalCode', '38017', XSDNamespaceLbl, PostalNOde);
        XMLDOMMgt.AddElementwithValue(OriginNode, 'CountryCode', 'US', XSDNamespaceLbl, CountryCodenode);

        XMLDOMMgt.AddElement(SrvAvReqNode, 'Destination', '', XSDNamespaceLbl, DestinationNode);
        XMLDOMMgt.AddElementwithValue(DestinationNode, 'PostalCode', '05040', XSDNamespaceLbl, PostalNOde);
        XMLDOMMgt.AddElementwithValue(DestinationNode, 'CountryCode', 'BR', XSDNamespaceLbl, CountryCodenode);

        XMLDOMMgt.AddElementwithValue(SrvAvReqNode, 'ShipDate', '2019-01-02', XSDNamespaceLbl, ShipDateNode);
        XMLDOMMgt.AddElementwithValue(SrvAvReqNode, 'CarrierCode', 'FDXE', XSDNamespaceLbl, CarrierCodeNode);
    end;

    local procedure InsertXMLReqRes(var pXmlDocument: XmlDocument; Var RespnseTxt: Text)
    var
        FedexReqRes: Record FedexReqRes;
        XMLReqOutStrm: OutStream;
        XMLResOutStrm: OutStream;
        lXMLResponse: XmlDocument;
        lXMLResponseText: Text;
        NoNSXMLOStrm: OutStream;
    begin
        clear(XMLResponseNoNS);
        FedexReqRes.DeleteAll();
        FedexReqRes.reset();
        FedexReqRes.Init();
        FedexReqRes."Serial No." := 1;
        FedexReqRes."File Extension" := 'XML';
        FedexReqRes."SOAP Request".CreateOutStream(XMLReqOutStrm);
        pXmlDocument.WriteTo(XMLReqOutStrm);
        FedexReqRes."SOAP Request DateTime" := CurrentDateTime();

        if RespnseTxt <> '' then begin
            FedexReqRes."SOAP Response".CreateOutStream(XMLResOutStrm);
            XmlDocument.ReadFrom(RespnseTxt, lXMLResponse);
            lXMLResponse.WriteTo(XMLResOutStrm);
            FedexReqRes."SOAP Response DateTime" := CurrentDateTime();

            //>> Creating & Saving XMLDocument without Namespace
            lXMLResponseText := XMLDomMgt.RemoveNamespaces(RespnseTxt);
            FedexReqRes."SOAP Response without NS".CreateOutStream(NoNSXMLOStrm);
            XmlDocument.ReadFrom(lXMLResponseText, XMLResponseNoNS);
            XMLResponseNoNS.WriteTo(NoNSXMLOStrm);
            //<< Creating & Saving XMLDocument without Namespace
        end;


        FedexReqRes.Insert();
        commit();

    end;


    //https://docs.microsoft.com/en-in/archive/blogs/gediminb/how-to-createread-xml-file-from-nav
    var
        XMLDomMgt: Codeunit "XML DOM Mgt.";

        URL: Text;
        SOAPNamespaceLbl: Label 'http://schemas.xmlsoap.org/soap/envelope/';
        XSDNamespaceLbl: Label 'http://fedex.com/ws/vacs/v13';
        XMLResponseNoNS: XmlDocument;
        SrvAvReqNode: XmlNode;
        SOAPActionlbl: Label 'http://fedex.com/ws/vacs/v13/serviceAvailability';
        
}