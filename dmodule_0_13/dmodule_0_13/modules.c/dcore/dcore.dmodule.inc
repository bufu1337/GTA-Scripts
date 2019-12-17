// See Copyright Notice in core\LICENSE.txt
forward DCORE_EverySecondTimer();
public DCORE_EverySecondTimer() {
	_EverySecond();
}

dcore_GameModeInit() {
	SetTimer("DCORE_EverySecondTimer",1000,1);
}