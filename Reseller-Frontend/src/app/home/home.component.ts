import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { debounceTime, Subscription, throwError } from 'rxjs';
import { PostModel } from '../models/post-model';
import { User } from '../models/user';
import { AuthService } from '../sevices/auth.service';
import { ImageService } from '../sevices/image.service';
import { PostsService } from '../sevices/posts.service';
import { ProfileService } from '../sevices/profile.service';
import { SearchService } from '../sevices/search.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  username = this._authService.getUserName();
  searchControl!: FormControl; 
  searchResults: Array<any> = [];
  searchForm!: FormGroup;
  posts: Array<PostModel> = [];
  searchType: string = 'posts';
  searchInitiated = false;

  constructor(private _postService: PostsService,private _searchService: SearchService, private _imageService:ImageService, private _authService:AuthService) {  
    this._postService.getAllPosts().subscribe(post => {
      this.posts = post; 
      this.posts = this.posts.reverse();

      this.posts.forEach(post => {
        this.setImages(post);
      })
    });

    this.searchControl = new FormControl('');
    this.searchForm = new FormGroup({
      searchControl: this.searchControl   
    });
  }

  ngOnInit(): void {  

  }

 
  searchPosts() {
    this.searchType = 'posts';
    if (this.searchControl.value != null && this.searchControl.value.trim() !== '') {
      this._searchService.searchPosts(this.searchControl.value).subscribe(results => {
        this.searchResults = results;
        this.searchResults.forEach(post => {
          this.setImages(post);
        });
      });
    } else {
      this.searchResults = [];
      this.posts.forEach(post => {
        this.searchResults.push(post);
        this.setImages(post);
      });
    }

    this.searchForm.reset();
  }
  searchUser() {
    this.searchType = 'users';
    console.log(this.searchControl.value)
    if (this.searchControl.value != null){
      this._searchService.searchProfiles(this.searchControl.value).subscribe(results => {
        this.searchResults = results;
        console.log(results)
      });
    }
    this.searchForm.reset();
  }
  

  setImages(post:PostModel) {
    this._imageService.getPostImageUrl(post.id).subscribe(
      data => {
        post.imageUrl = data;
        console.log(post)
        console.log(post.imageUrl)
      }
    );

    this._imageService.getImageUrl(post.username).subscribe(
      data => {
        post.profileUrl = data;
      }
    )
  }

}





