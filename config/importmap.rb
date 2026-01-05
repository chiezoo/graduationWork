pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

# カレンダー用（ここが重要！）
pin "fullcalendar", to: "https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"
