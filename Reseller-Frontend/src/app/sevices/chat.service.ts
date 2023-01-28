import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { ChatPayload } from '../models/chat.payload';
import { MessagePayload } from '../models/message.payload';

@Injectable({
  providedIn: 'root'
})
export class ChatService {
  private chat: ChatPayload = new ChatPayload;


  constructor(private _http: HttpClient) { }


  setChat(chat: ChatPayload) {
    this.chat = chat;
  }

  getChat() {
    return this.chat;
  }

 
  getChatByUsername(username: string): Observable<ChatPayload[]>{
    return this._http.get<ChatPayload[]>("http://localhost:8070/api/chat/getChatByFirstUsernameOrSecondUsername/"+ username)
  }
  getChatById(id: number): Observable<ChatPayload>{
    return this._http.get<ChatPayload>("http://localhost:8070/api/chat/" + id)
  }

  getMessagesByChatId(id: number){
    return this._http.get<MessagePayload[]>("http://localhost:8070/api/message/chat/"+ id)
  }

  postChat(chat: ChatPayload){
    return this._http.put<any>("http://localhost:8070/api/message/chat", chat)
  }

  postMessage(message: MessagePayload){
    return this._http.post<any>("http://localhost:8070/api/message", message);
  }

}
