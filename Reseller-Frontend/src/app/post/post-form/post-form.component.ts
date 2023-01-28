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
 

  constructor(private router: Router, private postService: PostsService,
    ) { 
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
      price: new FormControl(0, [Validators.required, this.noNegativeValidator]),
      description: new FormControl('', Validators.required),
    });
  }

  createPost() {
    if(this.createPostForm.valid){
    this.postPayload.title = this.createPostForm.get('title')?.value;
    this.postPayload.imageUrl = this.createPostForm.get('imageUrl')?.value;
    this.postPayload.price = this.createPostForm.get('price')?.value;
    this.postPayload.description = this.createPostForm.get('description')?.value;

    this.postService.createPost(this.postPayload).subscribe((data) => {
     
   
     
     
    }, error => {  })
     this.router.navigateByUrl('/my-profile');
   
  }}

  discardPost() {
    this.router.navigateByUrl('/my-profile');
  }

  noNegativeValidator(control: FormControl) {
    if (control.value !== null && control.value < 0 && control.value != '=-+') {
      return { price: true };
    }
    return null;
  }


}
