import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { FollowPayload } from '../models/follow.payload';
import { LikePayload } from '../models/like.payload';

@Injectable({
  providedIn: 'root'
})
export class FollowService {

  constructor(private _http: HttpClient) { }

  postFollow(followPayload: FollowPayload): Observable<any> {
    return this._http.post<any>('http://localhost:8070/api/follow', followPayload , {responseType: 'text' as 'json'});
  }

  deleteFollow(userId: number) {
    return this._http.delete('http://localhost:8070/api/follow/'+userId,  {responseType: 'text' as 'json'});
}
}
