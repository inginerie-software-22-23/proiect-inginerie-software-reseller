import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { debounceTime, Subscription, throwError } from 'rxjs';
import { PostModel } from '../models/post-model';
import { ImageService } from '../sevices/image.service';
import { PostsService } from '../sevices/posts.service';
import { SearchService } from '../sevices/search.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  searchControl!: FormControl; 
  searchResults: PostModel[] = [];
  searchForm!: FormGroup;

  posts: Array<PostModel> = [];

  constructor(private _postService: PostsService,private _searchService: SearchService, private _imageService:ImageService) {  
    this._postService.getAllPosts().subscribe(post => {
      this.posts = post;

      this.posts.forEach(post => {
        this.setImages(post);
      })
    });


    this.searchControl = new FormControl('');
    this.searchForm = new FormGroup({
      searchControl: this.searchControl   
    });

    this.searchControl.valueChanges.pipe(debounceTime(1000)).subscribe(searchTerm => this.search());
  }

  ngOnInit(): void {  
  }

  search() {
    if (this.searchControl.value != null){
      this._searchService.searchPosts(this.searchControl.value).subscribe(results => {
        this.searchResults = results;
        this.searchResults.forEach(post => {
          this.setImages(post);
        })
      });
    }

  }

  setImages(post:PostModel) {
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
  }

}





