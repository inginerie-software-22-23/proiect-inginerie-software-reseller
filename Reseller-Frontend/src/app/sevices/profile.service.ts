import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { User } from '../models/user';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class ProfileService {

  constructor(private httpClient: HttpClient, private authService: AuthService) { }

  getUserByUsername(username:String){
    //username= this.getUserName();
    return this.httpClient.get<User[]>('http://localhost:8070/api/profile/by-user/' + username) ;
  }
}
