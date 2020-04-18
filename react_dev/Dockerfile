FROM web-js

WORKDIR /bin/bash

COPY package.json .
#installs all needed packages from package.json
RUN npm install
CMD ["npm", "start"]
