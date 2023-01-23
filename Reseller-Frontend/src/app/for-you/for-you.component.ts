import { Component, OnInit } from '@angular/core';
import { PostModel } from '../models/post-model';
import { User } from '../models/user';
import { AuthService } from '../sevices/auth.service';
import { PostsService } from '../sevices/posts.service';
import { ProfileService } from '../sevices/profile.service';
import { forkJoin } from 'rxjs';

@Component({
  selector: 'app-for-you',
  templateUrl: './for-you.component.html',
  styleUrls: ['./for-you.component.scss']
})
export class ForYouComponent implements OnInit {

  following: User[]=[];
  username= this._authService.getUserName();
  user:User | undefined;
  posts:PostModel[]=[];

  constructor( private _profileService: ProfileService, private _authService: AuthService, private _postService:PostsService) { }

  ngOnInit(): void {
    this._profileService.getFollowingByUsername(this.username).subscribe(data => {
      this.following= data;
      console.log(this.following[0].username)
      const requests = this.following.map(user => {
        return this._postService.getAllPostsByUser(user.username);
      });
      forkJoin(requests).subscribe(data => {
        this.posts = data.flat();
        console.log(this.posts);
      });
    });
  }
}

