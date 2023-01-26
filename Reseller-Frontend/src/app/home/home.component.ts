import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Subscription, throwError } from 'rxjs';
import { PostModel } from '../models/post-model';
import { ImageService } from '../sevices/image.service';
import { PostsService } from '../sevices/posts.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  posts: Array<PostModel> = [];

  constructor(private _postService: PostsService, private _imageService:ImageService) {  this._postService.getAllPosts().subscribe(post => {
    this.posts = post;

    this.posts.forEach(post => {
      this._imageService.getPostImageUrl(post.id).subscribe(
        data => {
          post.imageUrl = data;
        }
      );

      this._imageService.getImageUrl(post.username).subscribe(
        data => {
          post.profileUrl = data;
        }
      )
    })
  })
 }

  ngOnInit(): void {

  }
}
