import { Component, OnInit } from '@angular/core';
import { forkJoin } from 'rxjs';
import { PostModel } from '../models/post-model';
import { SavedPayload } from '../models/saved.payload';
import { AuthService } from '../sevices/auth.service';
import { PostsService } from '../sevices/posts.service';
import { SavedService } from '../sevices/saved.service';

@Component({
  selector: 'app-wishlist',
  templateUrl: './wishlist.component.html',
  styleUrls: ['./wishlist.component.scss']
})
export class WishlistComponent implements OnInit{

  username = this._authService.getUserName();
  wishlist: SavedPayload [] = [];
  posts: PostModel[] =[];

  constructor(private _savedService: SavedService, private _authService: AuthService, private _postsService: PostsService ){}
  ngOnInit(): void {
    this._savedService.getAllSavesByUser(this.username).subscribe( data => {
      this.wishlist = data; 
      const requests = this.wishlist.map(saved => {
        return this._postsService.getPostById(saved.postId);
      });
      forkJoin(requests).subscribe(data => {
        this.posts = data.flat();
        console.log(this.posts);
      });

    })
  }

}
