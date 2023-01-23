import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { CommentPayload } from '../models/comment.payload';
import { FollowPayload } from '../models/follow.payload';
import { PostModel } from '../models/post-model';
import { User } from '../models/user';
import { CommentsService } from '../sevices/comments.service';
import { FollowService } from '../sevices/follow.service';
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

  constructor(private _activatedRoute: ActivatedRoute, private _postService: PostsService,
    private _commentService: CommentsService, private _profileService: ProfileService, private _followService: FollowService) {

  }

  ngOnInit(): void {
    this.name = this._activatedRoute.snapshot.params['name'];
    


    this._postService.getAllPostsByUser(this.name).subscribe(data => {
      this.posts = data;
      this.postLength = data.length;
    });

    this._profileService.getUserByUsername(this.name).subscribe(user => {
      this.user = user;
      
    });
    this._profileService.getFollowersByUsername(this.name).subscribe(data => {
      this.followers= data.length;
    });

    this._profileService.getFollowingByUsername(this.name).subscribe(data => {
      this.following= data.length;
    });

    
    console.log(this.user.id)
  }

    follow(){
      this.followRequest.followed =this.user.id;
      this._followService.postFollow(this.followRequest).subscribe(data=>{
        
      })

  }


}
