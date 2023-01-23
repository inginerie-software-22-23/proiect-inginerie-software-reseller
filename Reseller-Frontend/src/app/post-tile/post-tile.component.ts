import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Observable, Subscription } from 'rxjs';
import { CommentPayload } from '../models/comment.payload';
import { LikePayload } from '../models/like.payload';
import { PostModel } from '../models/post-model';
import { AuthService } from '../sevices/auth.service';
import { CommentsService } from '../sevices/comments.service';
import { LikesService } from '../sevices/likes.service';
import { PostsService } from '../sevices/posts.service';

@Component({
  selector: 'app-post-tile',
  templateUrl: './post-tile.component.html',
  styleUrls: ['./post-tile.component.scss']
})
export class PostTileComponent implements OnInit {

  @Input() posts: PostModel[] = [];
  commentService!: CommentsService;
  comments: CommentPayload[] = [] ;
  noOfComments: number = 0;
  likePayload: LikePayload = new LikePayload;
  isLoggedIn: boolean | undefined;
  loggedInSubscription: Subscription;

  constructor(private _router: Router,private _http: HttpClient, private _likeService: LikesService,
    private _authService: AuthService,
    private _postService: PostsService, private toastr: ToastrService){

      this.loggedInSubscription = this._authService.loggedIn.subscribe((data: boolean) => this.isLoggedIn = data);
  }

  ngOnInit(): void {
    //this.updateLikeDetails();
    //console.log(this.post)
  }

  goToPost(id: number): void {
    this._router.navigateByUrl('/view-post/' + id);
  }


  like(post:PostModel) {
    // if (!this.isLoggedIn) {
    //   this.toastr.error('You must be logged in to like a post!');
    //   return;
    // }
    this.likePayload.postId = post.id;
    this._likeService.postLike(this.likePayload).subscribe(
      (response) => {
        this.toastr.success('Liked!');
        this.updateLikeDetails(post);

      },
      (error: HttpErrorResponse) => {
        this.toastr.error(error.message);
        console.error(error);
      }
      
    );
    window.location.reload()
  }

  private updateLikeDetails(post:PostModel) {
    this._postService.getPost(post.id).subscribe(
      data => {
        post = data;
      },
      (error: HttpErrorResponse) => {
        this.toastr.error(error.message);
        console.error(error);
      }
    );
  }
}



 

