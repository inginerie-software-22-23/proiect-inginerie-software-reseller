import { Component, OnDestroy, OnInit } from '@angular/core';
import { LocalStorageService } from 'ngx-webstorage';
import { forkJoin, Subject, Subscription, switchMap, takeUntil } from 'rxjs';
import { ChatPayload } from '../models/chat.payload';
import { User } from '../models/user';

import { AuthService } from '../sevices/auth.service';
import { ChatService } from '../sevices/chat.service';
import { ProfileService } from '../sevices/profile.service';

@Component({
  selector: 'app-chats',
  templateUrl: './chats.component.html',
  styleUrls: ['./chats.component.scss']
})
export class ChatsComponent implements OnInit, OnDestroy {

  name = this._authSevice.getUserName()
  chats: ChatPayload[] = []
  user: User = new User;
  private ngUnsubscribe = new Subject();
  private subscribeList: Subscription[] = [];




  constructor(private _chatService: ChatService, private _authSevice: AuthService, private _profileService: ProfileService, private localStorage: LocalStorageService){





  }

  ngOnInit(): void {
    this.getUser();


    // this.subscribeList.push(this._profileService.getUserByUsername(this.name).subscribe( (data: User) =>{
    //   this.user = data;
    // }))

    // this.subscribeList.push(this._chatService.getChatByUsername(this.name).subscribe(data => {
    //   this.chats = data;
    // }))






  }



  getUser(){
    this._profileService.getUserByUsername(this.name).subscribe((data:User) => {
      this.user = data;
    });
    this._chatService.getChatByUsername(this.name).pipe(
      // takeUntil(this.ngUnsubscribe),
      switchMap((chats: ChatPayload[]) => {
        this.chats = chats;
        return forkJoin(
          chats.map(chat => {
            const userId = chat.firstUserId === this.user.userId ? chat.secondUserId : chat.firstUserId;
            return this._profileService.getUserById(userId);
          })
        );
      })
    ).subscribe((users: User[]) => {
      this.chats.forEach((chat, index) => {
        chat.sender = users[index];
        this._chatService.setChat(chat);
      });
    });

  }
  // onChatSelected(chat: ChatPayload) {
  //   this._chatService.setChat(chat);

  // }

  ngOnDestroy(): void {
    this.ngUnsubscribe.next(true);
    this.ngUnsubscribe.complete();
  }




}
