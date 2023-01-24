import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { NotificationPayload } from '../models/notification.payload';

@Injectable({
  providedIn: 'root'
})
export class NotificationsService {

  constructor( private _http: HttpClient) { }
  getAllNotificationsByUser(username: string) {
    return this._http.get<NotificationPayload[]>('http://localhost:8070/api/notification/' + username);
  }

}
