# Keycloak custom themes

## How to develop locally a new custom theme

To develop locally a new theme for keycloak, the general approach consists in:

1. Pull the keycloak production image to local docker registry
2. Run a standalone container with minimal configuration
3. Mount a copy of an example theme from the local filesystem in the container
4. Disable css cache
5. Load the custom image resources (the logos, the backgroung images, the favicon)
6. Edit locally the theme css files and property files to apply changes (restart container if necessary)
7. Verify changes in browser at localhost address, `http://localhost:8585`
8. Iterate steps 5-7 until custom theme is developed
9. Release custom theme in custom docker image, built from base image where custom theme files were added

### Develop (steps 1-8)

```bash
[> docker image prune --all --filter "until=504h"]
> docker pull docker.io/jboss/keycloak:12.0.4
> mkdir ulyssestheme
> echo Keycloak custom theme README > ulyssestheme/README.md
> docker run -d -p 8585:8080 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin -e KEYCLOAK_WELCOME_THEME=ulyssestheme -e KEYCLOAK_DEFAULT_THEME=ulyssestheme --mount type=bind,source=/home/guillaume/keycloak-theme/ulyssestheme,target=/opt/jboss/keycloak/themes/ulyssestheme docker.io/jboss/keycloak:12.0.4
> docker exec -it a4e335ff5520fc75f40916243dcd319027ddb749484b148cec2cbecab28dca73 bash
> cd /opt/jboss/keycloak/themes
> cp -R keycloak/\* ulyssestheme
> cat /opt/jboss/keycloak/standalone/configuration/standalone.xml | grep -A2 staticMaxAge
> sed -i -e 's/cacheThemes>true/cacheThemes>false/' /opt/jboss/keycloak/standalone/configuration/standalone.xml
> sed -i -e 's/cacheTemplates>true/cacheTemplates>false/' /opt/jboss/keycloak/standalone/configuration/standalone.xml
> sed -i -e 's/staticMaxAge>2592000/staticMaxAge>-1/' /opt/jboss/keycloak/standalone/configuration/standalone.xml
> cat /opt/jboss/keycloak/standalone/configuration/standalone.xml | grep -A2 staticMaxAge
> Copy custom images to `/home/guillaume/keycloak-theme/ulyssestheme`
> edit the ulyssestheme css files and property files
> cp ulyssestheme/common/resources/img/favicon.ico keycloak/common/resources/img/.
```

Open browser at `http://localhost:8585` and login with user `admin` and pass `admin`.
Create a new realm `ulysses` and a new user `test` for the realm.
Test the new user login for the realm-management application and for the account-management application.

### Release (step 9)
