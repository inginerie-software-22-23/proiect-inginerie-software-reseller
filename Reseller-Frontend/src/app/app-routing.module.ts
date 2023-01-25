import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { Authguard } from './authguard';
import { FollowTileComponent } from './following-followers-list/follow-tile/follow-tile.component';
import { FollowersListComponent } from './following-followers-list/follow-tile/followers-list/followers-list.component';
import { FollowingListComponent } from './following-followers-list/follow-tile/following-list/following-list.component';
import { ForYouComponent } from './for-you/for-you.component';
import { HomeComponent } from './home/home.component';
import { LoginComponent } from './login/login.component';
import { MyProfileComponent } from './my-profile/my-profile.component';
import { NotificationsComponent } from './notifications/notifications.component';
import { PostFormComponent } from './post/post-form/post-form.component';
import { ViewPostComponent } from './post/view-post/view-post.component';
import { ProfileFormComponent } from './profile-form/profile-form.component';
import { ProfileComponent } from './profile/profile.component';
import { SignupComponent } from './signup/signup.component';
import { WishlistComponent } from './wishlist/wishlist.component';

const routes: Routes = [ {path: 'sign-up', component: SignupComponent},
{ path: '', component: LoginComponent },
{ path: 'view-post/:id', component: ViewPostComponent },
{ path: 'user/:name', component: ProfileComponent, canActivate: [Authguard] },
{ path: 'my-profile', component: MyProfileComponent },
{ path: 'create-post', component: PostFormComponent, canActivate: [Authguard] },
{ path: 'login', component: LoginComponent },
{path: 'home', component: HomeComponent},
{path: 'profile', component: ProfileComponent},
{path: 'for-you', component: ForYouComponent},
{ path: 'create-post', component: PostFormComponent, canActivate: [Authguard] },
{path:'following-list', component: FollowingListComponent},
{path: 'followers-list', component: FollowersListComponent},
{path: 'notifications', component: NotificationsComponent},
{path: 'wishlist', component: WishlistComponent},
{path: 'edit/:name', component: ProfileFormComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
