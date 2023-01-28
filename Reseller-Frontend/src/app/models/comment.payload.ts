import { User } from "./user";

export class CommentPayload {
    commentId: number =0;
    postId!: number;
    text: string = '';
    username:string = '';
    url:string ='';
}
