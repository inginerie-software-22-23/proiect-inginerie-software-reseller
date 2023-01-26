export class NotificationPayload {
    text: string='';
    timestamp: any;
    senderId: number =-1;
    recipientId: number = -1
    post: boolean = false;
    postId: number = -1;
    url:string = '';
}
