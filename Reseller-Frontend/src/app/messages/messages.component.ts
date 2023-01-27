import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { MessagePayload } from '../models/message.payload';
import { ChatService } from '../sevices/chat.service';

@Component({
  selector: 'app-messages',
  templateUrl: './messages.component.html',
  styleUrls: ['./messages.component.scss']
})
export class MessagesComponent implements OnInit{

  chatId:number=0;
  messages: MessagePayload[] = [];


  constructor(private _chatService: ChatService, private activateRoute: ActivatedRoute){
    
  }
  ngOnInit(): void {
    this.chatId = this.activateRoute.snapshot.params['id'];

   this._chatService.getMessagesByChatId(this.chatId).subscribe(data =>{
        return this.messages = data;
   })

  }

}
