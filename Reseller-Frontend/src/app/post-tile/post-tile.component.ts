import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Component, Input, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { catchError, debounceTime, filter, fromEvent, map, Observable, of, Subscription, tap } from 'rxjs';
import { CommentPayload } from '../models/comment.payload';
import { LikePayload } from '../models/like.payload';
import { PostModel } from '../models/post-model';
import { SavedPayload } from '../models/saved.payload';
import { User } from '../models/user';
import { AuthService } from '../sevices/auth.service';
import { CommentsService } from '../sevices/comments.service';
import { ImageService } from '../sevices/image.service';
import { LikesService } from '../sevices/likes.service';
import { PostsService } from '../sevices/posts.service';
import { ProfileService } from '../sevices/profile.service';
import { SavedService } from '../sevices/saved.service';
import { SearchService } from '../sevices/search.service';

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
  user:string = this._authService.getUserName();
  likesList: LikePayload[]=[];
  savedList: SavedPayload[]=[];
  activeUser: User = new User;




  constructor(private _router: Router, private _likeService: LikesService, private _profileService: ProfileService,
    private _authService: AuthService, private _saveService: SavedService,  private _postService: PostsService, private imageService:ImageService,
    private toastr: ToastrService) {
      
      this.loggedInSubscription = this._authService.loggedIn.subscribe((data: boolean) => this.isLoggedIn = data);
  }

  ngOnInit(): void {

    this._likeService.getAllLikesByUser(this.user).subscribe((data: LikePayload[]) => {
      this.likesList = data;
    })

    this._saveService.getAllSavesByUser(this.user).subscribe(data => {
      this.savedList = data;
    })

    this._profileService.getUserByUsername(this.user).subscribe((data: User) => {
      this.activeUser = data;
    })
    console.log(this.likesList)

  }

  goToPost(id: number): void {
    this._router.navigateByUrl('/view-post/' + id);
  }


  like(post:PostModel) {
    this.likePayload.postId = post.id;
    this._likeService.postLike(this.likePayload).subscribe(
      () => {
        this.toastr.success('Liked!');
       
      },
      (error: HttpErrorResponse) => {
        this.toastr.error(error.message);
        console.error(error);
      }
      
    ); //window.location.reload()

    
  }


  save(post:PostModel) {
    this.savePayload.postId = post.id;
    this._saveService.postSave(this.savePayload).subscribe(
      () => {
        this.toastr.success('Liked!');

      },
      (error: HttpErrorResponse) => {
        this.toastr.error(error.message);
        console.error(error);
      }
      
    );
    window.location.reload()
  }

  unsave(post:PostModel) {
    this.savePayload.postId = post.id;
    this._saveService.deleteSave(this.savePayload.postId).subscribe(
      () => {
        this.toastr.success('Liked!');

      },
      (error: HttpErrorResponse) => {
        this.toastr.error(error.message);
        console.error(error);
      }
      
    );
    window.location.reload()
  }

  unlike(post:PostModel) {
    this.likePayload.postId = post.id;
    this._likeService.deleteLike(this.likePayload.postId).subscribe(
      () => {
      
      },
      (error: HttpErrorResponse) => {
        this.toastr.error(error.message);
        console.error(error);
      }
      
    );// window.location.reload()
    
  }

  likeButtonLogic(post:PostModel){

    let like= new LikePayload;
    like.postId = post.id;
    let likedPostIndex = this.likesList.findIndex(item => item.postId === like.postId);
    if(likedPostIndex>-1) {
        this.unlike(post);
      } else {
        this.like(post);
      }
      window.location.href = window.location.href;

  }

  saveButtonLogic(post: PostModel){
    let save= new SavedPayload;
    save.postId = post.id;
    let savedPostIndex = this.savedList.findIndex(item => item.postId === save.postId);
    if(savedPostIndex>-1){
      this.unsave(post)
    }
    else{
      this.save(post)
    }
  }

  }






