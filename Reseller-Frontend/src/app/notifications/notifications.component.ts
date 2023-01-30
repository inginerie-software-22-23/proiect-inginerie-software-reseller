import { Component, OnInit } from '@angular/core';
import { NotificationPayload } from '../models/notification.payload';
import { AuthService } from '../sevices/auth.service';
import { ImageService } from '../sevices/image.service';
import { NotificationsService } from '../sevices/notifications.service';
import { PostsService } from '../sevices/posts.service';
import { ProfileService } from '../sevices/profile.service';

@Component({
  selector: 'app-notifications',
  templateUrl: './notifications.component.html',
  styleUrls: ['./notifications.component.scss']
})
export class NotificationsComponent implements OnInit{

  notificationList: NotificationPayload [] = [new NotificationPayload];
  username = this._authService.getUserName();
  notifications: number = 0;
  notifUsername:string = '';

  constructor(private _notificationService: NotificationsService, private _authService: AuthService,
     private _imageService: ImageService, private _profileService:ProfileService){}

  ngOnInit(): void {
    
    this._notificationService.getAllNotificationsByUser(this.username).subscribe(data => {
      this.notificationList = data;
      this.notificationList = this.notificationList.reverse();
      this.notifications = data.length;
      this.notificationList.forEach(notif => {
        this._imageService.getImageUrl(notif.text.split(" ")[0]).subscribe(
          data => {
            notif.url = data;
            let message = notif.text;
            let username = message.split(" ")[0];
            notif.username = username;
          }
        );

        if (notif.post == true) {
          this._imageService.getPostImageUrl(notif.postId).subscribe(
            data => {
              notif.postUrl = data;
            }
          )
        }
      });


    })
   
  }

}
