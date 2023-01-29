import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Component, OnInit} from '@angular/core';
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

export class ProfileFormComponent implements OnInit {
  editForm!: FormGroup;
  user: User = new User();
  username: String = '';
  newToken!: any;
  fileForm!: FormGroup;

  constructor(private _formBuilder: FormBuilder, private _profileService: ProfileService, private _router : Router, private _authService: AuthService,
    private localStorage: LocalStorageService, private http:HttpClient) {
    this.createForm()
    this.fileForm = this._formBuilder.group({
        file:  [null, Validators.required]
    })
  }

  ngOnInit() {
    this.username = this._authService.getUserName();
    this._profileService.getUserByUsername(this.username).subscribe(data => {
      this.user =  data;
      if(!!this.user) {
        this.editForm.patchValue(this.user);
      }
    })
  }
      
  createForm() {
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
      if (this.username === this.editForm.value.username) {     
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

     // this.uploadFile();
      
    // this.http.post('http://localhost:8070/api/profile/' + this.username + '/profile-picture', this.fileForm.value).subscribe(data=>{
    //   console.log(data);
    // });

      // postProfileImageUrl(image: File){
      //   return this._http.post<File>('http://localhost:8070/api/profile/' + username + '/profile-picture', image)
      // }
    }
  }

  onUsernameInput(textarea: HTMLTextAreaElement) {
    textarea.style.height = 'auto';
    textarea.style.height = textarea.scrollHeight - 14 + 'px';
  }
  onFullNameInput(textarea: HTMLTextAreaElement) {
    textarea.style.height = 'auto';
    textarea.style.height = textarea.scrollHeight - 14 + 'px';
  }
  onTextAreaInput(textarea: HTMLTextAreaElement) {
    textarea.style.height = 'auto';
    textarea.style.height = textarea.scrollHeight - 14 + 'px';
  }


  onFileChange(event: Event) {
    if (event.target instanceof HTMLInputElement && event.target.files && event.target.files.length > 0) {
      const file: File = event.target.files[0];
      this.fileForm.get('file')?.setValue(file);

      // create a new FileReader
      const reader = new FileReader();

      // read the file as a data URL
      reader.readAsDataURL(file);

      // when the file is loaded, set the form control value with the data URL
      reader.onload = () => {
        this.editForm.get('imageUrl')?.setValue(reader.result);
      };
    }
  }

  uploadFile() {
    const formData = new FormData();
    formData.append('file', this.fileForm.get('file')?.value);
    
    const headers = new HttpHeaders().set('Content-Type', 'multipart/form-data');
    this.http.post('http://localhost:8070/api/profile/' + this.username + '/profile-picture', formData, { headers: headers })
      .subscribe((response) => {
        console.log(response)
      });
  }
}