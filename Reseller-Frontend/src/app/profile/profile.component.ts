import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { forkJoin, map, Subscription, switchMap, takeUntil } from 'rxjs';
import { ChatPayload } from '../models/chat.payload';
import { CommentPayload } from '../models/comment.payload';
import { FollowPayload } from '../models/follow.payload';
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

  //name: string='';
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


  constructor(private _activatedRoute: ActivatedRoute, private _postService: PostsService,
    private _commentService: CommentsService, private _profileService: ProfileService, private _followService: FollowService, private _authService: AuthService,
    private imageService:ImageService, private _chatService:ChatService, private router:Router) {
      
      

  }

  ngOnInit(): void {
    
    this.getUser();
    //this.verifyIfFollowed()
    //console.log(this.user)
    this._profileService.getUserByUsername(this.activeUser).subscribe((user:User)=>
    {
      this.activeUser = user;
    })

    this._postService.getAllPostsByUser(this.name).subscribe(data => {
      this.posts = data;
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
  // verifyIfFollowed(){
  //   let isFound = this.activeUserFollowing.findIndex(f => f.profileId === this.followRequest.followed);
  //   if(isFound > -1){
  //     this.isFollowed = true;
  //   } else {
  //     this.isFollowed = false;
  //   }
  // }

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
  chat(){
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
        if(chat.sender.username === this.name){
          this.router.navigate(['/message/'+ chat.chatId]);
      }
      });
    });


  }






}
