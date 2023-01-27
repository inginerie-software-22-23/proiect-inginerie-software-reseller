import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { debounceTime, Subscription, throwError } from 'rxjs';
import { PostModel } from '../models/post-model';
import { PostsService } from '../sevices/posts.service';
import { SearchService } from '../sevices/search.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
<<<<<<< Updated upstream
  // posts: PostModel[] =[];
  // post:PostModel | undefined;
  // postId:number =2;
  // subscriptionList: Subscription[] = [];
  posts: Array<PostModel> = [];

  constructor(private _postService: PostsService) {  this._postService.getAllPosts().subscribe(post => {
=======
  searchControl = new FormControl('');
  searchResults: PostModel[] = [];
  searchForm = new FormGroup({
    searchControl: this.searchControl
  });

  posts: Array<PostModel> = [];

  constructor(private _postService: PostsService,private _searchService: SearchService, private _imageService:ImageService) {  this._postService.getAllPosts().subscribe(post => {
>>>>>>> Stashed changes
    this.posts = post;
  }); }

  ngOnInit(): void {
    this.searchControl.valueChanges.pipe(debounceTime(1000)).subscribe(searchTerm => this.search());


  }
<<<<<<< Updated upstream
=======
  search() {
    console.log(this.searchControl.value)
    if (this.searchControl.value != null){
      this._searchService.searchPosts(this.searchControl.value).subscribe(results => {
        this.searchResults = results;
        console.log(results)
      });}
  }
  
>>>>>>> Stashed changes



}
