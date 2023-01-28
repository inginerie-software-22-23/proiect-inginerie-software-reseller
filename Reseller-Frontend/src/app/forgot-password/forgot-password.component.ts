import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { AuthService } from '../sevices/auth.service';

@Component({
  selector: 'app-forgot-password',
  templateUrl: './forgot-password.component.html',
  styleUrls: ['./forgot-password.component.scss']
})
export class ForgotPasswordComponent implements OnInit{
  emailForm!:FormGroup;
  email!:FormControl;

  constructor(private authService:AuthService) {
    this.emailForm = new FormGroup({ email: new FormControl(" ", Validators.required)})
  }

  sendEmail() {
    this.authService.forgotPassword(this.emailForm.get('email')?.value).subscribe( data => {
      console.log(data)
    })
  }

  ngOnInit(): void {
  
  }

}
