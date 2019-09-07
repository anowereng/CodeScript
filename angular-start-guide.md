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
 
> npm install font-awesome –save 
>  Importing the CSS
We have two options to import the CSS from Bootstrap that was installed from NPM:

1: Configure angular.json:
    "styles": [
              "node_modules/bootstrap/dist/css/bootstrap.min.css"
               ,"./node_modules/font-awesome/css/font-awesome.min.css"
               ]
2: Import directly in src/style.css or src/style.scss:
@import '~bootstrap/dist/css/bootstrap.min.css';

   
