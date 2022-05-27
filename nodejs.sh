# install nodejs
sudo apt install nodejs

# install npm
sudo apt install npm    # to run js apps locally

# install all project dependencies
# navigate to app's folder
npm install
npm install -g nodemon  # nodemon is a utility that will monitor for any changes in your source and automatically restart your server

# run js app
node app.js
nodemon app.js  # run app in nodemon mode