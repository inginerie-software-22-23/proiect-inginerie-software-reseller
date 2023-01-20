import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { CommentPayload } from '../models/comment.payload';
import { LoginRequestPayload } from '../models/login-request.payload';
import { PostModel } from '../models/post-model';
import { User } from '../models/user';
import { AuthService } from '../sevices/auth.service';
import { CommentsService } from '../sevices/comments.service';
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
  users: User[] =[ ] ;
  posts: PostModel[]=[];
  comments: CommentPayload[]=[];
  postLength: number=0;
  commentLength: number=0;
 


  constructor(private router: Router,private _profileService: ProfileService,  private authServ: AuthService, private _activatedRoute: ActivatedRoute, private _postService: PostsService,
    private _commentService: CommentsService) { }


  ngOnInit(): void {

    this._postService.getAllPostsByUser(this.username).subscribe(data => {
      this.posts = data;
      this.postLength = data.length;
    });
    this._commentService.getAllCommentsByUser(this.username).subscribe(data => {
      this.comments = data;
      this.commentLength = data.length;
    });


    this._profileService.getUserByUsername(this.username).subscribe(user => {
      this.users = user;
      console.log(this.users);
    });
   }
   logout(){
    this.authServ.logout();
    this.router.navigateByUrl('/login');
   }


}
