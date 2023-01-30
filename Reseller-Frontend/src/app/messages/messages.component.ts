import { Component, Input, OnDestroy, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { LocalStorageService } from 'ngx-webstorage';
import { switchMap, of, map } from 'rxjs';
import { ChatPayload } from '../models/chat.payload';
import { MessagePayload } from '../models/message.payload';
import { User } from '../models/user';
import { AuthService } from '../sevices/auth.service';
import { ChatService } from '../sevices/chat.service';
import { ProfileService } from '../sevices/profile.service';

@Component({
  selector: 'app-messages',
  templateUrl: './messages.component.html',
  styleUrls: ['./messages.component.scss']
})
export class MessagesComponent implements OnInit{

  chatId:number=0;
  chat: ChatPayload = new ChatPayload;
  messages: MessagePayload[] = [];
  activeUsername = this._authService.getUserName();
  activeUser: User = new User;
  chatUser: User= new User;
  id: number= 0;
  sendMessage: MessagePayload = new MessagePayload;
  message: MessagePayload = new MessagePayload;
  messageForm: FormGroup;
  chatFromService: ChatPayload | undefined ;


  
  // chatFromChat: ChatPayload = new ChatPayload;


  constructor(private _chatService: ChatService, private activateRoute: ActivatedRoute, private _authService:AuthService, private _profileService:ProfileService,
    private localStorage: LocalStorageService){
    this.messageForm = new FormGroup({
      text: new FormControl('', Validators.required)
    });
    this.sendMessage = {
      chatId : 0,
      senderId : 0,
      recipientId : 0,
      text: ' '
      
      
    };
  }
  ngOnInit(): void {
   
    this.chatId = this.activateRoute.snapshot.params['id'];

    this._profileService.getUserByUsername(this.activeUsername).subscribe((data: User) =>{
      this.activeUser = data;
    })

 
    this._chatService.getChatById(this.chatId).subscribe( data => {
      this.chat = data;
      this.messages = data.messages;
      const userId = data.firstUserId === this.activeUser.userId ? data.secondUserId : data.firstUserId;
      this._profileService.getUserById(userId).subscribe(data => {
        this.chat.sender = data;
      })

    })

    this._profileService.getUserByUsername(this.chat.sender.username).subscribe((data: User) =>{
      this.chatUser = data;
    })

  


  }
  
  postMessage(){
    const newMessage = {
      chatId: this.chatId,
      senderId: this.activeUser.userId,
      recipientId: this.chat.sender.userId,
      text: this.messageForm.get('text')?.value
    };
    this.messages.push(newMessage)
    this._chatService.postMessage(newMessage).subscribe(data =>{
      console.log("message posted")
    })

    this.messageForm.reset();
  }




}
