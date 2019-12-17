

// Chat [ mic_chat ]

/*
native EnableChatSystem(toggle);
native SendMessage(text[]);
*/


public SendMessage(text[]){
if (ChatSys==1){
OnPlayerText(-1,text);
}
}

public EnableChatSystem(toggle){
if (toggle==1){
ChatSys =1;
}
}

