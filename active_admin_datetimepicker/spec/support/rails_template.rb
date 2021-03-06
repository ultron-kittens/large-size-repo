# Rails template to build the sample app for specs

generate :model, 'author name:string{10}:uniq last_name:string birthday:date'
generate :model, 'post title:string:uniq body:text author:references'

#Add validation
inject_into_file "app/models/author.rb", "  validates_presence_of :name\n  validates_uniqueness_of :last_name\n\n  attr_accessor :last_seen_at\n  ransacker :last_seen_at do\n    Arel.sql('updated_at')\n  end\n", after: "ApplicationRecord\n"
inject_into_file "app/models/post.rb", "   validates_presence_of :author\n", after: ":author\n"

# Configure default_url_options in test environment
inject_into_file "config/environments/test.rb", "  config.action_mailer.default_url_options = { :host => 'example.com' }\n", after: "config.cache_classes = true\n"

# Add our local Active Admin to the load path
inject_into_file "config/environment.rb",
                 "\n$LOAD_PATH.unshift('#{File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib'))}')\nrequire \"active_admin\"\n",
                 after: "require File.expand_path('../application', __FILE__)"

run "rm Gemfile"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

generate :'active_admin:install --skip-users'
generate :'formtastic:install'

# Install active_admin_date_time_datetimepicker assets
inject_into_file "app/assets/stylesheets/active_admin.scss",
                 "@import \"active_admin_datetimepicker\";\n",
                 after: "@import \"active_admin/base\";\n"

inject_into_file "app/assets/javascripts/active_admin.js",
                 "//= require active_admin_datetimepicker\n",
                 after: "//= require active_admin/base\n"

run "rm -r test"
run "rm -r spec"

route "root :to => 'admin/dashboard#index'"

rake "db:migrate"
