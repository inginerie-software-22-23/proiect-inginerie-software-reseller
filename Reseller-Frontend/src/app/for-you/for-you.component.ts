import { Component, OnInit } from '@angular/core';
import { PostModel } from '../models/post-model';
import { User } from '../models/user';
import { AuthService } from '../sevices/auth.service';
import { PostsService } from '../sevices/posts.service';
import { ProfileService } from '../sevices/profile.service';
import { forkJoin } from 'rxjs';
import { ImageService } from '../sevices/image.service';

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
  productImages: string[] = [];
  profileImages: string[] = [];

  constructor( private _profileService: ProfileService, private _authService: AuthService, private _postService:PostsService,
    private imageService: ImageService) { }

  ngOnInit(): void {
    this._profileService.getFollowingByUsername(this.username).subscribe(data => {
      this.following= data;
      const requests = this.following.map(user => {
        return this._postService.getAllPostsByUser(user.username);
      });
      forkJoin(requests).subscribe(data => {
        this.posts = data.flat();
        this.posts = this.posts.reverse();
        this.posts.forEach(post => {
          this.imageService.getPostImageUrl(post.id).subscribe(
            data => {
              post.imageUrl = data;
            }
          );
          this.imageService.getImageUrl(post.username).subscribe(
            data => {
              post.profileUrl = data;
            }
          );
        });
      });
    });

   
  }
}

