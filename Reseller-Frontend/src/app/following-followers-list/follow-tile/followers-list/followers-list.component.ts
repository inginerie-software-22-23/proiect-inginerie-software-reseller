import { Component, Input } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/sevices/auth.service';
import { ImageService } from 'src/app/sevices/image.service';
import { ProfileService } from 'src/app/sevices/profile.service';

@Component({
  selector: 'app-followers-list',
  templateUrl: './followers-list.component.html',
  styleUrls: ['./followers-list.component.scss']
})
export class FollowersListComponent {
  followersList: User[]=[];

 

  username = this.route.snapshot.params['name'];

  constructor(private route: ActivatedRoute, private authServ:AuthService, private  _profileService:ProfileService, private _imageService: ImageService) {}

  ngOnInit() {
    console.log(this.username)
    this._profileService.getFollowersByUsername(this.username).subscribe((data: User[]) => {
     
      this.followersList = data;
      this.followersList.forEach(follower => {
        this._imageService.getImageUrl(follower.username).subscribe( data => {
          follower.imageUrl = data;
        })
      })
     
    });

  }

}
