import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
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
  fileForm!: FormGroup;
 

  constructor(private _formBuilder: FormBuilder, private router: Router, private postService: PostsService,
    private http:HttpClient) { 
    this.postPayload = {
      title: '',
      imageUrl: '',
      description: '',
      price: 0
    }

    this.fileForm = this._formBuilder.group({
        file:  [null, Validators.required]
    })
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

    this.postPayload.title = this.createPostForm.get('title')?.value;
    this.postPayload.price = this.createPostForm.get('price')?.value;
    this.postPayload.description = this.createPostForm.get('description')?.value;
    this.postService.createPost(this.postPayload).subscribe((data) => {

    }, error => {  })
    this.router.navigateByUrl('/my-profile');

  }

  discardPost() {
    this.router.navigateByUrl('/my-profile');
  }

  noNegativeValidator(control: FormControl) {
    if (control.value !== null && control.value < 0 && control.value != '=-+') {
      return { price: true };
    }
    return null;
  }

  onFileChange(event: Event) {
    if (event.target instanceof HTMLInputElement && event.target.files && event.target.files.length > 0) {
      const file: File = event.target.files[0];
      this.fileForm.get('file')?.setValue(file);
    }
  }


  uploadFile() {
    const formData = new FormData();
    const file: File = this.fileForm.get('file')?.value
    formData.append("file", file);
    console.log(formData.get('file'))
    
    const headers = new HttpHeaders().set('enctype', 'multipart/form-data');
    this.http.post('http://localhost:8070/api/post/product-picture', formData, { headers: headers, responseType:"text" as "json"})
      .subscribe((response) => {
        this.postPayload.imageUrl = response.toString();
      });
  }

}
