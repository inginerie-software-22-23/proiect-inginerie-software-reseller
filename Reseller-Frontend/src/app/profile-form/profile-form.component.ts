import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators, FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { LocalStorageService } from 'ngx-webstorage';
import { map, startWith, withLatestFrom } from 'rxjs';
import { User } from '../models/user';
import { AuthService } from '../sevices/auth.service';
import { ProfileService } from '../sevices/profile.service';

@Component({
  selector: 'app-profile-form',
  templateUrl: './profile-form.component.html',
  styleUrls: ['./profile-form.component.scss']
})
export class ProfileFormComponent implements OnInit{
  editForm!: FormGroup;
  user: User = new User();
  username: String = '';
  newToken!: any

  constructor(private _formBuilder: FormBuilder, private _profileService: ProfileService, private _router : Router, private _authService: AuthService,
    private localStorage: LocalStorageService) {
    this.createForm()
  }

  ngOnInit() {

      this.username = this._authService.getUserName();
      this._profileService.getUserByUsername(this.username).subscribe(data => {
        this.user =  data;
        if(!!this.user){
          this.editForm.patchValue(this.user);}

      })
   
      }
      
  createForm(){
    this.editForm = this._formBuilder.group({
      username: ['', Validators.required],
      fullName: ['', Validators.required],
      description: [''],
      imageUrl: [''],
      active: [true],
      });
  }
  saveUser() {
    
  if (this.editForm.valid) {
    
    if (this.username === this.editForm.value.username){
      
      this.editForm.value.username = "";
    
    }


      
    this._profileService.updateProfile(this.username, this.editForm.value).subscribe(data => {
      console.log(data)
      this.localStorage.store('authenticationToken', data.authenticationToken);
      this.localStorage.store('username', data.username);
      this.localStorage.store('refreshToken', data.refreshToken);
      this.localStorage.store('expiresAt', data.expiresAt);
      this._router.navigate(['/my-profile'])
    });

     
 


    }
     
    
    
    

  }}