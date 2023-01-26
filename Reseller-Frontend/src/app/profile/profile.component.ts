import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
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

  name: string='';
  posts: PostModel[]=[];
  comments: CommentPayload[]=[];
  postLength: number=0;
  commentLength: number=0;
  user!: User;
  public isFollow: boolean = false;
  followRequest: FollowPayload = new FollowPayload;
  followers: number=0;
  following: number=0;
  followList: User[]=[];
  followingList:User[]=[];
  activeUser= this._authService.getUserName();
  activeUserFollowing: User[]=[];
  isFollowed: boolean = false;
  imageUrl: string = '';


  constructor(private _activatedRoute: ActivatedRoute, private _postService: PostsService,
    private _commentService: CommentsService, private _profileService: ProfileService, private _followService: FollowService, private _authService: AuthService,
    private imageService:ImageService) {

  }

  ngOnInit(): void {
    this.name = this._activatedRoute.snapshot.params['name'];
    console.log(this.name)
    this.getUser(this.name, this.user);


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

    this._profileService.getFollowingByUsername(this.activeUser).subscribe(data => {
        this.activeUserFollowing = data;
        console.log(this.activeUserFollowing)
        console.log(this.user)
        const isFound = this.activeUserFollowing.find(f => f.id === this.user.id);
    
        if(isFound){
          this.isFollowed = true;
        } else {
          this.isFollowed = false;
        }
    
    })
  }

  getUser(username: string, user: User) {
    this._profileService.getUserByUsername(username).subscribe(data => {
        Object.assign(user, data);
    });
}


    follow(){
     
      let followedName = this._activatedRoute.snapshot.params['name'];
      let followedUsed = new User;
      this.getUser(followedName, followedUsed)
      console.log(followedUsed)
      this.followRequest.followed =followedUsed.id;
      this._followService.postFollow(this.followRequest).subscribe(data=>{
        this.isFollowed = true;
       
      })
      

  }
  unfollow(){
    let followedName = this._activatedRoute.snapshot.params['name'];
    this.getUser(this.name, this.user);
    console.log(this.user)
    this.followRequest.followed =this.user.id;
    this._followService.deleteFollow(this.followRequest.followed).subscribe(data => {
      this.isFollowed = false;

    })

  }






}
