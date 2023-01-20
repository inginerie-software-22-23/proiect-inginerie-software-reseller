import { Component, Input, OnInit } from '@angular/core';
import { PostModel } from '../models/post-model';
import { AuthService } from '../sevices/auth.service';
import { LikesService } from '../sevices/likes.service';
import { PostsService } from '../sevices/posts.service';
import { ToastrService } from 'ngx-toastr'
import { LikePayload } from '../models/like.payload';
import { throwError } from 'rxjs';

@Component({
  selector: 'app-like-button',
  templateUrl: './like-button.component.html',
  styleUrls: ['./like-button.component.scss']
})
export class LikeButtonComponent implements OnInit{

  @Input() post!: PostModel;
  likePayload!: LikePayload;
 

  isLoggedIn: boolean | undefined;
  
  
  constructor(private _likeService: LikesService,
    private _authService: AuthService,
    private _postService: PostsService, private toastr: ToastrService){

      this._authService.loggedIn.subscribe((data: boolean) => this.isLoggedIn = data);
    
  }
  ngOnInit(): void {
    this.updateLikeDetails();
  }

  like() {
    this.likePayload.postId = this.post.id;
    this._likeService.postLike(this.likePayload).subscribe(() => {
      this.updateLikeDetails();
      
    }, error => {
      this.toastr.error(error.error.message);
      throwError(error);
    });
  }

  private updateLikeDetails() {
    this._postService.getPost(this.post.id).subscribe(post => {
      this.post = post;
    });
  }

}
