import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { throwError } from 'rxjs';
import { CommentPayload } from 'src/app/models/comment.payload';
import { PostModel } from 'src/app/models/post-model';
import { CommentsService } from 'src/app/sevices/comments.service';
import { PostsService } from 'src/app/sevices/posts.service';

@Component({
  selector: 'app-view-post',
  templateUrl: './view-post.component.html',
  styleUrls: ['./view-post.component.scss']
})
export class ViewPostComponent implements OnInit {

  postId: number;
  post!: PostModel;
  commentForm: FormGroup;
  commentPayload: CommentPayload;
  comments: CommentPayload[] = [];

  constructor(private postService: PostsService, private activateRoute: ActivatedRoute,private commentService: CommentsService,
     private router: Router) { //
    this.postId = this.activateRoute.snapshot.params['id'];

    this.commentForm = new FormGroup({
      text: new FormControl('', Validators.required)
    });
    this.commentPayload = {
      text: '',
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

  private getPostById() {
    this.postService.getPostById(this.postId).subscribe(
    { next : data => {
      this.post = data;
    },
     error: () => {
  
    }}
    );
  }

  private getCommentsForPost() {
    this.commentService.getAllCommentsForPost(this.postId).subscribe(
      {next :data => {
      this.comments = data;
    }, 
    error:() => {
    }}
    );
  }

  private getLikesForPost() {
    this.commentService.getAllCommentsForPost(this.postId).subscribe(
      {next :data => {
      this.comments = data;
    }, 
    error:() => {
      
    }}
    );
  }

}
