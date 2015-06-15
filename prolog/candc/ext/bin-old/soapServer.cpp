/* soapServer.cpp
   Generated by the gSOAP Stub and Skeleton Compiler for C and C++ 2.1.6b
   Copyright (C) 2001-2002 Robert A. van Engelen, Florida State University.
   All rights reserved.
*/
#include "soapH.h"

SOAP_FMAC1 int SOAP_FMAC2 soap_serve(struct soap *soap)
{
	soap_begin(soap);
	soap_fault(soap);
	if (soap_begin_recv(soap) || soap_envelope_begin_in(soap) || soap_recv_header(soap) || soap_body_begin_in(soap))
		return soap_send_fault(soap);

	soap->error = soap_serve_ns__getQuote(soap);
	if (soap->error)
		return soap_send_fault(soap);
	return soap->error;
}

SOAP_FMAC1 int SOAP_FMAC2 soap_serve_ns__getQuote(struct soap *soap)
{	struct ns__getQuote soap_tmp_ns__getQuote;
	struct ns__getQuoteResponse soap_tmp_ns__getQuoteResponse;
	soap_default_ns__getQuoteResponse(soap, &soap_tmp_ns__getQuoteResponse);
	soap_default_ns__getQuote(soap, &soap_tmp_ns__getQuote);
	soap_get_ns__getQuote(soap, &soap_tmp_ns__getQuote, "ns:getQuote", NULL);
	if (soap->error == SOAP_TAG_MISMATCH && soap->level == 2)
		soap->error = SOAP_NO_METHOD;
	if (soap->error)
		return soap->error;
	
	if (soap_body_end_in(soap))
		return soap->error;
	if (soap_envelope_end_in(soap))
		return soap->error;
	if (soap_getattachments(soap))
		return soap->error;
	if (soap_end_recv(soap))
		return soap->error;
	soap->error = ns__getQuote(soap, soap_tmp_ns__getQuote.symbol, soap_tmp_ns__getQuoteResponse.result);
	if (soap->error)
		return soap->error;
	soap_serializeheader(soap);
	soap_serialize_ns__getQuoteResponse(soap, &soap_tmp_ns__getQuoteResponse);
	if (!soap->disable_response_count)
	{	soap_begin_count(soap);
		soap_envelope_begin_out(soap);
		soap_putheader(soap);
		soap_body_begin_out(soap);
		soap_put_ns__getQuoteResponse(soap, &soap_tmp_ns__getQuoteResponse, "ns:getQuoteResponse", "");
		soap_body_end_out(soap);
		soap_envelope_end_out(soap);
	};
	soap_begin_send(soap);
	soap_response(soap, SOAP_OK);
	soap_envelope_begin_out(soap);
	soap_putheader(soap);
	soap_body_begin_out(soap);
	soap_put_ns__getQuoteResponse(soap, &soap_tmp_ns__getQuoteResponse, "ns:getQuoteResponse", "");
	soap_body_end_out(soap);
	soap_envelope_end_out(soap);
	soap_putattachments(soap);
	soap_end_send(soap);
	soap_closesock(soap);
	return SOAP_OK;
}

/* end of soapServer.cpp */
