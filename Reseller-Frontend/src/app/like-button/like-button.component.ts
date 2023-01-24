import { Component, Input, OnInit } from '@angular/core';
import { PostModel } from '../models/post-model';
import { AuthService } from '../sevices/auth.service';
import { LikesService } from '../sevices/likes.service';
import { PostsService } from '../sevices/posts.service';
import { ToastrService } from 'ngx-toastr'
import { LikePayload } from '../models/like.payload';
import { throwError, Subscription } from 'rxjs';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-like-button',
  templateUrl: './like-button.component.html',
  styleUrls: ['./like-button.component.scss']
})
export class LikeButtonComponent implements OnInit{

  @Input() post!: PostModel;
  likePayload = new LikePayload();
  isLoggedIn: boolean | undefined;
  loggedInSubscription: Subscription;
  
  constructor(private _likeService: LikesService,
    private _authService: AuthService,
    private _postService: PostsService, private toastr: ToastrService){

      this.loggedInSubscription = this._authService.loggedIn.subscribe((data: boolean) => this.isLoggedIn = data);
  }

  ngOnInit(): void {
    this.updateLikeDetails();
    console.log(this.post)
  }

  ngOnDestroy(): void {
    this.loggedInSubscription.unsubscribe();
  }

  like() {
    // if (!this.isLoggedIn) {
    //   this.toastr.error('You must be logged in to like a post!');
    //   return;
    // }
    this.likePayload.postId = this.post.id;
    this._likeService.postLike(this.likePayload).subscribe(
      (response) => {
        this.toastr.success('Liked!');
        this.updateLikeDetails();
      },
      (error: HttpErrorResponse) => {
        this.toastr.error(error.message);
        console.error(error);
      }
    );
  }

  private updateLikeDetails() {
    this._postService.getPost(this.post.id).subscribe(
      post => {
        this.post = post;
      },
      (error: HttpErrorResponse) => {
        this.toastr.error(error.message);
        console.error(error);
      }
    );
  }
}

