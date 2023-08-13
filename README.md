# High-Level Breakdown

- Web Development: Design the Angular website.
- Infrastructure As Code: Update and extend your existing Bicep template and - parameters file.
- CI/CD Configuration: Adjust your GitHub actions for building, testing, and - deploying.
- Backend Development: Create Azure Functions and Azure SQL integration.
- Monitoring: Integrate Azure Monitor, Log Analytics, and Application Insights.

## 1. Angular Website Development

Here's a basic structure for the Angular web app:

```
src/
|-- app/
|   |-- landing-page/
|   |   |-- landing-page.component.html
|   |   |-- landing-page.component.ts
|   |   |-- landing-page.component.scss
|   |-- app.module.ts
|   |-- app.component.ts
|-- styles.scss
|-- index.html
|-- main.ts
```

In landing-page.component.html, you'd have your photo, name, tagline, and the buttons for LinkedIn, GitHub, resume download, blog, and contact form.

Install Node.js:
choco install nodejs

Verify the Installation:  
node -v
npm -v

1. Setting up the Angular Application

Install Angular CLI
npm install -g @angular/cli

create a new Angular app:
ng new app

Change into your project directory:
cd my-website

2. create components:
ng generate component landing
ng generate component contact-form

3. add a Simple Landing Page with your Information

in landing.component.html:
<div class="centered">
  <img src="path_to_your_photo.jpg" alt="Your name">
  <h1>Your Name</h1>
  <p>Your Tagline</p>
  
  <a href="https://linkedin.com/in/your-profile" target="_blank">LinkedIn</a>
  <a href="https://github.com/your-profile" target="_blank">GitHub</a>
  <a href="path_to_your_resume.pdf" target="_blank">Download Resume</a>
  <a href="https://linkedin.com/in/your-blog" target="_blank">Blog</a>
  <button (click)="showContactForm()">Contact Me</button>
</div>

In landing.component.ts:
import { Component } from '@angular/core';

@Component({
  selector: 'app-landing',
  templateUrl: './landing.component.html',
  styleUrls: ['./landing.component.css']
})
export class LandingComponent {

  showContactForm() {
    // Logic to show contact form or navigate to the contact form page
  }

}

For contact-form.component.html and contact-form.component.ts, you would have a basic form structure that collects the user's details and message. The form data would then be sent to your Azure Function (backend) which can then store it in the Azure SQL Database.

4. Styling and Dark Mode
  
For the dark mode colors and to make the elements centered, start with the following in landing.component.css:
.centered {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  background-color: #121212;
  color: #FFFFFF;
}

/* Add more styles for the links, button, and image */

For the Microsoft Learn Documentation-like font, use "Segoe UI". You'd include this in the global styles.css:
* {
  font-family: 'Segoe UI', sans-serif;
}

Once the basic app is set up and you're satisfied with its behavior locally, move onto integrating this with the Azure Static Web App Service

## 2. Infrastructure As Code 

You'll want to expand the existing main.bicep to include resources for:

- Azure Functions (backend)
- Azure SQL Database (backend data storage)
- Azure CDN
- Azure DNS Zone update
- Azure Key Vault (for storing secrets)
- Azure Monitor, Log Analytics, and Application Insights for monitoring

# -
# -
# -
# -
# -
# -
# -
# -
# -


# -
# Overview
This project uses GitHub Actions, Bicep, and Azure CLI to deploy a static web app to Azure.

```
  azure-static-web-apps-jolly-island-0b433f610.yml
                |
                v
           deploy.azcli
                |
                v
            main.bicep
                |
                v
          parameters.json
```

| File name                                        | Description               |
| ------------------------------------------------ | ------------------------- |
| azure-static-web-apps-jolly-island-0b433f610.yml | workflow file             |
| deploy.azcli                                     | deploys main.bicep        |
| main.bicep                                       | IaC template              |
| parameters.json                                  | Parameters for main.bicep |

# References

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Bicep Documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview)
- [Azure CLI Documentation](https://docs.microsoft.com/en-us/cli/azure/) 