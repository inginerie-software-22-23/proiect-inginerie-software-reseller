import { Component, Input } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/sevices/auth.service';
import { ProfileService } from 'src/app/sevices/profile.service';

@Component({
  selector: 'app-followers-list',
  templateUrl: './followers-list.component.html',
  styleUrls: ['./followers-list.component.scss']
})
export class FollowersListComponent {
  followersList: User[]=[];
  followingList: User[]=[];
 

  username = this.route.snapshot.params['name'];

  constructor(private route: ActivatedRoute, private authServ:AuthService, private  _profileService:ProfileService) {}

  ngOnInit() {
    console.log(this.username)
    this._profileService.getFollowersByUsername(this.username).subscribe((data: User[]) => {
     
      this.followersList = data;
     
    });

  }

}
