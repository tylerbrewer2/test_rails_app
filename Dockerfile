FROM ruby:2.7.5

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/test_rails_app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN  bundle exec puma -C config/puma.rb
EXPOSE 3000