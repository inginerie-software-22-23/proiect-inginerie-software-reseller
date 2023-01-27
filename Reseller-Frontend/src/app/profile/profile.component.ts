import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { map, Subscription } from 'rxjs';
import { CommentPayload } from '../models/comment.payload';
import { FollowPayload } from '../models/follow.payload';
import { PostModel } from '../models/post-model';
import { User } from '../models/user';
import { AuthService } from '../sevices/auth.service';
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
  isFollowed: boolean = false;
  name = this._activatedRoute.snapshot.params['name'];

  imageUrl: string = '';


  constructor(private _activatedRoute: ActivatedRoute, private _postService: PostsService,
    private _commentService: CommentsService, private _profileService: ProfileService, private _followService: FollowService, private _authService: AuthService,
    private imageService:ImageService) {
      
      

  }

  ngOnInit(): void {
    
    this.getUser();
    this.verifyIfFollowed()
    console.log(this.user)
    this._profileService.getUserByUsername(this.activeUser).subscribe((user:User)=>
    {
      this.activeUser = user;
    })

    this._postService.getAllPostsByUser(this.name).subscribe(data => {
      this.posts = data;
      this.postLength = data.length;
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
  verifyIfFollowed(){
    const isFound = this.activeUserFollowing.find(f => f.profileId === this.followRequest.followed);
    if(isFound != undefined){
      this.isFollowed = true;
    } else {
      this.isFollowed = false;
    }
  }

    follow(){
      this._followService.postFollow(this.followRequest).subscribe(data=>{
        this.isFollowed = true;
       
      })
      

  }
  unfollow(){

    this._followService.deleteFollow(this.followRequest.followed).subscribe(data => {
      this.isFollowed = false;

    })

  }






}
