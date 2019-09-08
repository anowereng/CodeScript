# Basic Guide angular 

### Requiremnts

Prerequisites
Before you begin, make sure your development environment includes Node.js® ( https://www.npmjs.com/ ) and an npm package manager.

- Node.js Install ( To get Node.js, go to https://nodejs.org/ )
 Angular requires Node.js version 10.9.0 or later. To check your version, run ** node -v ** in a terminal/console window.
 
 - visualstudio IDE https://code.visualstudio.com/
 
1: Install the Angular CLI
 Install the Angular CLI globally.
 - npm install -g @angular/cli
 
2: Run the CLI command ng new and provide the name my-app, as shown here:
 -ng new my-app
 
3: Run the application
 -cd my-app
 -ng serve --open

![alt text](https://www.eclipse.org/community/eclipse_newsletter/2017/january/images/cli.png)

### Third Party NPM Install

**  Installing Bootstrap from NPM ** 

For Bootstrap 3 ( old version )
 -npm install bootstrap@3.3.7
 
 For Bootstrap  ( Recent version )
 -npm install bootstrap
 
 For Bootstrap required package
 
 -npm install bootstrap jquery popper -save 
Install popper.js: npm install popper.js@^1.12.3 --save
Install jQuery: npm install jquery@1.9.1 --save
 
> npm install font-awesome –save 
-  Importing the CSS
We have two options to import the CSS from Bootstrap that was installed from NPM:

> ###1: Configure angular.json:
    "styles": [
              "node_modules/bootstrap/dist/css/bootstrap.min.css"
               ,"./node_modules/font-awesome/css/font-awesome.min.css"
               ]
> ###2: Import directly in src/style.css or src/style.scss:
@import '~bootstrap/dist/css/bootstrap.min.css';
## bootstrap and jquery scripts
    "scripts": [
              "node_modules/jquery/dist/jquery.min.js",
              "node_modules/bootstrap/dist/js/bootstrap.min.js",
              "node_modules/popper.js/dist/umd/popper.min.js"
            ]

## Component Install

ng g c employee/create-employee --spec=false --flat=true

where employee is folder , The spec files are unit tests for your source files and flat=true ,When true creates the new files at the top level of the current project.

## seperated  route

 ng g m app-routing --flat=true --module=app

## Route Use
 1. const routes: Routes = [
  {path:'create', component: CreateEmployeeComponent},
  {path:'list', component: ListEmployeeComponent},
  {path:'', redirectTo:'/list', pathMatch:'full'},
];
where defualt route is **/list** when oroject start
 2. imports: [
    AppRoutingModule
  ],
Please confirm your **router module** add in app.module imports array
## Template Use
1. ng g c 
2. ``` <app-topbar></app-topbar>```
   ```<router-outlet></router-outlet>```
3.  ```<nav class="navbar navbar-expand-lg navbar-dark bg-dark"> 
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
  
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="#" routerLinkActive="active" routerLink="/list">Home <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Dropdown
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown">
            <a class="dropdown-item" href="#">Action</a>
            <a class="dropdown-item" href="#">Another action</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">Something else here</a>
          </div>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
        </li>
      </ul>
      <form class="form-inline my-2 my-lg-0">
        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
      </form>
    </div>
  </nav>  

   
