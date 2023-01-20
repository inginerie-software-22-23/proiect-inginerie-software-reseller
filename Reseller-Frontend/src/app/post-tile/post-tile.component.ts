import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { CommentPayload } from '../models/comment.payload';
import { PostModel } from '../models/post-model';
import { CommentsService } from '../sevices/comments.service';

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

  constructor(private router: Router) { }

  ngOnInit(): void {
  }

  goToPost(id: number): void {
    this.router.navigateByUrl('/view-post/' + id);
  }




 
}
