import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { Authguard } from './authguard';
import { ForYouComponent } from './for-you/for-you.component';
import { HomeComponent } from './home/home.component';
import { LoginComponent } from './login/login.component';
import { PostFormComponent } from './post/post-form/post-form.component';
import { ViewPostComponent } from './post/view-post/view-post.component';
import { ProfileComponent } from './profile/profile.component';
import { SignupComponent } from './signup/signup.component';

const routes: Routes = [ {path: 'sign-up', component: SignupComponent},
{ path: '', component: LoginComponent },
{ path: 'view-post/:id', component: ViewPostComponent },
{ path: 'user/:name', component: ProfileComponent, canActivate: [Authguard] },
//{ path: 'list-subreddits', component: ListSubredditsComponent },
{ path: 'create-post', component: PostFormComponent, canActivate: [Authguard] },
{ path: 'login', component: LoginComponent },
{path: 'home', component: HomeComponent},
{path: 'profile', component: ProfileComponent},
{path: 'for-you', component: ForYouComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
