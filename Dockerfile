FROM ruby:3.1.4

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN curl -sL https://deb.nodesource.com/setup_19.x | bash - \
    && wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y build-essential libpq-dev nodejs yarn sqlite3 libsqlite3-dev

RUN mkdir /app
WORKDIR /app

RUN gem install bundler
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY yarn.lock /app/yarn.lock
RUN bundle install
RUN yarn install

COPY . /app
RUN RAILS_ENV=production SECRET_KEY_BASE=dummy_key_for_build bundle exec rails assets:precompile

RUN chmod -R 777 /app/db
#RUN RAILS_ENV=production SECRET_KEY_BASE=dummy_key_for_build bundle exec rails db:prepare

#RUN RAILS_ENV=production SECRET_KEY_BASE=dummy_key_for_build bundle exec rails db:prepare

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["bundle", "exec", "rails", "s", "-p", "8080", "-b", "0.0.0.0"]
