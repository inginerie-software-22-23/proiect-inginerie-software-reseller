import { Component, Input, SimpleChanges } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { User } from '../../models/user';
import { AuthService } from '../../sevices/auth.service';
import { ProfileService } from '../../sevices/profile.service';

@Component({
  selector: 'app-follow-tile',
  templateUrl: './follow-tile.component.html',
  styleUrls: ['./follow-tile.component.scss']
})
export class FollowTileComponent {
  followersList: User[]=[];
  followingList: User[]=[];
  @Input()currentList!: string;

  username= this.authServ.getUserName();

  constructor(private route: ActivatedRoute, private authServ:AuthService, private  _profileService:ProfileService) {}

  ngOnInit() {
    console.log(this.username)
    this.currentList = 'followers';
    this._profileService.getFollowersByUsername(this.username).subscribe((data: User[]) => {
     
      this.followersList = data;
     
    });

    this._profileService.getFollowingByUsername(this.username).subscribe((data: User[]) => {
      
      this.followingList = data;
      
    });
  }

  ngOnChanges(changes: SimpleChanges) {
    if (changes['followersList']) {
      this.followersList = changes['followersList'].currentValue;
    }
    if (changes['followingList']) {
      this.followingList = changes['followingList'].currentValue;
    }
    if (changes['currentList']) {
      this.currentList = changes['currentList'].currentValue;
    }
  }


}
