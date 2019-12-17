#include <a_samp>
#include <a_http>
#include <zcmd>
public OnFilterScriptInit( ){
	print("-----------------------------------");
	print( "Googulator by James has loaded!" );
	print("-----------------------------------");
	return 1;
}
CMD:calculate( playerid, params[ ] ){
	if( !isnull( params ) ){
		new	URL[ 128 ];
		for( new i; i < strlen( params ); i++ ){
			if( params[ i ] == ' ' ){
				strdel( params, i, i+1 );
				i--;
			}
		}
		format( URL, sizeof( URL ), "www.google.com/ig/calculator?q=%s", str_replace( "+", "\%2B", params ) );
		HTTP( playerid, HTTP_GET, URL, "", "CalcResponse");
	}
	else{
		SendClientMessage( playerid, 0xFFFFFFFF, "Syntax: /calc [Equation]" );
	}
	return 1;
}
forward CalcResponse( index, response_code, rawData[ ] );
public CalcResponse( index, response_code, rawData[ ] ){
	if( response_code == 200 ){
		new	data[ 5 ][ 128 ],Output[ 128 ];
		explode( data, rawData, "\"" );
		format( Output, sizeof( Output ), "Calculator: %s = %s", data[ 1 ], data[ 3 ] );
		SendClientMessage( index, 0xFFFFFFFF, Output );
	}
	else{
		printf( "[Calc Error] Could not connect to google. Error (%d). Player (%d).", response_code, index );
	}
	return 1;
}
stock str_replace(sSearch[], sReplace[], const sSubject[], &iCount = 0){
	new
		iLengthTarget = strlen(sSearch),
		iLengthReplace = strlen(sReplace),
		iLengthSource = strlen(sSubject),
		iItterations = (iLengthSource - iLengthTarget) + 1;
	new	sTemp[128],	sReturn[256];
	strcat(sReturn, sSubject, 256);
	iCount = 0;
	for(new iIndex; iIndex < iItterations; ++iIndex){
		strmid(sTemp, sReturn, iIndex, (iIndex + iLengthTarget), (iLengthTarget + 1));
		if(!strcmp(sTemp, sSearch, false)){
			strdel(sReturn, iIndex, (iIndex + iLengthTarget));
			strins(sReturn, sReplace, iIndex, iLengthReplace);
			iIndex += iLengthTarget;
			iCount++;
		}
	}
	return sReturn;
}
stock explode(aExplode[][], const sSource[], const sDelimiter[] = " ", iVertices = sizeof aExplode, iLength = sizeof aExplode[]){
	new	iNode,iPointer,	iPrevious = -1,	iDelimiter = strlen(sDelimiter);
	while(iNode < iVertices){
		iPointer = strfind(sSource, sDelimiter, false, iPointer);
		if(iPointer == -1){
			strmid(aExplode[iNode], sSource, iPrevious, strlen(sSource), iLength);
			break;
		}
		else{
			strmid(aExplode[iNode], sSource, iPrevious, iPointer, iLength);
		}
		iPrevious = (iPointer += iDelimiter);
		++iNode;
	}
	return iPrevious;
}