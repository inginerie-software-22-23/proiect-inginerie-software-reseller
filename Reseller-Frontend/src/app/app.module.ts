import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import {NgxWebstorageModule} from 'ngx-webstorage';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';
import { SignupComponent } from './signup/signup.component';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { HeaderComponent } from './header/header.component';
import { ProfileComponent } from './profile/profile.component';
import { HomeComponent } from './home/home.component';
import { ForYouComponent } from './for-you/for-you.component';
import { TokenInterceptor } from './token-interceptor.service';
import { PostTileComponent } from './post-tile/post-tile.component';
import { ViewPostComponent } from './post/view-post/view-post.component';
import { PostFormComponent } from './post/post-form/post-form.component';
import { MyProfileComponent } from './my-profile/my-profile.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {MatIconModule} from '@angular/material/icon';

import { ToastrModule } from 'ngx-toastr';
import { ProfileFormComponent } from './profile-form/profile-form.component';
import { FollowersListComponent } from './following-followers-list/follow-tile/followers-list/followers-list.component';
import { FollowingListComponent } from './following-followers-list/follow-tile/following-list/following-list.component';
import { WishlistComponent } from './wishlist/wishlist.component';
import { NotificationsComponent } from './notifications/notifications.component';
import { ChatsComponent } from './chats/chats.component';
import { MessagesComponent } from './messages/messages.component';
import { ForgotPasswordComponent } from './forgot-password/forgot-password.component';




@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    SignupComponent,
    HeaderComponent,
    ProfileComponent,
    HomeComponent,
    ForYouComponent,
    PostTileComponent,
    ViewPostComponent,
    PostFormComponent,
    MyProfileComponent,
    ProfileFormComponent,
    FollowersListComponent,
    FollowingListComponent,
    WishlistComponent,
    NotificationsComponent,
    ChatsComponent,
    MessagesComponent,
    ForgotPasswordComponent,

    
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    HttpClientModule,
    NgxWebstorageModule.forRoot(),
    BrowserAnimationsModule,
    MatIconModule,
    ToastrModule.forRoot(),

    

   
  ],
  providers: [{
    provide: HTTP_INTERCEPTORS,
    useClass: TokenInterceptor,
    multi: true
  }],
  bootstrap: [AppComponent]
})
export class AppModule { }
