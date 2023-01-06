import { Component, OnInit } from '@angular/core';
import { PostModel } from '../models/post-model';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  post: PostModel | undefined;

  constructor() { }

  ngOnInit(): void {
  }

}
