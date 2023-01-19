import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Subscription, throwError } from 'rxjs';
import { PostModel } from '../models/post-model';
import { PostsService } from '../sevices/posts.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  // posts: PostModel[] =[];
  // post:PostModel | undefined;
  // postId:number =2;
  // subscriptionList: Subscription[] = [];
  posts: Array<PostModel> = [];

  constructor(private _postService: PostsService) {  this._postService.getAllPosts().subscribe(post => {
    this.posts = post;
  }); }

  ngOnInit(): void {


  }



}
