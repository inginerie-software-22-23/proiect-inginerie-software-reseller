import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { PostModel } from '../models/post-model';
import { PostsService } from '../sevices/posts.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  posts: PostModel[] =[];
  subscriptionList: Subscription[] = [];

  constructor(private _postService: PostsService, private _router: Router) { }

  ngOnInit(): void {
    this.subscriptionList.push(this._postService.getAllPosts().subscribe(
      (productList: PostModel[]) => {this.posts = productList}
    ))

  }

  ngOnDestroy(): void {
    this.subscriptionList.forEach((sub) => sub.unsubscribe())
  }



}
