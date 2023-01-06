import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { LoginRequestPayload } from '../models/login-request.payload';
import { AuthService } from '../sevices/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  loginForm!: FormGroup;
  loginRequestPayload!: LoginRequestPayload;
isError: any;

  constructor(private authService: AuthService, private router: Router) {
    this.loginRequestPayload = {
      username: '',
      password: ''
    };
  }

  ngOnInit() {
    this.loginForm = new FormGroup({
      username: new FormControl('', Validators.required),
      password: new FormControl('', Validators.required)
    });
  }

  login() {
    this.loginRequestPayload.username = this.loginForm.get('username')?.value;
    this.loginRequestPayload.password = this.loginForm.get('password')?.value;

    this.authService.login(this.loginRequestPayload).subscribe(data => {
      console.log('Login successful');
      
      
      this.router.navigate(['/home']);

    },

    );
  }
}
