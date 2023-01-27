export class User {
    profileId: number = 0;
    username: string='';
    fullName: string='';
    description: string = '';
    imageUrl: string = '';
    active!: boolean;
    userId!: number;
}
