FROM node:4.5.0

# Create a user called app
RUN useradd --user-group --create-home --shell /bin/false app && \
  npm install --global npm
ENV HOME=/home/app

# Copy application files to app folder
COPY package.json $HOME/library/
RUN chown -R app:app $HOME/*

# Set app as the user to run things and Initialize application dependencies 
USER app
WORKDIR $HOME/library
# RUN npm cache clean && npm install

# Copy application files from host directory
USER root
COPY . $HOME/library/
RUN chown -R app:app $HOME/*
USER app

CMD ["node", "index.js"]

