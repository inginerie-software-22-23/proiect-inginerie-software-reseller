import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { debounceTime } from 'rxjs';
import { User } from '../models/user';
import { AuthService } from '../sevices/auth.service';
import { ProfileService } from '../sevices/profile.service';
import { SearchService } from '../sevices/search.service';

@Component({
  selector: 'app-search-profile',
  templateUrl: './search-profile.component.html',
  styleUrls: ['./search-profile.component.scss']
})
export class SearchProfileComponent implements OnInit {

  activeUser  = this.authService.getUserName();

  searchControl = new FormControl('');
  searchResults: User[] = [];
  allUsers:User[] = [];
  searchForm = new FormGroup({
    searchControl: this.searchControl
  });


  constructor(private _profileService:ProfileService, private _searchService:SearchService, private authService: AuthService ){}

  ngOnInit(): void {
    this.searchControl.valueChanges.pipe(debounceTime(1000)).subscribe(searchTerm => this.search());
    

  }
  search() {
    console.log(this.searchControl.value)
    if (this.searchControl.value != null){
      this._searchService.searchProfiles(this.searchControl.value).subscribe(results => {
        this.searchResults = results;
        console.log(results)
      });}
  }

}
