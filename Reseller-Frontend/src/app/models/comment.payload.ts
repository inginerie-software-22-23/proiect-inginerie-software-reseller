export class CommentPayload {
    postId!: number;
    createdDate?: string;
    text: string = '';
    username?:string;
}
