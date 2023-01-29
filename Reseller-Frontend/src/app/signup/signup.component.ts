import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { SignupRequestPayload } from '../models/signup-request.payload';
import { AuthService } from '../sevices/auth.service';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.scss']
})
export class SignupComponent implements OnInit {

  signupForm!: FormGroup;
  signupRequestPayload!: SignupRequestPayload;

  constructor(private authService: AuthService, private router: Router) { 
    this.signupRequestPayload = {
      username: '',
      fullname: '',
      email: '',
      password: ''
    };
   }

  ngOnInit() {
    this.signupForm = new FormGroup({
      username: new FormControl('', Validators.required),
      fullname: new FormControl('', Validators.required),
      email: new FormControl('', [Validators.required, Validators.email]),
      password: new FormControl('', Validators.required)
    });
  }

  signup() {

    this.signupRequestPayload.username = this.signupForm.get('username')?.value;
    this.signupRequestPayload.fullname = this.signupForm.get('fullname')?.value;
    this.signupRequestPayload.email = this.signupForm.get('email')?.value;
    this.signupRequestPayload.password = this.signupForm.get('password')?.value;

    this.authService.signup(this.signupRequestPayload).subscribe(() => {
      console.log('Signup Successful');
      this.router.navigate(['/login']);
    }, () => {
      console.log('Signup Failed');
    });
  }


}
