import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { map, Observable, of, tap } from 'rxjs';
import { LoginResponse } from '../models/login-response';
import { User } from '../models/user';
import { AuthService } from './auth.service';
const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json',
   
  })
};

@Injectable({
  providedIn: 'root'
})

export class ProfileService {
  private users = new Map<number, User>();

  

  constructor(private httpClient: HttpClient, private authService: AuthService) { }

  getUserByUsername(username:String) {
 
    return this.httpClient.get<User>('http://localhost:8070/api/profile/' + username) ;
  }
  getFollowersByUsername(username:String){
    return this.httpClient.get<User[]>('http://localhost:8070/api/profile/' + username + '/followers') ;
  }

  getFollowingByUsername(username:String){
    return this.httpClient.get<User[]>('http://localhost:8070/api/profile/' + username + '/following') ;
  }

  updateProfile(username: String, user: User) {
    return this.httpClient.put<LoginResponse>('http://localhost:8070/api/profile/' + username + '/edit', user)
  }

  getUserById(id:number):Observable<User>{
    return this.httpClient.get<User>('http://localhost:8070/api/profile/id/' + id)
  }
  
}
