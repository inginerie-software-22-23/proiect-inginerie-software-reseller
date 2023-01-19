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
    MyProfileComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    HttpClientModule,
    NgxWebstorageModule.forRoot(),

    

   
  ],
  providers: [{
    provide: HTTP_INTERCEPTORS,
    useClass: TokenInterceptor,
    multi: true
  }],
  bootstrap: [AppComponent]
})
export class AppModule { }
