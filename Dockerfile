FROM ruby:2.7.5

EXPOSE 3000

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/test_rails_app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD bundle exec puma -C config/puma.rb
