# Introduction
This is project is a simple Azure Static Web App that runs my personal website. The front end is a single-page HTML and CSS template and the credit goes to [AJ](https://aj.lkn.io/) @ [HTML5UP](https://html5up.net/). 

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