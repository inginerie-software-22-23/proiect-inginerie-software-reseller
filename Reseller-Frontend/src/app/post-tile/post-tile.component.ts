import { HttpClient } from '@angular/common/http';
import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { CommentPayload } from '../models/comment.payload';
import { LikePayload } from '../models/like.payload';
import { PostModel } from '../models/post-model';
import { CommentsService } from '../sevices/comments.service';
import { LikesService } from '../sevices/likes.service';

@Component({
  selector: 'app-post-tile',
  templateUrl: './post-tile.component.html',
  styleUrls: ['./post-tile.component.scss']
})
export class PostTileComponent implements OnInit {

  @Input() posts: PostModel[] = [];
  commentService!: CommentsService;
  comments: CommentPayload[] = [] ;
  noOfComments: number = 0;
  likePayload!: LikePayload;
  

  constructor(private _router: Router,private _http: HttpClient) {

   }

  ngOnInit(): void {
  }

  goToPost(id: number): void {
    this._router.navigateByUrl('/view-post/' + id);
  }





 
}
