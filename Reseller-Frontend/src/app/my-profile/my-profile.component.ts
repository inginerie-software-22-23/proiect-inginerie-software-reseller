import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { CommentPayload } from '../models/comment.payload';
import { LoginRequestPayload } from '../models/login-request.payload';
import { PostModel } from '../models/post-model';
import { User } from '../models/user';
import { AuthService } from '../sevices/auth.service';
import { CommentsService } from '../sevices/comments.service';
import { FollowService } from '../sevices/follow.service';
import { ImageService } from '../sevices/image.service';
import { PostsService } from '../sevices/posts.service';
import { ProfileService } from '../sevices/profile.service';

@Component({
  selector: 'app-my-profile',
  templateUrl: './my-profile.component.html',
  styleUrls: ['./my-profile.component.scss']
})
export class MyProfileComponent implements OnInit {



  private subscribe : Subscription = new Subscription;
  username= this.authServ.getUserName();
  user: User | undefined;
  posts: PostModel[]=[];
  comments: CommentPayload[]=[];
  postLength: number=0;
  commentLength: number=0;
  followers: number=0;
  following: number=0;
  @Output() followersChange = new EventEmitter<User[]>();
  @Output() followingChange = new EventEmitter<User[]>();
  followersList: User[] = [];
  followingList: User[] = [];
  @Output() currentListChange = new EventEmitter<string>();
  currentList!: string;
  profileImage: string = ''; 


  constructor(private router: Router,private _profileService: ProfileService,  private authServ: AuthService, private _activatedRoute: ActivatedRoute, private _postService: PostsService,
    private _commentService: CommentsService, private _followService: FollowService, private imageService:ImageService) { }


  ngOnInit(): void {

    this._postService.getAllPostsByUser(this.username).subscribe(data => {
      this.posts = data;
      this.posts = this.posts.reverse();
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
      this.postLength = data.length;
    });
    this._commentService.getAllCommentsByUser(this.username).subscribe(data => {
      this.comments = data;
      this.commentLength = data.length;
    });


    this._profileService.getUserByUsername(this.username).subscribe(user => {
      this.user = user;
 
    
    });

    this._profileService.getFollowersByUsername(this.username).subscribe(data => {
      this.followers= data.length;
      this.followersList = data;
      this.followersChange.emit(this.followersList);
    });

    this._profileService.getFollowingByUsername(this.username).subscribe(data => {
      this.following= data.length;
      this.followingList = data;
      this.followersChange.emit(this.followingList);
    });

    this.imageService.getImageUrl(this.username).subscribe(data => {
      this.profileImage = data;
    })

   }

   logout(){
    this.authServ.logout();
    this.router.navigateByUrl('/login');
   }

   goToFollowersList() {
    this.router.navigate(['/followers-list/' + this.username]);
  }
  goToFollowingList() {
 
    this.router.navigate(['/following-list/' + this.username]);
  }

  editValues() {
    let selectedUser = new User;
    this._profileService.getUserByUsername(this.username).subscribe( data =>{
      selectedUser = data;
    })
    this.router.navigate(['/edit/'+ this.username])
  }
}

  





