import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { CommentPayload } from '../models/comment.payload';
import { PostModel } from '../models/post-model';
import { User } from '../models/user';
import { CommentsService } from '../sevices/comments.service';
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
  users: User[]= [];

  constructor(private _activatedRoute: ActivatedRoute, private _postService: PostsService,
    private _commentService: CommentsService, private _profileService: ProfileService) {

  }

  ngOnInit(): void {
    this.name = this._activatedRoute.snapshot.params['name'];

    this._postService.getAllPostsByUser(this.name).subscribe(data => {
      this.posts = data;
      this.postLength = data.length;
    });
    this._commentService.getAllCommentsByUser(this.name).subscribe(data => {
      this.comments = data;
      this.commentLength = data.length;
    });

    this._profileService.getUserByUsername(this.name).subscribe(user => {
      this.users = user;
      console.log(this.users);
    });
  }

}
