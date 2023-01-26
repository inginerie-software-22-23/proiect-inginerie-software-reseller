import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { catchError, Observable, of, Subscription, tap } from 'rxjs';
import { CommentPayload } from '../models/comment.payload';
import { LikePayload } from '../models/like.payload';
import { PostModel } from '../models/post-model';
import { SavedPayload } from '../models/saved.payload';
import { AuthService } from '../sevices/auth.service';
import { CommentsService } from '../sevices/comments.service';
import { ImageService } from '../sevices/image.service';
import { LikesService } from '../sevices/likes.service';
import { PostsService } from '../sevices/posts.service';
import { SavedService } from '../sevices/saved.service';

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
  savePayload: SavedPayload = new SavedPayload;
  productImages: string[] = [];

  constructor(private _router: Router,private _http: HttpClient, private _likeService: LikesService,
    private _authService: AuthService, private _saveService: SavedService,
    private _postService: PostsService, private toastr: ToastrService, private imageService:ImageService){

      this.loggedInSubscription = this._authService.loggedIn.subscribe((data: boolean) => this.isLoggedIn = data);
  }

  ngOnInit(): void {
    //this.updateLikeDetails();
    //console.log(this.post)
    console.log(this.posts)
    this.posts.forEach(post => {
      this.imageService.getPostImageUrl(post.id).subscribe(
        data => {
          this.productImages.push(data);
        }
      );
    });
    
  }

  goToPost(id: number): void {
    this._router.navigateByUrl('/view-post/' + id);
  }


  like(post:PostModel) {
    this.likePayload.postId = post.id;
    this._likeService.postLike(this.likePayload).subscribe(
      (response) => {
        this.toastr.success('Liked!');
        //this.updateLikeDetails(post);

      },
      (error: HttpErrorResponse) => {
        this.toastr.error(error.message);
        console.error(error);
      }
      
    );
    window.location.reload()
  }


  save(post:PostModel) {
    this.savePayload.postId = post.id;
    this._saveService.postSave(this.savePayload).subscribe(
      (response) => {
        this.toastr.success('Liked!');
        //this.updateLikeDetails(post);

      },
      (error: HttpErrorResponse) => {
        this.toastr.error(error.message);
        console.error(error);
      }
      
    );
    window.location.reload()
  }
}



 

