import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { ChatPayload } from '../models/chat.payload';
import { MessagePayload } from '../models/message.payload';

@Injectable({
  providedIn: 'root'
})
export class ChatService {

  constructor(private _http: HttpClient) { }

  getChatByUsername(username: string): Observable<ChatPayload[]>{
    return this._http.get<ChatPayload[]>("http://localhost:8070/api/chat/getChatByFirstUsernameOrSecondUsername/"+ username)
  }

  getMessagesByChatId(id: number){
    return this._http.get<MessagePayload[]>("http://localhost:8070/api/message/chat/"+ id)
  }

  // postMessage()

  // postChat()
}
