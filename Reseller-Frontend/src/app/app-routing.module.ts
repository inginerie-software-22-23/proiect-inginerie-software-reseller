import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ForYouComponent } from './for-you/for-you.component';
import { HomeComponent } from './home/home.component';
import { LoginComponent } from './login/login.component';
import { ProfileComponent } from './profile/profile.component';
import { SignupComponent } from './signup/signup.component';

const routes: Routes = [ {path: 'sign-up', component: SignupComponent},
{ path: 'login', component: LoginComponent },
{path: '', component: LoginComponent},
{path: 'home', component: HomeComponent},
{path: 'profile', component: ProfileComponent},
{path: 'for-you', component: ForYouComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
