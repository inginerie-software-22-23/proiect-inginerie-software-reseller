import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ImageService {

  constructor(private _http:HttpClient) { }

  getImageUrl(username: string) {
    return this._http.get<string>('http://localhost:8070/api/profile/' + username + '/profile-picture', {responseType: 'text' as 'json'});
  }
}
