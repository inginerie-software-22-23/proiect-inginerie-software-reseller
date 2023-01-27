import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { PostModel } from '../models/post-model';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root'
})
export class SearchService {

  constructor(private http: HttpClient) { }

  searchPosts(term: string): Observable<PostModel[]> {
    return this.http.get<PostModel[]>("http://localhost:8070/api/search/post/" + term);
  }
  searchProfiles(term: string): Observable<User[]> {
    return this.http.get<User[]>("http://localhost:8070/api/search/profile/" + term);
  }
}
