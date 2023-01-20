export class PostModel {
    id: number =0;
    title: string ='';
    imageUrl: string ='';
    description: string | undefined;
    username: string | undefined;
    price: number | undefined;
    commentCount: number =0;
    likesCount: number =0;
    savedCount: number = 0;
}
