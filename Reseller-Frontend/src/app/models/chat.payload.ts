import { MessagePayload } from "./message.payload"
import { User } from "./user";

export class ChatPayload {
    id: number=0;
    firstUserId: number =-1;
    secondUserId: number = -1;
    messages: MessagePayload[] = []
    sender: User = new User;
}
