import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { throwError } from 'rxjs';
import { CreatePostPayload } from 'src/app/models/create-post.payload';
import { PostsService } from 'src/app/sevices/posts.service';

@Component({
  selector: 'app-post-form',
  templateUrl: './post-form.component.html',
  styleUrls: ['./post-form.component.scss']
})
export class PostFormComponent implements OnInit {

  createPostForm!: FormGroup;
  postPayload!: CreatePostPayload;
  // subreddits: Array<SubredditModel>;

  constructor(private router: Router, private postService: PostsService,
    ) { //private subredditService: SubredditService
    this.postPayload = {
      title: '',
      imageUrl: '',
      description: '',
      price: 0
    }
  }

  ngOnInit() {
    this.createPostForm = new FormGroup({
      title: new FormControl('', Validators.required),
      imageUrl: new FormControl('', Validators.required),
      price: new FormControl(0, Validators.required),
      description: new FormControl('', Validators.required),
    });
  }

  createPost() {
    this.postPayload.title = this.createPostForm.get('title')?.value;
    this.postPayload.imageUrl = this.createPostForm.get('imageUrl')?.value;
    this.postPayload.price = this.createPostForm.get('price')?.value;
    this.postPayload.description = this.createPostForm.get('description')?.value;

    this.postService.createPost(this.postPayload).subscribe((data) => {
      this.router.navigateByUrl('/');
    }, error => { })
  }

  discardPost() {
    this.router.navigateByUrl('/');
  }

}
