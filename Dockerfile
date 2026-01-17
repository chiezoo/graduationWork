FROM ruby:3.1.4

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
# 本番環境であることを明示
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true

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
# yarn.lockがない場合はコメントアウトするか空ファイルを作ってください
# COPY yarn.lock /app/yarn.lock 
RUN bundle install
# RUN yarn install # yarn.lockがない場合はこれも不要な場合があります

# --- ここが重要：先にすべてのファイルをコピーしてからプリコンパイルする ---
COPY . /app

# デザインファイルを本番用にまとめる（SECRET_KEY_BASEが必要です）
RUN SECRET_KEY_BASE=dummy_key_for_build bundle exec rails assets:precompile

RUN chmod -R 777 /app/db

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# 起動時にDBを作成（migrate）してからサーバーを立てる（CMDは一番最後の1つだけ有効です）
CMD ["sh", "-c", "bundle exec rails db:migrate RAILS_ENV=production && bundle exec rails server -b 0.0.0.0 -p 8080"]
