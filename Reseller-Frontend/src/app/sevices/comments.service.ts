import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { CommentPayload } from '../models/comment.payload';

@Injectable({
  providedIn: 'root'
})
export class CommentsService {

  constructor(private _httpClient: HttpClient) { }

  getAllCommentsForPost(postId: number): Observable<CommentPayload[]> {
    return this._httpClient.get<CommentPayload[]>('http://localhost:8070/api/comment/by-post/' + postId);
  }

  postComment(commentPayload: CommentPayload): Observable<any> {
    return this._httpClient.post<any>('http://localhost:8070/api/comment', commentPayload);
  }

  getAllCommentsByUser(name: string) {
    return this._httpClient.get<CommentPayload[]>('http://localhost:8070/api/comment/by-user/' + name);
  }
}
