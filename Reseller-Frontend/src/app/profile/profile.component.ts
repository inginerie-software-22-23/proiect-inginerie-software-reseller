import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { forkJoin, map, Subscription, switchMap, takeUntil } from 'rxjs';
import { ChatPayload } from '../models/chat.payload';
import { Chatrequest } from '../models/chatrequest';
import { CommentPayload } from '../models/comment.payload';
import { FollowPayload } from '../models/follow.payload';
import { MessagePayload } from '../models/message.payload';
import { PostModel } from '../models/post-model';
import { User } from '../models/user';
import { AuthService } from '../sevices/auth.service';
import { ChatService } from '../sevices/chat.service';
import { CommentsService } from '../sevices/comments.service';
import { FollowService } from '../sevices/follow.service';
import { ImageService } from '../sevices/image.service';
import { PostsService } from '../sevices/posts.service';
import { ProfileService } from '../sevices/profile.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {


  posts: PostModel[]=[];
  comments: CommentPayload[]=[];
  postLength: number=0;
  commentLength: number=0;
  user!: User;
  public isFollow: boolean | undefined;
  followRequest: FollowPayload = new FollowPayload;
  followers: number=0;
  following: number=0;
  followList: User[]=[];
  followingList:User[]=[];
  activeUser= this._authService.getUserName();
  activeUserFollowing: User[]=[];
  isFollowed!: boolean;
  name = this._activatedRoute.snapshot.params['name'];
  chats: ChatPayload[]=[]

  imageUrl: string = '';
  createdChatId!: number;


  constructor(private _activatedRoute: ActivatedRoute, private _postService: PostsService,
    private _commentService: CommentsService, private _profileService: ProfileService, private _followService: FollowService, private _authService: AuthService,
    private imageService:ImageService, private _chatService:ChatService, private router:Router) {
      
      

  }

  ngOnInit(): void {
    
    this.getUser();
    this._profileService.getUserByUsername(this.activeUser).subscribe((user:User)=>
    {
      this.activeUser = user;
    })

    this._postService.getAllPostsByUser(this.name).subscribe(data => {
      this.posts = data;
      this.posts = this.posts.reverse();
      this.postLength = data.length;
      this.posts.forEach(post => {
        this.imageService.getPostImageUrl(post.id).subscribe(
          data => {
            post.imageUrl = data;
          }
        );
        this.imageService.getImageUrl(post.username).subscribe(
          data => {
            post.profileUrl = data;
          }
        );
      });
      });
      
    this._profileService.getUserByUsername(this.name).subscribe(user => {
      this.user = user;
      this.imageService.getImageUrl(user.username).subscribe(
        data => {
          this.imageUrl = data;
        }
      );
      
    });
    this._profileService.getFollowersByUsername(this.name).subscribe(data => {
      this.followList = data;
      this.followers= data.length;
    });

    this._profileService.getFollowingByUsername(this.name).subscribe(data => {
      this.following= data.length;
      this.followingList = data;
    });

    this._profileService.getFollowingByUsername(this.activeUser).subscribe((data) => {
        this.activeUserFollowing = data;  
        this.isFollowed = this.activeUserFollowing.some(following => following.profileId === this.user.profileId); 

    
    })
    console.log(this.activeUserFollowing )
    console.log(this.activeUser)
  }

  getUser() {
      this._profileService.getUserByUsername(this.name).subscribe((user: User) => {
      this.user = user;
      this.followRequest.followed = user.userId;
      
    });      
      
    
}

    follow(){
      this._followService.postFollow(this.followRequest).subscribe(data=>{
       console.log(data)
       
      })
      this.isFollowed = true;
      this.followers++;

  }
  unfollow(){

    this._followService.deleteFollow(this.followRequest.followed).subscribe(data => {
      console.log(data)

    })
    this.isFollowed = false;
    this.followers--;

  }
  
  checkIfUsersHaveChat(): Promise<ChatPayload> {
    let user1 = this.name;
    let user2 = this._authService.getUserName();
    return new Promise((resolve, reject) => {
      forkJoin([
        this._chatService.getChatByUsername(user1),
        this._chatService.getChatByUsername(user2)
      ]).subscribe(
        result => {
          if(result[0].length == 0 || result[1].length == 0) {
            //reject("One of the users does not have any chats.");
            this.createChat();
            this.router.navigate(['/messages/'+ this.createdChatId]);
          }
          else{
            let sharedChats = result[0].filter(chat1 => result[1].find(chat2 => chat1.chatId === chat2.chatId));
            if (sharedChats.length > 0) {
              resolve(sharedChats[0]);
              this.router.navigate(['/messages/'+ sharedChats[0].chatId]);
              console.log('au chat'+ sharedChats[0].chatId)
            } else {
              //reject("No chat exists between the two users");
              this.createChat();
              this.router.navigate(['/messages/'+ this.createdChatId]);
            }
          }
        },
        error => {
         // reject(error);
          this.createChat();
          this.router.navigate(['/messages/'+ this.createdChatId]);
        }
      );
    });
  }
  
  createChat(){
    let chat: ChatPayload = {
      firstUserId: this.activeUser.userId,
      secondUserId: this.user.userId,
      chatId: 0,
      messages: [],
      sender: this.user
    }

    this._chatService.postChat(chat).subscribe(data => {
      if(data.status == 201){
      const chatString = data;
      const startIndex = chatString.indexOf('chatId=') + 7;
      const endIndex = chatString.indexOf(',', startIndex);
      this.createdChatId = chatString.substring(startIndex, endIndex);
      
      }

    })
    
  }


  goToFollowersList() {
    this.router.navigate(['/followers-list/'+ this.name]);
  }
  goToFollowingList() {
 
    this.router.navigate(['/following-list/' + this.name]);
  }


}



