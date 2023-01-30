import { Component, OnDestroy, OnInit } from '@angular/core';
import { LocalStorageService } from 'ngx-webstorage';
import { forkJoin, Subject, Subscription, switchMap, takeUntil } from 'rxjs';
import { ChatPayload } from '../models/chat.payload';
import { User } from '../models/user';

import { AuthService } from '../sevices/auth.service';
import { ChatService } from '../sevices/chat.service';
import { ImageService } from '../sevices/image.service';
import { ProfileService } from '../sevices/profile.service';

@Component({
  selector: 'app-chats',
  templateUrl: './chats.component.html',
  styleUrls: ['./chats.component.scss']
})
export class ChatsComponent implements OnInit {

  name = this._authSevice.getUserName()
  chats: ChatPayload[] = []
  user: User = new User;
  private ngUnsubscribe = new Subject();
  private subscribeList: Subscription[] = [];
  chatImage: string[] = []




  constructor(private _chatService: ChatService, private _authSevice: AuthService, private _profileService: ProfileService, 
    private localStorage: LocalStorageService, private imageService: ImageService){

  }

  ngOnInit(): void {
    this.getUser();
  }



  getUser(){
    this._profileService.getUserByUsername(this.name).subscribe((data: User) => {
      this.user = data;
    });
  
    this._chatService.getChatByUsername(this.name).pipe(
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
      });
      this.chats.forEach(chat => {
        this.imageService.getImageUrl(chat.sender.username).subscribe(data => {
          chat.sender.imageUrl = data;
        });
      });
    });
  }
  

 

}
