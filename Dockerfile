FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# nvmをインストール
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

# lts版のnodeをインストール
# RUN . $HOME/.nvm/nvm.sh && \
#     nvm install --lts && \
#     nvm use --lts && \
#     node -v && npm -v && \
#     npm i -g yarn

RUN mkdir /myapp
WORKDIR /myapp
RUN gem install solargraph
# ADD Gemfile /myapp/Gemfile
# ADD Gemfile.lock /myapp/Gemfile.lock
# RUN bundle install
ADD . /myapp

EXPOSE 7658