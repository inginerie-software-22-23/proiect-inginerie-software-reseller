import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { LikePayload } from '../models/like.payload';

@Injectable({
  providedIn: 'root'
})
export class LikesService {

  constructor( private _http: HttpClient) { }

  postLike(likePayload: LikePayload): Observable<any> {
    return this._http.post<any>('http://localhost:8070/api/likes', likePayload);
  }
  postLikeForComment(likePayload: LikePayload): Observable<any> {
    return this._http.post<any>('http://localhost:8070/api/likes/comment', likePayload);
  }

  getAllLikesByUser(username: string) {
    return this._http.get<LikePayload[]>('http://localhost:8070/api/likes/by-user/' + username);
  }
  deleteLike(likeId: number) {
    return this._http.delete('http://localhost:8070/api/likes/'+likeId);
}

}
