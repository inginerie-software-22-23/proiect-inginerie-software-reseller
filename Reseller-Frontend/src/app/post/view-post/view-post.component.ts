import { AnimateTimings } from '@angular/animations';
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { DomSanitizer, SafeUrl } from '@angular/platform-browser';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription, throwError } from 'rxjs';
import { CommentPayload } from 'src/app/models/comment.payload';
import { PostModel } from 'src/app/models/post-model';
import { User } from 'src/app/models/user';
import { CommentsService } from 'src/app/sevices/comments.service';
import { ImageService } from 'src/app/sevices/image.service';
import { PostsService } from 'src/app/sevices/posts.service';
import { ProfileService } from 'src/app/sevices/profile.service';

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

  constructor(private postService: PostsService, private activateRoute: ActivatedRoute,private commentService: CommentsService, private profileService: ProfileService,
     private router: Router, private sanitizer: DomSanitizer, private imageService: ImageService) { //
    this.postId = this.activateRoute.snapshot.params['id'];

    this.commentForm = new FormGroup({
      text: new FormControl('', Validators.required)
    });
    this.commentPayload = {
      text: '',
      username: '',
      url: '',
      postId: this.postId
    };
  }

  ngOnInit(): void {
    this.getPostById();
    this.getCommentsForPost();
  }

  postComment() {
    this.commentPayload.text = this.commentForm.get('text')?.value;
    this.commentService.postComment(this.commentPayload).subscribe(
    {  next : data => {
      this.commentForm.get('text')?.setValue('');
      this.getCommentsForPost();
      
    }, 
    error: () => {
    }
  } 
    )
    window.location.reload();
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
      //throwError(error);
    }}
    )
  }

  private getLikesForPost() {
    this.commentService.getAllCommentsForPost(this.postId).subscribe(
      {next :data => {
      this.comments = data;
    }, 
    error:() => {
      //throwError(error);
    }}
    );
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


}
