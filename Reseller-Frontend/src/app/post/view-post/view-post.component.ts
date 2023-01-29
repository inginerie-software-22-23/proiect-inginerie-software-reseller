import { AnimateTimings } from '@angular/animations';
import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { DomSanitizer, SafeUrl } from '@angular/platform-browser';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subscription, throwError } from 'rxjs';
import { CommentPayload } from 'src/app/models/comment.payload';
import { LikePayload } from 'src/app/models/like.payload';
import { PostModel } from 'src/app/models/post-model';
import { SavedPayload } from 'src/app/models/saved.payload';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/sevices/auth.service';
import { CommentsService } from 'src/app/sevices/comments.service';
import { ImageService } from 'src/app/sevices/image.service';
import { LikesService } from 'src/app/sevices/likes.service';
import { PostsService } from 'src/app/sevices/posts.service';
import { ProfileService } from 'src/app/sevices/profile.service';
import { SavedService } from 'src/app/sevices/saved.service';

@Component({
  selector: 'app-view-post',
  templateUrl: './view-post.component.html',
  styleUrls: ['./view-post.component.scss']
})
export class ViewPostComponent implements OnInit {

  postId: number;
  post!: PostModel;
  sellerImage: string = '';
  productImage: string = '';
  commentForm: FormGroup;
  commentPayload: CommentPayload;
  comments: CommentPayload[] = [];
  likePayload: LikePayload = new LikePayload;
  likesList: LikePayload[]=[];
  savePayload: SavedPayload = new SavedPayload;

  user:string = this._authService.getUserName();
  
  savedList: SavedPayload[]=[];
  activeUser: User = new User;

  constructor(private postService: PostsService, private activateRoute: ActivatedRoute,private commentService: CommentsService, private profileService: ProfileService,
     private router: Router, private sanitizer: DomSanitizer, private imageService: ImageService, private _likeService: LikesService,private toastr: ToastrService,
     private _authService: AuthService, private _saveService: SavedService) { //
    this.postId = this.activateRoute.snapshot.params['id'];

    this.commentForm = new FormGroup({
      text: new FormControl('', Validators.required)
    });
    this.commentPayload = {
      commentId: 0,
      text: '',
      username: '',
      url: '',
      postId: this.postId
    };
  }

  ngOnInit(): void {
    this.getPostById();
    this.getCommentsForPost();
    this._likeService.getAllLikesByUser(this.user).subscribe((data: LikePayload[]) => {
      this.likesList = data;
     })

   this._saveService.getAllSavesByUser(this.user).subscribe(data => {
    this.savedList = data;
   })

   this.profileService.getUserByUsername(this.user).subscribe((data: User) => {
    this.activeUser = data;
   })
  }

  postComment() {
    this.imageService.getImageUrl(this.user).subscribe(
      data => {
        this.commentPayload.url = data;
      }
    );
    this.commentPayload.username = this.user;
    this.commentPayload.text = this.commentForm.get('text')?.value;
    this.commentService.postComment(this.commentPayload).subscribe(
    {  next : data => { }, 
    error: () => { }
  } 
    )
    this.comments.push(this.commentPayload);
    this.commentForm.get('text')?.setValue('');

  }

  onTextAreaInput(textarea: HTMLTextAreaElement) {
    textarea.style.height = 'auto';
    textarea.style.height = textarea.scrollHeight - 14 + 'px';
  }

  private getPostById() {
    this.postService.getPostById(this.postId).subscribe(
    { next : data => {
      this.post = data;
      this.getProfileUrlForPost(this.post);
      this.getPostImageUrl(this.post);
    },
     error: () => {
  
    }}
    );
  }

  private getCommentsForPost() {

    this.commentService.getAllCommentsForPost(this.postId).subscribe(
      { next :data => {
        this.comments = data;
        this.comments.forEach(comment => {
          this.imageService.getImageUrl(comment.username).subscribe(
            data => {
              comment.url = data;
            }
          );
        });
    }, 
    error:() => {
    }}
    )
  }



  private getProfileUrlForPost(post: PostModel) {
    this.imageService.getImageUrl(post.username).subscribe(
      data => {
        this.sellerImage = data;
      }
    );
  }

  private getPostImageUrl(post: PostModel) {
    this.imageService.getPostImageUrl(post.id).subscribe(
      data => {
        this.productImage = data;
      }
    );
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
      
    );

    
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
      
    );
    
  }

  likeButtonLogic(post:PostModel){

    let like= new LikePayload;
    like.postId = post.id;
    let likedPostIndex = this.likesList.findIndex(item => item.postId === like.postId);
    if(likedPostIndex>-1) {
        this.unlike(post);
        this.likesList.splice(likedPostIndex);
        post.likesCount--;
      } else {
        this.like(post);
        this.likesList.push(like);
        post.likesCount++;
      }
      

  }


  saveButtonLogic(post: PostModel){
      let save= new SavedPayload;
      save.postId = post.id;
      let savedPostIndex = this.savedList.findIndex(item => item.postId === save.postId);
      if(savedPostIndex>-1){
        this.unsave(post)
        this.savedList.splice(savedPostIndex);
        post.savedCount--;
      }
      else{
        this.save(post)
        this.savedList.push(save);
        post.savedCount++;
      }
    }




}
