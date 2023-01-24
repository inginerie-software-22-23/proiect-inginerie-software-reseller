import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { LikePayload } from '../models/like.payload';
import { SavedPayload } from '../models/saved.payload';

@Injectable({
  providedIn: 'root'
})
export class SavedService {


  constructor( private _http: HttpClient) { }

  postSave(savedPayload: SavedPayload): Observable<any> {
    return this._http.post<any>('http://localhost:8070/api/wishlist', savedPayload);
  }

  getAllSavesByUser(username: string) {
    return this._http.get<LikePayload[]>('http://localhost:8070/api/wishlist/by-user' + username);
  }
}
