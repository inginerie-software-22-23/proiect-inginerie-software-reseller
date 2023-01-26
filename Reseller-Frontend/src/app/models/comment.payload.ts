import { User } from "./user";

export class CommentPayload {
    postId!: number;
    text: string = '';
    username:string = ''
}
