import { Component, OnInit } from '@angular/core';
import { NotificationPayload } from '../models/notification.payload';
import { AuthService } from '../sevices/auth.service';
import { ImageService } from '../sevices/image.service';
import { NotificationsService } from '../sevices/notifications.service';
import { PostsService } from '../sevices/posts.service';

@Component({
  selector: 'app-notifications',
  templateUrl: './notifications.component.html',
  styleUrls: ['./notifications.component.scss']
})
export class NotificationsComponent implements OnInit{

  notificationList: NotificationPayload [] = [new NotificationPayload];
  username = this._authService.getUserName();
  notifications: number = 0;

  constructor(private _notificationService: NotificationsService, private _authService: AuthService, private _imageService: ImageService){}

  ngOnInit(): void {
    
    this._notificationService.getAllNotificationsByUser(this.username).subscribe(data => {
      this.notificationList = data;
      this.notifications = data.length;
      this.notificationList.forEach(notif => {
        this._imageService.getImageUrl(notif.text.split(" ")[0]).subscribe(
          data => {
            notif.url = data;
          }
        );
      });
    })
  }

}
