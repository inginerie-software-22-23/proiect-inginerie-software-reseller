import { Component, Input } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/sevices/auth.service';
import { ProfileService } from 'src/app/sevices/profile.service';

@Component({
  selector: 'app-following-list',
  templateUrl: './following-list.component.html',
  styleUrls: ['./following-list.component.scss']
})
export class FollowingListComponent {
  followersList: User[]=[];
  followingList: User[]=[];


  username = this.route.snapshot.params['name'];


  constructor(private route: ActivatedRoute, private authServ:AuthService, private  _profileService:ProfileService) {}

  ngOnInit() {
    console.log(this.username)
   


    this._profileService.getFollowingByUsername(this.username).subscribe((data: User[]) => {
      
      this.followingList = data;
      
    });
  }

}
